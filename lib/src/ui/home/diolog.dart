import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Top Card with message
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF6F2F2),
                border: Border.all(color: Color(0xFF0B3C73), width: 2),
              ),
              padding: EdgeInsets.symmetric(vertical: 18),
              child: Center(
                child: Text(
                  'Вы успешно отметились!',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
            // "Дата работы" section
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F4F4),
                      border: Border.all(color: Color(0xFF0B3C73), width: 2),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18),
                    child: Center(
                      child: Text(
                        'Дата работы',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 18, 0, 12),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Дата работы:',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // "Время начало работы" section
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F4F4),
                      border: Border.all(color: Color(0xFF0B3C73), width: 2),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18),
                    child: Center(
                      child: Text(
                        'Время начало работы',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 18, 0, 12),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Время начало работы:',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // "Назад" Button
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              width: double.infinity,
              height: 70,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF064198),
                  textStyle: TextStyle(fontSize: 23),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Назад'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog();
    },
  );
}
