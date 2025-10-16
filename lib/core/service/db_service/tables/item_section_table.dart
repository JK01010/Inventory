import 'package:sqflite/sqflite.dart';

class ItemSectionTable {
  static const tableName = 'itemSection';

  static const id = 'id';
  static const categoryId = 'categoryId';
  static const code = 'code';
  static const sectionName = 'sectionName';

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $id INTEGER NOT NULL,
      $categoryId INTEGER NOT NULL,
      $code TEXT NOT NULL,
      $sectionName TEXT NOT NULL
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
