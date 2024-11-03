import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:logger/logger.dart';

class RetrofitClient {
  static final RetrofitClient _instance = RetrofitClient._internal();

  factory RetrofitClient() => _instance;

  late final Dio _dio;
  late final Logger _logger;

  RetrofitClient._internal() {
    _logger = Logger();

    _dio = Dio(BaseOptions(
      baseUrl: 'https://worktime.kyrgyzpost.kg',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ));

    // Отключаем проверку SSL-сертификатов
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    _dio.interceptors.add(LoggingInterceptor(_logger));
  }

  Dio get dio => _dio;
}



class LoggingInterceptor extends Interceptor {
  final Logger logger;

  LoggingInterceptor(this.logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i('Request: ${options.method} ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i('Response: ${response.statusCode} ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logger.e('Error: ${err.message}');
    super.onError(err, handler);
  }
}