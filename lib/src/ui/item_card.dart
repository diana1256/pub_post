import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../bek/entites/data_item.dart';

class DataItemCard extends StatelessWidget {
  final DataItem dataItem;

  const DataItemCard({Key? key, required this.dataItem}) : super(key: key);

  String formatTime(String time) {
    try {
      final inputFormat = DateFormat("HH:mm:ss", "ru");
      final outputFormat = DateFormat("HH:mm", "ru");
      return outputFormat.format(inputFormat.parse(time));
    } catch (e) {
      return time;
    }
  }

  String formatDate(String date) {
    try {
      final inputFormat = DateFormat("yyyy-MM-dd", "ru");
      final outputFormat = DateFormat("EEE dd MMMM", "ru");
      return outputFormat.format(inputFormat.parse(date)).replaceFirst(date[0], date[0].toUpperCase());
    } catch (e) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    final startTimes = dataItem.reestrDetails.map((e) => formatTime(e.workStart)).join(", ");
    final endTimes = dataItem.reestrDetails.map((e) => formatTime(e.workEnd)).join(", ");
    final formattedDate = formatDate(dataItem.workDate);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text(formattedDate, style: TextStyle(color: Colors.blue, fontSize: 16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(startTimes, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(endTimes, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            Text("Вы опоздали на ${formatTime(dataItem.late)} минут",
                style: TextStyle(color: Colors.red, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}