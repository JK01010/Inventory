import 'package:sqflite/sqflite.dart';

class DefaultLocationTable {
  static const tableName = 'default_location';

  static const id = 'ID';
  static const locationVesselMappingId = 'LocationVesselMappingID';
  static const locationName = 'LocName';
  static const itemId = 'ItemID';
  static const itemVersionId = 'ItemVersionID';
  static const itemLinkId = 'ItemLinkID';
  static const partNumber = 'PartNumber';
  static const code = 'Code';
  static const uomQuantity = 'UomQuantity';
  static const robCount = 'ROBCount';
  static const sectionName = 'SectionName';
  static const subSectionName = 'SubSectionName';
  static const description = 'Description';
  static const itemName = 'ItemName';
  static const categoryName = 'CategoryName';
  static const isActive = 'IsActive';

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $id INTEGER,
      $locationVesselMappingId INTEGER,
      $locationName TEXT,
      $itemId INTEGER,
      $itemVersionId INTEGER,
      $itemLinkId INTEGER,
      $partNumber TEXT,
      $code TEXT,
      $uomQuantity REAL,
      $robCount REAL,
      $sectionName TEXT,
      $subSectionName TEXT,
      $description TEXT,
      $itemName TEXT,
      $categoryName TEXT,
      $isActive INTEGER DEFAULT 0
    )
  ''';

  static Future<void> onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      // Example migration: add new column in future
      await db.execute("ALTER TABLE $tableName ADD COLUMN extraField TEXT");
    }
  }
}
