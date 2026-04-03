import 'package:task_manager_with_api_sync/data/models/task_model.dart';
import 'package:task_manager_with_api_sync/data/services/database/task_database_service.dart';
import 'package:task_manager_with_api_sync/data/services/network/task_dio_service.dart';
import 'package:task_manager_with_api_sync/utils/result.dart';

class TaskRepository {
  final TaskDatabaseService _taskDatabaseService;
  final TaskDioService _taskDioService;

  TaskRepository({
    required TaskDatabaseService taskDatabaseService,
    required TaskDioService taskDioService,
  }) : _taskDatabaseService = taskDatabaseService,
       _taskDioService = taskDioService;

  Future<Result<int>> createTask(TaskModel task) async {
    return await _taskDatabaseService.insertTask(task);
  }

  Future<Result<List<TaskModel>>> readAllTask() async {
    return await _taskDatabaseService.selectAllTasks();
  }

  Future<Result<List<TaskModel>>>
  getTasksOfflineFirst() async {
    final Result<List<TaskModel>> localResult =
        await _taskDatabaseService.selectAllTasks();

    List<TaskModel> localTasks = <TaskModel>[];
    if (localResult is Success<List<TaskModel>>) {
      localTasks = localResult.data;
    }

    try {
      final Result<List<TaskModel>> remoteTasksResult =
          await _taskDioService.getTask();

      if (remoteTasksResult case Success<List<TaskModel>>(
        data: final List<TaskModel> tasks,
      )) {
        await _taskDatabaseService.deleteApiTasks();
        for (final TaskModel task in tasks) {
          await _taskDatabaseService.insertTask(task);
        }
      }
    } catch (e) {
      print('Sync failed: $e');
      return Failure(message: 'Synchronization Failed');
    }

    return Success<List<TaskModel>>(data: localTasks);
  }

  Future<Result<int>> editTask(
    TaskModel task,
    int id,
  ) async {
    return await _taskDatabaseService.updateTask(task, id);
  }

  Future<Result<int>> removeTask(int? id) async {
    return await _taskDatabaseService.deleteTask(id);
  }
}
