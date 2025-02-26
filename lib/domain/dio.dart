import 'package:dio/dio.dart';
import 'package:food_hub/config/env.dart';

class DioClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: Environment.backPort,
    headers: {
      'Content-Type': 'application/json',
    },
    connectTimeout: Duration(seconds: 60), // 60 seconds
    receiveTimeout: Duration(seconds: 60) // 60 seconds
  ));

  static Dio get instance => _dio;
}