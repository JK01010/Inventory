import 'package:sqflite/sqflite.dart';

class TimeStampMetaTable {
  static const tableName = 'time_stamp_meta_table';

  static const id = 'id';
  static const code = 'code';
  static const vesselId = 'vesselId';
  static const modifiedOn = 'modifiedOn';

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $code TEXT NOT NULL,
      $vesselId INTEGER,
      $modifiedOn TEXT NOT NULL
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
