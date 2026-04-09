import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_media_app/models/user_model.dart';
import 'package:social_media_app/utils/error_handler.dart';
import 'package:social_media_app/utils/result_record.dart';

class AuthService {
  final dio = Dio(BaseOptions(baseUrl: 'https://dummyjson.com/users'));

  Future<void> fetchAllUsers() async {
    final response = await dio.get('/');
    final List data = jsonDecode(response.toString())["users"];

    final requiredData = data
        .map(
            (ele) => {"username": ele["username"], "password": ele["password"]})
        .toList();
  }

  Future<Result<UserModel>> fetchLoggedInUser({required int userId}) async {
    try {
      final response = await dio.get('/$userId');
      final Map<String, dynamic> data = response.data;

      return (
        success: SuccessResponse(data: UserModel.fromJson(data)),
        error: null
      );
    } on DioException catch (e) {
      debugPrint("Error when fetching logged in user : $e");
      return (success: null, error: ErrorResponse(message: handleDioError(e)));
    } catch (e) {
      debugPrint("Error when fetching logged in user : $e");
      return (
        success: null,
        error: ErrorResponse(
            message: 'Unexpected error occurred when fetching logged in user')
      );
    }
  }

  Future<Result<UserModel>> loginUser(
      {required username, required password}) async {
    try {
      final response = await dio
          .post('/login', data: {'username': username, 'password': password});

      final data = response.data;

      final UserModel requiredData = UserModel.fromJson(data);

      return (
        success: SuccessResponse<UserModel>(
            data: requiredData, message: "Successfully Logged In"),
        error: null
      );
    } on DioException catch (err) {
      return (
        success: null,
        error: ErrorResponse(message: handleDioError(err))
      );
    } catch (e) {
      return (
        success: null,
        error: ErrorResponse(message: "Something went wrong while logging")
      );
    }
  }

  Future<void> logoutUser() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  bool isLoggedIn() {
    return false;
  }
}
