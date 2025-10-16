import 'package:sqflite/sqflite.dart';

class QualityTable {
  static const tableName = 'quality';

  static const id = 'ID';
  static const hdId = 'HDID';
  static const hdCode = 'HDCode';
  static const code = 'Code';
  static const typeName = 'TypeName';
  static const isActive = 'IsActive';
  static const sortOrder = 'SortOrder';
  static const remarks = 'Remarks';
  static const createdById = 'CreatedByID';
  static const createdOn = 'CreatedOn';
  static const modifiedById = 'ModifiedByID';
  static const modifiedOn = 'ModifiedOn';

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY,
      $hdId INTEGER,
      $hdCode TEXT,
      $code TEXT,
      $typeName TEXT,
      $isActive INTEGER,
      $sortOrder INTEGER,
      $remarks TEXT,
      $createdById INTEGER,
      $createdOn TEXT,
      $modifiedById INTEGER,
      $modifiedOn TEXT
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
