import 'package:sqflite/sqflite.dart';

class IMDGClassTable {
  static const tableName = 'imdg_class';

  static const id = 'ID';
  static const code = 'Code';
  static const typeName = 'TypeName';
  static const isActive = 'IsActive';

  static const createTableQuery = '''
  CREATE TABLE $tableName (
    $id INTEGER PRIMARY KEY,
    $code TEXT,
    $typeName TEXT,
    $isActive INTEGER
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
