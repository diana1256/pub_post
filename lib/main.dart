import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:PostTime/src/bek/domain/remote_repository.dart';
import 'package:PostTime/src/ui/auth/auth_screen.dart';
import 'package:PostTime/src/ui/home/home.dart';
import 'package:PostTime/src/ui/home/home_sreen.dart';
import 'package:PostTime/src/ui/scaner/scanner_screen.dart';
import 'package:PostTime/src/ui/utils/GpsUtils.dart';
import 'package:PostTime/src/ui/utils/pref.dart';
import 'package:PostTime/src/ui/week/week.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart' as yandex;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AndroidYandexMap.useAndroidViewSurface = false;

  // Инициализация Firebase
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDYAcMigLFeuROre00VNiaWYRcV2sT4VmY",
        authDomain: "posttime-aa82a.firebaseapp.com",
        projectId: "posttime-aa82a",
        storageBucket: "posttime-aa82a.appspot.com",
        messagingSenderId: "101130808072",
        appId: "1:101130808072:web:02129212b08f27d4f69abd",
        measurementId: "G-SLV34KQXBV",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Pref> _initializePref() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return Pref(sharedPreferences);
  }

  @override
  Widget build(BuildContext context) {
    final attendanceRef = FirebaseDatabase.instance.ref().child("attendance");
    final gpsUtils = GpsUtils(context); // Passing context to GpsUtils
    final repository = RemoteRepository();

    return FutureBuilder<Pref>(
      future: _initializePref(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => HomeLogic(
                pref: snapshot.data!,
                attendanceRef: attendanceRef,
                gpsUtils: gpsUtils,
                repository: repository,
              ),
            ),
            ChangeNotifierProvider(create: (_) => WeekViewModel()),
          ],
          child: MaterialApp(
            title: 'Your App',
            initialRoute: '/',
            routes: {
              '/': (context) => AuthScreen(), // Initial authentication screen
              '/HomeScreen': (context) => HomeScreen(),
              '/ScannerScreen': (context) => ScannerScreen(),
            },
          ),
        );
      },
    );
  }
}


