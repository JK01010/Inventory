import 'package:sqflite/sqflite.dart';

class ItemsAttachmentsTable {
  static const tableName = 'items_attachments';

  static const String id = "id";
  static const String dtId = "dtId";
  static const String fileName = "fileName";
  static const String itemId = "itemId";
  static const String poId = "poId";
  static const String url = "url";
  static const String fileType = "fileType";
  static const String fileSize = "fileSize";
  static const String date = "date";
  static const String localUrl = "localUrl";
  static const String transactionDtId = "transactionDtId";
  static const String isSync = "isSync";

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $dtId TEXT NOT NULL,
      $fileName TEXT NOT NULL,
      $itemId TEXT NOT NULL,
      $poId TEXT NOT NULL,
      $url TEXT NOT NULL,
      $fileType TEXT NOT NULL,
      $fileSize TEXT NOT NULL,
      $date TEXT NOT NULL,
      $localUrl TEXT NOT NULL,
      $transactionDtId TEXT NOT NULL,
      $isSync TEXT NOT NULL
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
