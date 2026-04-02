import 'package:task_manager_with_api_sync/data/models/task_model.dart';
import 'package:task_manager_with_api_sync/data/services/database/task_database_service.dart';
import 'package:task_manager_with_api_sync/utils/result.dart';

class TaskRepository {
  final TaskDatabaseService _taskDatabaseService;

  TaskRepository({
    required TaskDatabaseService taskDatabaseService,
  }) : _taskDatabaseService = taskDatabaseService;

  Future<Result<int>> createTask(TaskModel task) async {
    return await _taskDatabaseService.insertTask(task);
  }

  Future<Result<List<TaskModel>>> readAllTask() async {
    return await _taskDatabaseService.selectAllTasks();
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
