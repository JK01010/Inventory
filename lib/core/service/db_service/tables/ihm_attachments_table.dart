import 'package:sqflite/sqflite.dart';

class IhmAttachmentsTable {
  static const tableName = 'ihm_attachments';

  static const String id = "id";
  static const String itemId = "itemId";
  static const String attachmentName = "attachmentName";
  static const String poId = "poId";
  static const String url = "url";
  static const String fileType = "fileType";
  static const String localUrl = "localUrl";
  static const String createdDate = "createdDate";
  static const String fileSize = "fileSize";
  static const String isSync = "isSync";

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $itemId TEXT NOT NULL,
      $attachmentName TEXT NOT NULL,
      $poId TEXT NOT NULL,
      $url TEXT NOT NULL,
      $fileType TEXT NOT NULL,
      $localUrl TEXT NOT NULL,
      $createdDate TEXT NOT NULL,
      $fileSize TEXT NOT NULL,
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