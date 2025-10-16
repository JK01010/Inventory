import 'package:sqflite/sqflite.dart';

class StorageLocationTable {
  static const tableName = 'storage_location';

  static const id = 'ID';
  static const parentId = 'ParentID';
  static const code = 'Code';
  static const locName = 'LocName';
  static const description = 'Description';
  static const vesselLocationID = 'VesselLocationID';
  static const isActive = 'IsActive';
  static const referenceTypeID = 'ReferenceTypeID';
  static const referenceID = 'ReferenceID';
  static const referenceSubID = 'ReferenceSubID';
  static const parentLocName = 'ParentLocName';

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY,
      $parentId INTEGER NOT NULL,
      $code TEXT NOT NULL,
      $locName TEXT NOT NULL,
      $description TEXT,
      $vesselLocationID INTEGER,
      $isActive TEXT,
      $referenceTypeID INTEGER,
      $referenceID INTEGER,
      $referenceSubID INTEGER,      
      $parentLocName TEXT NOT NULL
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
