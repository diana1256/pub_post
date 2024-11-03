
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:PostTime/src/bek/domain/resource.dart';
import 'package:PostTime/src/bek/domain/retrofit_client.dart';
import '../entites/Reestr.dart';
import '../entites/data_reestr.dart';
import '../entites/qery.dart';


class RemoteRepository {
  final Dio _dio;
  final Logger _logger;

  // Используем RetrofitClient для доступа к Dio
  RemoteRepository() : _dio = RetrofitClient().dio, _logger = Logger();

  Future<Resource<Auth>> login(String email, String password) async {
    try {
      final response = await _dio.post('/api/V1/auth/login', data: {
        'login': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        final auth = Auth.fromJson(response.data);
        return Success(auth);
      } else {
        return Error("Unsuccessful response: ${response.statusCode}");
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<ResultData>> getUserData(String token) async {
    try {
      final response = await _dio.get('/api/V1/user-data', options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        final resultData = ResultData.fromJson(response.data);
        return Success(resultData);
      } else {
        return Error("Unsuccessful response: ${response.statusCode}");
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<String>> postCameGone(Map<String, dynamic> tokenMB, String token) async {
    try {
      FormData formData = FormData.fromMap(tokenMB);
      final response = await _dio.post(
        '/api/V1/came-gone',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return Success(response.data.toString());
      } else {
        return Error("Unsuccessful response: ${response.statusCode}");
      }
    } catch (e) {
      return Error(e.toString());
    }
  }


  Future<Resource<List<DataReestr>>> getReestr(String token) async {
    try {
      final response = await _dio.get('/api/V1/reestr', options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        List<DataReestr> dataReestr = (response.data as List).map((item) => DataReestr.fromJson(item)).toList();
        return Success(dataReestr);
      } else {
        return Error("Unsuccessful response: ${response.statusCode}");
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<String>> postRemote(String authorization) async {
    try {
      final response = await _dio.post(
        '/api/V1/remote',
        options: Options(
          headers: {
            'Authorization': 'Bearer $authorization', // Токен должен включать "Bearer"
          },
          followRedirects: false, // Отключаем автоматическое следование за перенаправлениями
          validateStatus: (status) => status! < 500, // Допускаем все коды статусов < 500
        ),
      );

      // Проверка на успешный статус ответа
      if (response.statusCode == 200) {
        return Success(response.data.toString());
      } else {
        return Error("Unsuccessful response: ${response.statusCode}");
      }
    } catch (e) {
      return Error("Error: $e");
    }
  }

  Future<Resource<List<Qery>>> getRees(String token, int page, String dateStart, String dateEnd) async {
    try {
      final response = await _dio.get('/api/V1/reestr', queryParameters: {
        'page': page,
        'dateStart': dateStart,
        'dateEnd': dateEnd,
      }, options: Options(headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json', // Убедитесь, что сервер ожидает JSON
      }));

      if (response.statusCode == 200) {
        List<Qery> queries = (response.data as List).map((item) => Qery.fromJson(item)).toList();
        return Success(queries);
      } else {
        return Error("Unsuccessful response: ${response.statusCode}");
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<String>> getQRCode(String token) async {
    try {
      final response = await _dio.get(
        '/api/V1/qrcode',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return Success(response.data);
      } else {
        return Error("Unsuccessful response: ${response.statusCode}");
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

}
