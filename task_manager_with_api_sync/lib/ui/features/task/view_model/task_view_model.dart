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
    syncApiTasks();
    // getAllTask();
  }

  List<TaskModel> get taskList => _taskList;

  void addTask(TaskModel task) async {
    final Result<int> result = await _taskRepository
        .createTask(task);

    switch (result) {
      case Success<int>():
        message = 'Successfully Created';
      // _taskList.add(task);

      case Failure(:final String errorMessage):
        message = errorMessage;
    }
    // notifyListeners();

    getAllTask();
  }

  void syncApiTasks() async {
    final Result<List<TaskModel>> result =
        await _taskRepository.getTasksOfflineFirst();

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
      case Success<int>():
        message = 'Successfully deleted';
      // _taskList.removeWhere(
      //   (TaskModel task) => task.id == id,
      // );
      case Failure(:final String errorMessage):
        message = errorMessage;
    }
    // notifyListeners();
    getAllTask();
  }

  Future<void> updateTask(
    TaskModel editedTask,
    int id,
  ) async {
    final Result<int> result = await _taskRepository
        .editTask(editedTask, id);

    switch (result) {
      case Success<int>():
        message = 'Successfully deleted';
      // int editTaskIndex = _taskList.indexWhere(
      //   (TaskModel task) => task.id == id,
      // );
      // _taskList[editTaskIndex] = editedTask;
      case Failure(:final String errorMessage):
        message = errorMessage;
    }
    // notifyListeners();
    getAllTask();
  }
}
