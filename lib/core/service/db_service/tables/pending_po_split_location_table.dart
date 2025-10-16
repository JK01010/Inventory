import 'package:sqflite/sqflite.dart';

class PendingPoSplitLocationTable {
  static const tableName = 'pending_po_split_location';

  static const id = 'ID';
  static const poHdId = 'poHdId';
  static const poDtId = 'poDtId';
  static const storageLocationId = 'StorageLocationID';
  static const locationName = 'LocationName';
  static const typeID = 'TypeID';
  static const quantity = 'Quantity';
  static const isActive = 'IsActive';
  static const itemId = 'itemId';

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY,
      $poHdId INTEGER,
      $poDtId INTEGER,
      $storageLocationId INTEGER,
      $locationName TEXT,
      $typeID INTEGER,
      $quantity REAL,
      $isActive INTEGER,
      $itemId INTEGER
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
