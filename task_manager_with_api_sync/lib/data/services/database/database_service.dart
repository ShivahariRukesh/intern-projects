import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  final String _databaseName;
  final String _createTableRawQuery;
  final String? _updateTableRawQuery;
  final int _version;
  late final Future<Database> _database =
      _createTaskDatabase();

  DatabaseService({
    required String databaseName,
    required String createTableRawQuery,
    required int version,
    String? updateTableRawQuery,
  }) : _databaseName = databaseName,
       _createTableRawQuery = createTableRawQuery,
       _version = version,
       _updateTableRawQuery = updateTableRawQuery;

  Future<Database> get database => _database;
  Future<Database> _createTaskDatabase() async {
    try {
      return await openDatabase(
        join(
          await getDatabasesPath(),
          '${_databaseName}_database.db',
        ),

        onCreate: (Database db, int version) {
          return db.execute(_createTableRawQuery);
        },

        onUpgrade:
            (
              Database db,
              int oldVersion,
              int newVersion,
            ) async {
              if (_updateTableRawQuery != null &&
                  oldVersion < newVersion) {
                debugPrint(
                  'Upgrading database from $oldVersion to $newVersion',
                );
                await db.execute(_updateTableRawQuery);
              }
            },
        version: _version,
      );
    } on DatabaseException catch (e) {
      debugPrint('Error when initiating database : $e');
      rethrow;
    }
  }
}
