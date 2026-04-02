import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  final String _databaseName;
  final String _databaseCreateRawQuery;
  late final Future<Database> _database =
      _createTaskDatabase();

  DatabaseService({
    required String databaseName,
    required String createDatabaseRawQuery,
  }) : _databaseName = databaseName,
       _databaseCreateRawQuery = createDatabaseRawQuery;

  Future<Database> get database => _database;
  Future<Database> _createTaskDatabase() async {
    try {
      return await openDatabase(
        join(
          await getDatabasesPath(),
          '${_databaseName}_database.db',
        ),

        onCreate: (Database db, int version) {
          return db.execute(_databaseCreateRawQuery);
        },
        version: 1,
      );
    } on DatabaseException catch (e) {
      debugPrint('Error when initiating database : $e');
      rethrow;
    }
  }
}
