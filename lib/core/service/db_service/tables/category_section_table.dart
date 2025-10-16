import 'package:sqflite/sqflite.dart';

class CategorySectionTable {
  static const tableName = 'Category_Section_Master_List';

  static const String code = "code";
  static const String name="name";
  static const String parentId="parentId";
  static const String type="type";


  static String createTableQuery = '''
    CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      $code TEXT NOT NULL,
      $name TEXT NOT NULL,
      $parentId INTEGER NOT NULL,
      $type TEXT NOT NULL,

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
