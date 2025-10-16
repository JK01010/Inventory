import 'package:sqflite/sqflite.dart';

class FailedCommonApiMetaTable {
  static const tableName = 'failed_common_api_meta_table';

  static const id = 'id';
  static const apiEndPoint = 'apiEndPoint';
  static const apiPayLoad = 'apiPayLoad';
  static const executedAt = 'executedAt';

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $apiEndPoint TEXT NOT NULL,
      $apiPayLoad TEXT NOT NULL,
      $executedAt TEXT
    )
  ''';

  static Future<void> onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      // Sample migration: add new column
      await db.execute("ALTER TABLE $tableName ADD COLUMN email TEXT");
    }
  }
}
