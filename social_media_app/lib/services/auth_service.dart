import 'dart:convert';

import 'package:dio/dio.dart';

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

  Future<Map<String, dynamic>> handleLogin(
      {required username, required password}) async {
    try {
      final response = await dio.post('/login', data: {
        'username': username,
        'password': password
      });
      print("logged in data is $response");
      final data = response.data;
      // final data = jsonDecode(response.toString());
      print("logged in data is $data");

      final Map<String, dynamic> requiredData = {
        "username": data["username"],
        "email": data["email"],
        "accessToken": data["accessToken"]
      };

      return requiredData;
    } on DioException catch (err) {
      print("The err is $err");
      rethrow;
    }
  }

  bool isLoggedIn() {
    return false;
  }
}
