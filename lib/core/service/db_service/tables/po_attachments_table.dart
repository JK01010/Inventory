import 'package:sqflite/sqflite.dart';

class PoAttachmentsTable {
  static const tableName = 'PO_Attachments';

  static const String id = "ID";
  static const String poHDId = "POHDID";
  static const String applicationCode = "ApplicationCode";
  static const String pageCode = "PageCode";
  static const String documentUniqueID = "DocumentUniqueID";
  static const String attachmentType = "attachmentType";
  static const String isDeleted = "isDeleted";
  static const String isSync = "isSync";
  static const String isFileSync = "isFileSync";
  static const String fileSize = "fileSize";
  static const String filePath = "filePath";
  static const String fileExtension = "fileExtension";
  static const String contentType = "contentType";
  static const String operationType = "operationType";
  static const String fileName = "fileName";
  static const String chunkIndex = "chunkIndex";
  static const String chunkSize = "chunkSize";
  static const String fileHash = "fileHash";
  static const String totalChunk = "totalChunk";

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $documentUniqueID INTEGER NOT NULL, 
      $poHDId INTEGER NOT NULL, 
      $attachmentType TEXT NOT NULL, 
      $isDeleted INTEGER NOT NULL, 
      $isSync INTEGER NOT NULL, 
      $isFileSync INTEGER NOT NULL, 
      $fileSize INTEGER NOT NULL, 
      $filePath TEXT NOT NULL, 
      $fileExtension TEXT NOT NULL, 
      $contentType TEXT NOT NULL, 
      $operationType TEXT NOT NULL,
      $fileName TEXT NOT NULL,
      $chunkIndex TEXT NOT NULL,
      $chunkSize TEXT NOT NULL,
      $fileHash TEXT NOT NULL,
      $totalChunk TEXT NOT NULL
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
