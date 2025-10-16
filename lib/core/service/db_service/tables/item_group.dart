import 'package:sqflite/sqflite.dart';

class ItemGroup{

  static const tableName = 'itemGroup';

  static const itemCode = 'itemCode';
  static const rfid = 'rfid';
  static const quantity = 'quantity';
  static const canUpdateQuantity = 'canUpdateQuantity';
  static const storageLocation = 'storageLocation';

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $itemCode TEXT NOT NULL,
      $rfid TEXT NOT NULL,
      $quantity INTEGER NOT NULL,
      $canUpdateQuantity TEXT NOT NULL,
      $storageLocation TEXT NOT NULL
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