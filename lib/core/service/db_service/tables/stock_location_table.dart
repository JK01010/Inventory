import 'package:sqflite/sqflite.dart';

import 'item_master_table.dart';

class StockLocationTable {
  static const tableName = 'stock_location';

  static const id = 'id';
  static const itemId = 'itemId';
  static const storageLocationId = 'storageLocationId';
  static const quantity = 'quantity';
  static const tags = 'tags';

  //TODO need to add foreign key of Storage location table
  static String createTableQuery = '''
    CREATE TABLE $tableName (
     $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $itemId INTEGER ,
      $storageLocationId INTEGER ,
      $quantity INTEGER ,      
      $tags TEXT,
      FOREIGN KEY ($itemId) REFERENCES item_master(${ItemMasterTable.itemId})   
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
