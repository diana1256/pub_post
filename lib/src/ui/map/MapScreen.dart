import 'dart:math';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart' as yandex;
import 'package:fluttertoast/fluttertoast.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late yandex.YandexMapController mapController;
  Location location = Location();
  bool isFragmentTransactionExecuted = false;
  bool isLoading = true;
  final yandex.Point targetLocation = yandex.Point(latitude: 42.886804, longitude:74.506961);
//42.876815,74.592473455
  @override
  void initState() {
    super.initState();
    _checkGps();
  }

  Future<void> _checkGps() async {
    if (await location.serviceEnabled() || await location.requestService()) {
      _checkPermissions();
    } else {
      Fluttertoast.showToast(msg: "Please enable GPS");
    }
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }
    _getLocationUpdates();
  }

  void _getLocationUpdates() {
    location.onLocationChanged.listen((LocationData? currentLocation) {
      if (currentLocation == null) return; // Проверка, чтобы избежать null

      final yandex.Point userLocation = yandex.Point(
          latitude: currentLocation.latitude!,
          longitude: currentLocation.longitude!
      );

      // Проверка локации только если `isFragmentTransactionExecuted` равно false
      if (!isFragmentTransactionExecuted) {
        if (_isWithinRadius(userLocation, targetLocation, 80.0)) {
          setState(() {
            isFragmentTransactionExecuted = true; // Предотвращение повторной навигации
          });
          Navigator.pushNamed(context, '/ScannerScreen').then((_) {
            setState(() {
              isFragmentTransactionExecuted = false; // Сброс после возврата
            });
          });
        } else {
          Fluttertoast.showToast(msg: "Вы находитесь не в указанном месте");
        }
      }
      setState(() {
        isLoading = false; // Отключение индикатора загрузки
      });
    });
  }

  bool _isWithinRadius(yandex.Point userLocation, yandex.Point targetLocation, double radius) {
    double distance = _calculateDistance(userLocation, targetLocation);
    return distance <= radius;
  }

  double _calculateDistance(yandex.Point start, yandex.Point end) {
    const double earthRadius = 6371;
    double dLat = _degreesToRadians(end.latitude - start.latitude);
    double dLng = _degreesToRadians(end.longitude - start.longitude);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(start.latitude)) *
            cos(_degreesToRadians(end.latitude)) *
            sin(dLng / 2) * sin(dLng / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c * 1000; // Возвращаем расстояние в метрах
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Карта'),
      ),
      body: Stack(
        children: [
          yandex.YandexMap(
            onMapCreated: (yandex.YandexMapController controller) {
              mapController = controller;
              mapController.moveCamera(
                yandex.CameraUpdate.newCameraPosition(
                  yandex.CameraPosition(target: targetLocation, zoom: 14.0),
                ),
                animation: const yandex.MapAnimation(type: yandex.MapAnimationType.smooth, duration: 1.5),
              );
            },
            mapObjects: [
              yandex.PlacemarkMapObject(
                mapId: yandex.MapObjectId('target_placemark'),
                point: targetLocation,
                icon: yandex.PlacemarkIcon.single(
                  yandex.PlacemarkIconStyle(
                    image: yandex.BitmapDescriptor.fromAssetImage('assets/target_icon.png'), // Убедитесь, что изображение существует в папке assets
                    scale: 0.5,
                  ),
                ),
              ),
            ],
          ),
          if (isLoading)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2879F1)),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Вычисляем ваше местоположение',
                    style: TextStyle(color: Color(0xFF2879F1), fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
