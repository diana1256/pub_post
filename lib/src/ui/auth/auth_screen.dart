import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/home_sreen.dart';
import '../utils/pref.dart';
import 'auth.dart';

class AuthScreen extends StatelessWidget {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(); // Отображаем индикатор загрузки
        }

        // Инициализация Pref с данными SharedPreferences
        final pref = Pref(snapshot.data as SharedPreferences);

        return ChangeNotifierProvider(
          create: (context) => AuthModel(pref),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<AuthModel>(
                  builder: (context, authModel, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 70.0),
                        Container(
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/dcfgg.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 90.0),
                        TextField(
                          controller: _loginController,
                          decoration: InputDecoration(
                            labelText: 'Введите номер',
                            labelStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF2879F1), width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF2879F1), width: 2.0),
                            ),
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 25.0),
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Введите пароль',
                            labelStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF2879F1), width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF2879F1), width: 2.0),
                            ),
                          ),
                          obscureText: true,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 40.0),
                        ElevatedButton(
                          onPressed: authModel.isLoading
                              ? null
                              : () async {
                            await authModel.login(
                              _loginController.text,
                              _passwordController.text,
                            );
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) =>  HomeScreen()),
                            );
                            if (authModel.isAuthenticated) {
                              ///переход
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF007BFD),
                            minimumSize: Size(240, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Text(
                            'Войти',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        if (authModel.isLoading)
                          Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2879F1)),
                              strokeWidth: 7,
                            ),
                          ),
                        if (authModel.errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              authModel.errorMessage!,
                              style: TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        SizedBox(height: 170.0),
                        Text(
                          'Учёт рабочего времени ОАО "Кыргыз почтасы"',
                          style: TextStyle(
                            color: Color(0xFF2879F1),
                            fontSize: 19,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
