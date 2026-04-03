import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager_with_api_sync/data/models/task_model.dart';
import 'package:task_manager_with_api_sync/data/services/database/database_service.dart';
import 'package:task_manager_with_api_sync/utils/result.dart';

class TaskDatabaseService {
  static const String _tableName = 'tasks';
  final DatabaseService _databaseService = DatabaseService(
    databaseName: _tableName,
    version: 2,
    createTableRawQuery:
        'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, title TEXT, description TEXT, status TEXT, priority TEXT, dueDate TEXT )',
    updateTableRawQuery:
        'ALTER TABLE $_tableName ADD COLUMN isApiData INTEGER DEFAULT 0',
  );

  Future<Result<int>> insertTask(TaskModel task) async {
    try {
      final int res =
          await (await _databaseService.database).insert(
            _tableName,
            task.toJSON(),
          );

      debugPrint('Task Database : Task inserted  $res');
      return Success<int>(data: res);
    } catch (e) {
      debugPrint(
        'Error in Task Database : Task inserted  $e',
      );
      return Failure(
        message:
            'Error in Task Database : Task inserted  $e',
      );
    }
  }

  Future<Result<List<TaskModel>>> selectAllTasks() async {
    try {
      final List<Map<String, Object?>> res =
          await (await _databaseService.database).query(
            _tableName,
          );

      final List<TaskModel> taskData = res
          .map(
            (Map<String, Object?> task) =>
                TaskModel.fromDb(task),
          )
          .toList();
      debugPrint('Task Database : Task retrieve  $res');
      return Success<List<TaskModel>>(data: taskData);
    } on DatabaseException catch (e) {
      debugPrint(
        'Error in Task Database : Task retrieve  $e',
      );
      return Failure(
        message:
            'Error in Task Database : Task retrieve  $e',
      );
    }
  }

  Future<Result<int>> updateTask(
    TaskModel task,
    int id,
  ) async {
    try {
      final int res =
          await (await _databaseService.database).update(
            _tableName,
            task.toJSON(),
            where: 'id=?',
            whereArgs: <int?>[id],
          );
      debugPrint('Task Database : Task update  $res');
      return Success<int>(data: res);
    } catch (e) {
      debugPrint(
        'Error in Task Database : Task retrieve  $e',
      );
      return Failure(
        message:
            'Error in Task Database : Task retrieve  $e',
      );
    }
  }

  Future<Result<int>> deleteTask(int? id) async {
    try {
      final int res =
          await (await _databaseService.database).delete(
            _tableName,
            where: 'id=?',
            whereArgs: <int?>[id],
          );
      debugPrint('Task Database : Task delete  $res');
      return Success<int>(data: res);
    } catch (e) {
      debugPrint(
        'Error in Task Database : Task delete  $e',
      );
      return Failure(
        message: 'Error in Task Database : Task delete  $e',
      );
    }
  }

  Future<Result<int>> deleteApiTasks() async {
    try {
      final int res =
          await (await _databaseService.database).rawDelete(
            'DELETE FROM tasks WHERE isApiData=?',
            <Object?>[1],
          );
      debugPrint('deleted api tasks successfully $res');
      return Success<int>(data: res);
    } catch (e) {
      debugPrint(
        'Error occurred when deleting api tasks: $e',
      );
      return Failure(message: 'Something went wrong');
    }
  }
}
