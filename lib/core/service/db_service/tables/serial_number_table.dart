import 'package:sqflite/sqflite.dart';

class SerialNumberTable{

  static const tableName = 'serialNumber';

  static const id = 'id';
  static const itemId = 'itemId';
  static const poId = 'portId';
  static const transactionId = 'transactionId';

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY,
      $itemId INTEGER NOT NULL,
      $poId INTEGER NOT NULL,
      $transactionId INTEGER NOT NULL
    )
  ''';

  static Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Sample migration: add new column
      await db.execute("ALTER TABLE $tableName ADD COLUMN email TEXT");
    }
  }

}