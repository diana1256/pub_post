import 'package:flutter/material.dart';
import '../../bek/domain/remote_repository.dart';
import '../../bek/entites/data_item.dart';

class WeekViewModel with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  List<DataItem>? _dataItems;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<DataItem>? get dataItems => _dataItems;

  Future<void> fetchWeekData(String token) async {
    _isLoading = true;
    notifyListeners();

    try {
      final currentDate = DateTime.now();
      final startDate = DateTime(currentDate.year, currentDate.month, currentDate.day - (DateTime.now().weekday - 1)); // Понедельник
      final endDate = startDate.add(Duration(days: 6)); // Воскресенье

      final resource = await RemoteRepository().getRees(token, 7, startDate.toIso8601String(), endDate.toIso8601String());

      resource.when(
        success: (data) {
          _dataItems = data.cast<DataItem>();
          _errorMessage = null;
        },
        error: (message) {
          _errorMessage = message;
        },
        loading: () {
          // Загрузка уже обрабатывается выше
        },
      );
    } catch (e) {
      _errorMessage = "Произошла ошибка: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

