import 'package:sqflite/sqflite.dart';

class ItemSubSectionTable {
  static const tableName = 'itemSubSection';

  static const id = 'id';
  static const sectionId = 'sectionId';
  static const code = 'code';
  static const subSectionName = 'subSectionName';

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $id INTEGER NOT NULL,
      $sectionId INTEGER NOT NULL,
      $code TEXT NOT NULL,
      $subSectionName TEXT NOT NULL
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
