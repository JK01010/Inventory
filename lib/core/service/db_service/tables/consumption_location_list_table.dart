import 'package:sqflite/sqflite.dart';

class ConsumptionLocationListTable{
  static const tableName = 'location_list';

  static const id = 'id';
  static const parentId = 'parentId';
  static const name = 'name';
  static const code = 'code';
  static const parentName = 'parentName';
  static const activeFlag = 'activeFlag';
  static const type = 'type';
  static const sortOrder = 'sortOrder';

  static const createTableQuery = '''
  CREATE TABLE $tableName (
    $id INTEGER PRIMARY KEY,
    $parentId INTEGER,
    $name TEXT,
    $code TEXT,
    $parentName TEXT,
    $activeFlag TEXT,
    $type TEXT,
    $sortOrder INTEGER 
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