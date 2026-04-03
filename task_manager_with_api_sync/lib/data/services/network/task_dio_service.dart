import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:task_manager_with_api_sync/data/models/task_model.dart';
import 'package:task_manager_with_api_sync/data/services/network/api_service.dart';
import 'package:task_manager_with_api_sync/utils/result.dart';

class TaskDioService {
  final ApiService _apiService = ApiService();

  Future<Result<List<TaskModel>>> getTask() async {
    try {
      final Response res = await _apiService.dio.get(
        '/todos',
        queryParameters: <String, dynamic>{'limit': 5},
      );
      final List decodedResponse = jsonDecode(
        res.toString(),
      )['todos'];

      final List<TaskModel> jsonTasks = decodedResponse
          .map((dynamic item) => TaskModel.fromApi(item))
          .toList();

      print('The task is ${jsonTasks[0].title}');

      return Success(data: jsonTasks);
    } catch (e) {
      debugPrint(
        'Error in task dio service while getting task: $e',
      );
      return Failure(
        message: 'Error when fetching data from api',
      );
    }
  }
}
