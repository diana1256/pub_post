import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../map/MapScreen.dart';
import '../statistic/statistic_screen.dart';
import '../utils/pref.dart';
import 'home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Provider.of<HomeLogic>(context, listen: false);
    final String? scannedCode = ModalRoute.of(context)?.settings.arguments as String?;

    if (scannedCode != null) {
      logic.QRcode(context, scannedCode);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<HomeLogic>(
        builder: (context, logic, child) {
          return FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(),
            builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
              final sharedPreferences = snapshot.data;
              final pref = sharedPreferences != null ? Pref(sharedPreferences) : null;

              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 70),
                        _buildProfile(context, logic),
                        SizedBox(height: 10),
                        _buildCard('Статистика посещаемости', 'assets/images/icon.png', () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => StatisticScreen()),
                          );
                        }),
                        SizedBox(height: 10),
                        _buildCard('Сканировать', 'assets/vectors/scaner.svg', () async {
                          if (await logic.requestCameraPermission() && await logic.requestLocationPermission()) {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => MapScreen()),
                            );
                          } else {
                            logic.showSnackBar(context, "Необходимо разрешение на камеру и геолокацию");
                          }
                        }),
                        SizedBox(height: 10),
                        _buildCard('Удалёнка', 'assets/vectors/remote.svg', () async {
                          final token = "Bearer ${pref?.isPassword()}";
                          await logic.requestRemoteAccess(context, token);
                        }),
                        SizedBox(height: 70),
                        _buildFooter(),
                      ],
                    ),
                  ),
                  if (logic.isLoading)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildProfile(BuildContext context, HomeLogic logic) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(
              'assets/vectors/profile.svg',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20),
          Text(
            logic.userName.isNotEmpty ? logic.userName : 'Имя Фамилия',
            style: TextStyle(
              color: Color(0xFF2D7ABE),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            logic.userPosition.isNotEmpty ? logic.userPosition : 'Начальник самоуправления',
            style: TextStyle(
              color: Color(0xFF2D7ABE),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String iconPath, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 2,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              color: Color(0xFFCFE8FE),
              borderRadius: BorderRadius.circular(5),
            ),
            width: double.infinity,
            height: 75,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _getImageWidget(iconPath),
                SizedBox(height: 3),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF2E68FF),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getImageWidget(String path) {
    return path.endsWith('.svg')
        ? SvgPicture.asset(path, width: 22, height: 22)
        : Image.asset(path, width: 22, height: 22);
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(top: 85.0, bottom: 20.0),
      child: Column(
        children: [
          Text(
            'Управление по IT ОАО "Кыргыз почтасы"',
            style: TextStyle(
              color: Color(0xFF236BB5),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}





/*  if (await logic.requestCameraPermission() && await logic.requestLocationPermission()) {
                await logic.submitAttendanceData(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Необходимо разрешение на камеру и геолокацию")));
              }*/
class CustomLayoutDialog extends StatelessWidget {
  final String title;
  final String date;
  final String time;

  const CustomLayoutDialog({
    Key? key,
    required this.title,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top card with the title
            Card(
              color: Color(0xFFF6F2F2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
                side: BorderSide(color: Color(0xFF0B3C73), width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Center(
                  child: Text(
                    title, // Dynamic title based on the attendance status
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Date section
            buildInfoCard('   Дата работы         ', '      Дата работы: $date      '),
            // Time section
            buildInfoCard('   Время начала работы   ', '   Время начала работы: $time   '),
            SizedBox(height: 20),
            // Back button
            MaterialButton(
              color: Color(0xFF064198),
              minWidth: double.infinity,
              height: 70,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Назад',
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build information cards
  Card buildInfoCard(String header, String content) {
    return Card(
      color: Color(0xFFF4F4F4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide(color: Color(0xFF0B3C73), width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Column(
          children: [
            Text(
              header,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Text(
              content,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}




