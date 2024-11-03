import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  final SharedPreferences _sharedPreferences;

  Pref(this._sharedPreferences);

  String isLogin() {
    return _sharedPreferences.getString("login") ?? "";
  }

  Future<void> setLogin(String login) async {
    await _sharedPreferences.setString("login", login);
  }

  String isPassword() {
    return _sharedPreferences.getString("password") ?? "";
  }

  Future<void> setPassword(String password) async {
    await _sharedPreferences.setString("password", password);
  }

  String isPasswor() {
    return _sharedPreferences.getString("userpassss") ?? "";
  }

  Future<void> setPasswor(String password) async {
    await _sharedPreferences.setString("userpassss", password);
  }

  String isId() {
    return _sharedPreferences.getString("attendance") ?? "";
  }

  Future<void> setId(String id) async {
    await _sharedPreferences.setString("attendance", id);
  }

  bool isBoardingShowed() {
    return _sharedPreferences.getBool("board") ?? false;
  }

  Future<void> setBoardingShowed(bool isShown) async {
    await _sharedPreferences.setBool("board", isShown);
  }

  Future<void> setRemote(bool isRemote) async {
    await _sharedPreferences.setBool("remote", isRemote);
  }

  bool isRemote() {
    return _sharedPreferences.getBool("remote") ?? false;
  }

  Future<void> setPin(bool isPin) async {
    await _sharedPreferences.setBool("remotepin", isPin);
  }

  bool isPin() {
    return _sharedPreferences.getBool("remotepin") ?? false;
  }

  Future<void> userPassword(String password) async {
    await _sharedPreferences.setString("userpassss", password);
  }

  String isUserPassword() {
    return _sharedPreferences.getString("userpassss") ?? "";
  }

  Future<void> userPin(String password) async {
    await _sharedPreferences.setString("pincode", password);
  }

  String isUserPin() {
    return _sharedPreferences.getString("pincode") ?? "";
  }
}
