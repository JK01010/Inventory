import 'package:sqflite/sqflite.dart';


class SplitLocationTable {
  static const tableName = 'split_location';

  static const id = 'ID';
  static const grnhdId = 'GRNHDID';
  static const grnDtId = 'GRNDTID';
  static const storageLocationId = 'StorageLocationID';
  static const code = 'Code';
  static const locationName = 'LocationName';
  static const description = 'Description';
  static const itemID = 'ItemID';
  static const parentItemID = 'ParentItemID';
  static const typeID = 'TypeID';
  static const quantity = 'Quantity';
  static const parentID = 'ParentID';
  static const isActive = 'IsActive';
  static const locationHierarchy = 'LocationHierarchy';

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY,
      $grnhdId INTEGER,
      $grnDtId INTEGER,
      $storageLocationId INTEGER,
      $code TEXT,
      $locationName TEXT,
      $description TEXT,
      $itemID INTEGER,
      $parentItemID INTEGER,
      $typeID INTEGER,
      $quantity REAL,
      $parentID INTEGER,
      $isActive INTEGER,
      $locationHierarchy TEXT
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
