import 'package:sqflite/sqflite.dart';

class StockUpdateTable{

  static const tableName = 'stockUpdate';

  static const transactionDtId = 'transactionDtId';
  static const itemId = 'itemId';
  static const quantity = 'quantity';
  static const storageLocationId = 'storageLocationId';
  static const remarks = 'remarks';
  static const modifiedOn = 'modifiedOn';
  static const syncStatus = 'syncStatus';
  static const syncMerge = 'syncMerge';
  static const transactionId = 'transactionId';
  // static const locationId = 'locationId';
  // static const equipmentId = 'equipmentId';
  static const totalRob = 'totalRob';
  static const adjustNewStock = 'adjustNewStock';
  static const adjustReconditionStock = 'adjustReconditionStock';


  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $transactionDtId INTEGER PRIMARY KEY,
      $itemId INTEGER,
      $quantity REAL,
      $storageLocationId INTEGER ,
      $remarks TEXT,
      $modifiedOn TEXT,
      $syncStatus TEXT,
      $syncMerge TEXT,
      $transactionId INTEGER,
      $totalRob INTEGER,
      $adjustNewStock REAL,
      $adjustReconditionStock REAL
    )
  ''';

  static Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Sample migration: add new column
      await db.execute("ALTER TABLE $tableName ADD COLUMN email TEXT");
    }
  }

}