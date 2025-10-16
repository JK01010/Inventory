import 'package:sqflite/sqflite.dart';

class BaggingConfirmationListTable{
  static const tableName = 'bagging_confirmation_list';

  static const String id = "id";
  static const String poId = "poId";
  static const String poCode = "poCode";
  static const String transactionId = "transactionId";
  static const String grnNo = "grnNo";
  static const String status = "status";
  static const String syncStatus = "syncStatus";
  static const String syncMessage = "syncMessage";
  static const String storageLocationCount = "storageLocationCount";
  static const String storageLocationId = "storageLocationId";

  static String createTableQuery = '''
  CREATE TABLE $tableName (
    $id INTEGER NOT NULL PRIMARY KEY,
    $poId TEXT NOT NULL,
    $poCode TEXT NOT NULL,
    $transactionId TEXT NOT NULL,
    $grnNo TEXT NOT NULL,
    $status TEXT NOT NULL,
    $syncStatus TEXT NOT NULL,
    $syncMessage TEXT NOT NULL,
    $storageLocationCount INT NOT NULL,
    $storageLocationId INT NOT NULL
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