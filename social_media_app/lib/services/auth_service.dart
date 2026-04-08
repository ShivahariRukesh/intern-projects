import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:social_media_app/models/user_model.dart';

class AuthService {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://dummyjson.com/users'));

  Future<void> fetchAllUsers() async {
    final response = await dio.get('/');
    final List data =
        jsonDecode(response.toString())["users"];

    final requiredData = data
        .map((ele) => {
              "username": ele["username"],
              "password": ele["password"]
            })
        .toList();

    print("The first user info is : ${requiredData[0]}");
  }

  Future<UserModel> fetchLoggedInUser(
      {required int userId}) async {
    try {
      final response = await dio.get('/$userId');

      final Map<String, dynamic> data = response.data;
      print(
          "Inside logged in service ${UserModel.fromJson(data)}");
      return UserModel.fromJson(data);
    } on DioException catch (err) {
      print("The err is $err");
      rethrow;
    }
  }

  Future<UserModel> loginUser(
      {required username, required password}) async {
    try {
      final response = await dio.post('/login', data: {
        'username': username,
        'password': password
      });

      final data = response.data;

      final UserModel requiredData =
          UserModel.fromJson(data);

      return requiredData;
    } on DioException catch (err) {
      print("The err is $err");
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  bool isLoggedIn() {
    return false;
  }
}
