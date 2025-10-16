import 'package:sqflite/sqflite.dart';

class GRNLocationSerialMappingTable {
  static const tableName = 'grn_location_serial_mapping';

  static const String id = "ID";
  static const String serialNumberId = "SerialNumberID";
  static const String serialNumber = "SerialNumber";
  static const String grnHdId = "GRNHDID";
  static const String grnDtId = "GRNDTID";

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY,
      $serialNumberId INTEGER NOT NULL,
      $serialNumber TEXT NOT NULL,
      $grnHdId INTEGER NOT NULL,
      $grnDtId INTEGER NOT NULL
    )
  ''';

  static Future<void> onUpgrade(
      Database db,
      int oldVersion,
      int newVersion,
      ) async {
    if (oldVersion < 2) {
      // Example migration: add new column later
      await db.execute("ALTER TABLE $tableName ADD COLUMN extraField TEXT");
    }
  }
}
