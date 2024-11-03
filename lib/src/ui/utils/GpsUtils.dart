import 'package:flutter/material.dart';
import 'package:location/location.dart';


class GpsUtils {
  final BuildContext context;

  GpsUtils(this.context);

  Future<bool> isGpsEnabled() async {
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    return serviceEnabled;
  }

  void buildGpsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("GPS не включен!"),
          content: Text("Пожалуйста, включите службы определения местоположения в настройках."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Ок"),
            ),
          ],
        );
      },
    );
  }
}
