import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bek/domain/remote_repository.dart';
import '../../bek/domain/resource.dart';
import '../../bek/entites/Reestr.dart';
import '../../bek/entites/data_item.dart';
import '../../bek/entites/data_reestr.dart';

class StatisticViewModel extends ChangeNotifier {
  final RemoteRepository repository = RemoteRepository();
  List<DataItem> dataItems = [];
  String userName = "Имя фамилия"; // Замените на фактические данные пользователя
  String workType = "Вид работы"; // Замените на фактические данные пользователя
  bool isLoading = true;
  bool isError = false;

  StatisticViewModel() {
    fetchData(); // Исправленный вызов метода
    getUserData(); // Получение данных пользователя
  }

  Future<void> fetchData() async {
    try {
      final token = "Bearer ${await _getToken()}"; // Получение токена
      final resource = await repository.getReestr(token); // Вызов метода для получения данных

      if (resource is Success<List<DataReestr>>) {
        dataItems = resource.data.expand((dataReestr) {
          final items = dataReestr.data ?? [];
          return items;
        }).toList();
        isLoading = false;
        isError = false;
      } else if (resource is Error) {
        isLoading = false;
        isError = true;
      }
      notifyListeners(); // Уведомление об изменениях
    } catch (error) {
      isLoading = false;
      isError = true;
      notifyListeners(); // Уведомление об ошибках
    }
  }

  Future<void> getUserData() async {
    try {
      final token = "Bearer ${await _getToken()}"; // Получение токена
      final resource = await repository.getUserData(token); // Вызов метода для получения данных пользователя

      if (resource is Success<ResultData>) {
        userName = "${resource.data.firstName} ${resource.data.lastName}"; // Замените на актуальные поля
        workType = resource.data.position; // Замените на актуальные поля
      } else if (resource is Error) {
        isError = true; // Отображение ошибки
      }
      notifyListeners(); // Уведомление об изменениях
    } catch (error) {
      isError = true; // Отображение ошибки
      notifyListeners(); // Уведомление об ошибках
    }
  }

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('password') ?? '';
  }
}
