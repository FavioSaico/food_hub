import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:3000',
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  static Dio get instance => _dio;
}