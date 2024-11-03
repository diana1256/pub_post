import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:PostTime/src/ui/week/week.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bek/entites/data_item.dart';
import '../utils/pref.dart';

class WeekScreen extends StatefulWidget {
  @override
  _WeekScreenState createState() => _WeekScreenState();
}

class _WeekScreenState extends State<WeekScreen> {
  late Future<String> _tokenFuture;

  @override
  void initState() {
    super.initState();
    _tokenFuture = _getToken();
  }

  Future<String> _getToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return "Bearer ${Pref(sharedPreferences).isPassword()}"; // Получаем токен из предпочтений
  }

  @override
  Widget build(BuildContext context) {
    final weekViewModel = Provider.of<WeekViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Назад'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Возвращает на предыдущий экран
          },
        ),
      ),
      body: FutureBuilder<String>(
        future: _tokenFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка получения токена: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final token = snapshot.data!;
            weekViewModel.fetchWeekData(token);

            return Consumer<WeekViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (viewModel.errorMessage != null) {
                  // Показываем диалоговое окно с сообщением об ошибке
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _showErrorDialog(context, viewModel.errorMessage!);
                  });
                  return Center(child: Text("Ошибка, пожалуйста, подождите..."));
                } else if (viewModel.dataItems == null || viewModel.dataItems!.isEmpty) {
                  return Center(child: Text("Нет данных"));
                } else {
                  return ListView.builder(
                    itemCount: viewModel.dataItems!.length,
                    itemBuilder: (context, index) {
                      return _buildWeekItem(viewModel.dataItems![index]);
                    },
                  );
                }
              },
            );
          } else {
            return Center(child: Text("Неизвестная ошибка"));
          }
        },
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ошибка"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("Закрыть"),
              onPressed: () {
                Navigator.of(context).pop(); // Закрывает диалог
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildWeekItem(DataItem item) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'Время начала рабочего времени',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF3375BD), fontSize: 16),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimeCard(item.userTimeStart),
              _buildDateCard(item.workDate),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeCard(String time) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            time,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildDateCard(String date) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            date,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}




