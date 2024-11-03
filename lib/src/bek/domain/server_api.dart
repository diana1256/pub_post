
import 'package:dio/dio.dart';
import '../entites/Coordin.dart';
import '../entites/Reestr.dart';
import '../entites/data_reestr.dart';
import '../entites/qery.dart';


abstract class ServerApi {
  Future<Auth> login(String email, String password);

  Future<ResultData> getUserData(String token);

  Future<String> postCameGone(FormData tokenMB, String authorization);

  Future<String> postRemote(FormData tokenMB, String authorization);

  Future<List<DataReestr>> getReestr(String token);

  Future<List<DataReestr>> getReestrData(String token);

  Future<List<Qery>> getRees(String token, {int paginate = 5, required String dateStart, required String dateEnd});

  Future<String> getQRCode(String token);

  Future<Coordin> getCoordinates(String token);
}

// Реализация интерфейса
class ServerApiImpl implements ServerApi {
  final Dio _dio;

  ServerApiImpl(this._dio);

  @override
  Future<Auth> login(String email, String password) async {
    final response = await _dio.post('/api/V1/auth/register', data: {
      'login': email,
      'password': password,
    });
    return Auth.fromJson(response.data);
  }

  @override
  Future<ResultData> getUserData(String token) async {
    final response = await _dio.get('/api/V1/user-data', options: Options(headers: {
      'Authorization': token,
    }));
    return ResultData.fromJson(response.data);
  }

  @override
  Future<String> postCameGone(FormData tokenMB, String authorization) async {
    final response = await _dio.post('/api/V1/came-gone', data: tokenMB, options: Options(headers: {
      'Authorization': authorization,
    }));
    return response.data.toString();
  }

  @override
  Future<String> postRemote(FormData tokenMB, String authorization) async {
    final response = await _dio.post('/api/V1/remote', data: tokenMB, options: Options(headers: {
      'Authorization': authorization,
    }));
    return response.data.toString();
  }

  @override
  Future<List<DataReestr>> getReestr(String token) async {
    final response = await _dio.get('/api/V1/reestr', options: Options(headers: {
      'Authorization': token,
    }));
    return (response.data as List).map((item) => DataReestr.fromJson(item)).toList();
  }

  @override
  Future<List<DataReestr>> getReestrData(String token) async {
    return await getReestr(token);
  }

  @override
  Future<List<Qery>> getRees(String token, {int paginate = 5, required String dateStart, required String dateEnd}) async {
    final response = await _dio.get('/api/V1/reestr', queryParameters: {
      'paginate': paginate,
      'dateStart': dateStart,
      'dateEnd': dateEnd,
    }, options: Options(headers: {
      'Authorization': token,
    }));
    return (response.data as List).map((item) => Qery.fromJson(item)).toList();
  }

  @override
  Future<String> getQRCode(String token) async {
    final response = await _dio.get('/api/V1/qrcode', options: Options(headers: {
      'Authorization': token,
    }));
    return response.data.toString();
  }

  @override
  Future<Coordin> getCoordinates(String token) async {
    final response = await _dio.get('/api/V1/get-coordinates', options: Options(headers: {
      'Authorization': token,
    }));
    return Coordin.fromJson(response.data);
  }
}