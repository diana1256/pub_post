import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:PostTime/src/ui/home/home_sreen.dart';
import '../../bek/domain/remote_repository.dart';
import '../../bek/domain/resource.dart';
import '../../bek/entites/Reestr.dart';
import '../utils/GpsUtils.dart';
import '../utils/pref.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class HomeLogic with ChangeNotifier {
  final Pref pref; // Добавляем экземпляр Pref
  final DatabaseReference attendanceRef;
  final GpsUtils gpsUtils;
  final RemoteRepository repository;
  bool isLoading = false; // Добавлен флаг загрузки

  HomeLogic({
    required this.pref,
    required this.attendanceRef,
    required this.gpsUtils,
    required this.repository,
  });

  String userName = '';
  String userPosition = '';
  String getDatabaseSafeDate() => DateFormat('dd_MM_yyyy').format(DateTime.now());
  String getCurrentDate() => DateFormat('dd.MM.yyyy').format(DateTime.now());
  String getCurrentTime() => DateFormat('HH:mm').format(DateTime.now());

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> loadUserData(BuildContext context, String token) async {
    setLoading(true);
    final result = await repository.getUserData(token); // Вызов метода для получения данных пользователя
    setLoading(false);

    if (result is  Success<ResultData>) {
      userName = "${result.data.lastName} ${result.data.firstName}" ?? 'Имя Фамилия'; // Access name from ResultData
      userPosition = result.data.position ?? 'Начальник самоуправления'; // Access position from ResultData
      notifyListeners(); // Update UI
      showSnackBar(context, "Данные успешно загружены");
    } else if (result is Error) {
      showSnackBar(context, "Ошибка загрузки данных пользователя: ${result.message}");
    }
  }

  String md5We(String input) {
    final bytes = utf8.encode(input); // Convert input to bytes
    final digest = md5.convert(bytes); // Compute MD5 hash
    return digest.toString(); // Convert to hexadecimal format
  }


  Future<void> QRcode(BuildContext context, String scannedCode) async {
    setLoading(true);

    // Get the QR code data
    final qrCodeResult = await repository.getQRCode(scannedCode);
    setLoading(false);

    if (qrCodeResult is Success) {
      // Calculate current date for hashing
      final currentDate = getCurrentDate();

      // Hash the scanned code and current date together
      final String input = '${scannedCode}_$currentDate';
      final String hashed = md5We(input);

      // Create a request body with the hashed result
      final Map<String, dynamic> requestBody = {
        "token": hashed,
      };

      setLoading(true);
      final result = await repository.postCameGone(requestBody, "Bearer ${pref.isPassword()}"); // Assuming authorization token here
      setLoading(false);

      if (result is Success) {
        submitAttendanceData(context);
        showSnackBar(context, "Присутствие отмечено");
      } else if (result is Error) {
        showSnackBar(context, "Ошибка отметки: ${result.message}");
      }
    } else if (qrCodeResult is Error) {
      showSnackBar(context, "Ошибка отметки: ${qrCodeResult.message}");
    }
  }

  Future<void> requestRemoteAccess(BuildContext context, String authorization) async {
    setLoading(true);
    final result = await repository.postRemote( authorization);
    setLoading(false);
    if (result is Success) {
      showSnackBar(context, "Удалёнка успешно отмечена");
    } else if (result is Error) {
      showSnackBar(context, "Ошибка: ${result.message}");
    }
  }

  Future<void> showSnackBar(BuildContext context, String message) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }
    return status.isGranted;
  }

  Future<bool> requestLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      status = await Permission.location.request();
    }
    return status.isGranted;
  }

  Future<void> submitAttendanceData(BuildContext context) async {
    final String currentDate = getDatabaseSafeDate();
    try {
      final snapshot = await attendanceRef.child(currentDate).get();
      int status = 1; // Start of the day

      if (snapshot.exists) {
        status = snapshot.value as int;
        if (status == 2) { // End of the day already marked
          showSnackBar(context, "Вы уже отметились сегодня");
          return;
        }
        // Change status to 2 for end of the day
        status = 2;
      }

      await attendanceRef.child(currentDate).set(status);
      final displayDate = getCurrentDate();
      final displayTime = getCurrentTime();

      // Determine dialog title based on status
      String title = (status == 1) ? 'Начало рабочего дня' : 'Конец рабочего дня';

      _showCustomDialog(context, title, displayDate, displayTime);
    } catch (e) {
      showSnackBar(context, "Ошибка отправки данных: $e");
    }
  }
  void _showCustomDialog(BuildContext context, String title, String date, String time) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomLayoutDialog(
          title: title,
          date: date,
          time: time,
        );
      },
    );
  }
}
