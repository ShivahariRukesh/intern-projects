import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:task_manager_with_api_sync/data/services/network/api_service.dart';
import 'package:task_manager_with_api_sync/utils/result.dart';

class UserDioService {
  final ApiService _apiService = ApiService();

  Future<Result<Map<String, dynamic>>> loginUser({
    required String username,
    required String password,
  }) async {
    try {
      final Response response = await _apiService.dio.post(
        '/user/login',
        options: Options(
          headers: <String, dynamic>{
            'Content-Type': 'application/json',
          },
        ),
        data: <String, String>{
          'username': username,
          'password': password,
        },
      );

      final json = jsonDecode(response.toString());
      final Map<String, dynamic> responseData =
          <String, dynamic>{
            'username': json['username'],
            'email': json['email'],
            'isLoggedIn': true,
          };

      return Success(data: responseData);
    } catch (e) {
      debugPrint('Error when logging in user $e');
      return Failure(message: 'Error Login');
    }
  }
}
