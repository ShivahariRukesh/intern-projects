import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;
  static final ApiService _apiServiceInstance =
      ApiService._internal();

  factory ApiService() {
    return _apiServiceInstance;
  }

  ApiService._internal()
    : dio = Dio(
        BaseOptions(baseUrl: 'https://dummyjson.com'),
      ) {
    dio.interceptors.add(LogInterceptor());
  }
}
