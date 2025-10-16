import 'package:sqflite/sqflite.dart';

class ItemCategoryTable {
  static const tableName = 'itemCategory';

  static const id = 'ID';
  static const code = 'Code';
  static const categoryName = 'CategoryName';

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $id INTEGER NOT NULL,
      $code TEXT NOT NULL,
      $categoryName TEXT NOT NULL
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
