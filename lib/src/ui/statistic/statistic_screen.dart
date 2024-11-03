import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:PostTime/src/ui/statistic/statistic.dart';
import '../item_card.dart';
import '../week/week_sreen.dart';

class StatisticScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StatisticViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<StatisticViewModel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Back Button
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, top: 40),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(); // Return to HomeScreen
                      },
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back, size: 30, color: Colors.black),
                          SizedBox(width: 8),
                          Text("Назад", style: TextStyle(fontSize: 14, color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                  // Profile Information
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: SvgPicture.asset(
                        'assets/vectors/profile.svg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // User Name
                  Text(
                    viewModel.userName, // Update this with the user's name
                    style: TextStyle(fontSize: 17, color: Color(0xFF2D7ABE), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  // Work Type
                  Text(
                    viewModel.workType, // Update this with the user's work type
                    style: TextStyle(fontSize: 16, color: Color(0xFF2D7ABE), fontWeight: FontWeight.bold),
                  ),
                  // Loading Indicator
                  if (viewModel.isLoading)
                    CircularProgressIndicator(),
                  // Error Message
                  if (viewModel.isError)
                    Text("Произошла ошибка попробуйте зайти позже!!"),
                  // ListView for Data Items
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: viewModel.dataItems.length,
                    itemBuilder: (context, index) {
                      final item = viewModel.dataItems[index];
                      return DataItemCard(dataItem: item); // Your custom widget for data items
                    },
                  ),
                  SizedBox(height: 30),
                  // "За неделю" Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => WeekScreen()), // Navigate to WeekScreen
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0175E2),
                      minimumSize: Size(130, 45),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.access_time, color: Colors.white),
                        SizedBox(width: 8),
                        Text("За неделю", style: TextStyle(color: Colors.white, fontSize: 14)),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}




