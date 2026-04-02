import 'package:flutter/material.dart';
import 'package:task_manager_with_api_sync/data/models/task_model.dart';
import 'package:task_manager_with_api_sync/data/repositories/task_repository.dart';
import 'package:task_manager_with_api_sync/utils/result.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository _taskRepository;
  List<TaskModel> _taskList = <TaskModel>[];
  String message = '';

  TaskViewModel({required TaskRepository taskRepository})
    : _taskRepository = taskRepository {
    getAllTask();
  }

  List<TaskModel> get taskList => _taskList;

  void addTask(TaskModel task) async {
    final Result<int> result = await _taskRepository
        .createTask(task);

    switch (result) {
      case Success<int>():
        message = 'Successfully Created';

      case Failure(:final String errorMessage):
        message = errorMessage;
    }
    getAllTask();
  }

  void getAllTask() async {
    final Result<List<TaskModel>> result =
        await _taskRepository.readAllTask();

    switch (result) {
      case Success<List<TaskModel>>(
        :final List<TaskModel> data,
      ):
        _taskList = data;

      case Failure(:final String errorMessage):
        message = errorMessage;
    }
    notifyListeners();
  }

  Future<void> deleteTask(int? id) async {
    final Result<int> result = await _taskRepository
        .removeTask(id);
    switch (result) {
      case Success<int>(:final int data):
        message = 'Successfully deleted';

      case Failure(:final String errorMessage):
        message = errorMessage;
    }
    getAllTask();
  }

  Future<void> updateTask(TaskModel task, int id) async {
    final Result<int> result = await _taskRepository
        .editTask(task, id);

    switch (result) {
      case Success<int>(:final int data):
        message = 'Successfully deleted';
      case Failure(:final String errorMessage):
        message = errorMessage;
    }
    getAllTask();
  }
}
