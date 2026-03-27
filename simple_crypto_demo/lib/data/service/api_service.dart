import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final Dio _dio;
  static final ApiService _instance = ApiService._in();

  Dio get dio => _dio;
  factory ApiService() {
    return _instance;
  }

  ApiService._in()
    : _dio = Dio(
        BaseOptions(
          baseUrl: dotenv.env['BASE_URL'].toString(),
          // baseUrl: 'https://www.smth.com',
          headers: {
            'X-CMC_PRO_API_KEY': dotenv.env['API_KEY'],
            // 'X-CMC_PRO_API_KEY': 33333,
          },
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
        ),
      ) {
    _dio.interceptors.add(LogInterceptor());
  }
}
