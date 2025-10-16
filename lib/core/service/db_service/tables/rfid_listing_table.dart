import 'package:sqflite/sqflite.dart';

class RfIdListingTable{

  static const tableName = 'rfidListing';

  static const id = 'id';
  static const rfidId = 'rfidId';
  static const groupId = 'groupId';
  static const itemId = 'itemId';
  static const itemCode = 'itemCode';

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $itemId INTEGER ,
      $groupId TEXT ,
      $itemCode TEXT ,
      $rfidId TEXT 
    )
  ''';

  static Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Sample migration: add new column
      await db.execute("ALTER TABLE $tableName ADD COLUMN email TEXT");
    }
  }
}