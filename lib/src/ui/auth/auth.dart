import 'package:flutter/material.dart';
import '../../bek/domain/remote_repository.dart';
import '../utils/pref.dart';


class AuthModel with ChangeNotifier {
  final Pref pref; // Добавляем экземпляр Pref
  bool _isLoading = false;
  bool _isAuthenticated = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  String? get errorMessage => _errorMessage;

  AuthModel(this.pref); // Принимаем Pref через конструктор

  Future<void> login(String login, String password) async {
    _isLoading = true;
    notifyListeners();

    final resource = await RemoteRepository().login(login, password);
    resource.when(
      success: (data) async {
        _isLoading = false;
        _errorMessage = null;
        _isAuthenticated = true;

        // Сохраняем данные после успешного входа
        await pref.setLogin(login);
        await pref.setPassword(data.token);
        await pref.setRemote(data.remote); // Или значение в зависимости от логики
        await pref.setBoardingShowed(true);
        await pref.setPasswor(password);
        await pref.setId(data.id.toString());
        notifyListeners();
      },
      error: (message) {
        _isLoading = false;
        _errorMessage = message;
        _isAuthenticated = false;
        notifyListeners();
      },
      loading: () {},
    );
  }
}