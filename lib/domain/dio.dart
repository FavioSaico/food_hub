import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:3000',
    headers: {
      'Content-Type': 'application/json',
    },
    connectTimeout: Duration(seconds: 60), // 60 seconds
    receiveTimeout: Duration(seconds: 60) // 60 seconds
  ));

  static Dio get instance => _dio;
}