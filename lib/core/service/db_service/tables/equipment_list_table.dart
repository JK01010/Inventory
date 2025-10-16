import 'package:sqflite/sqflite.dart';

class EquipmentListTable {
  static const tableName = 'equipment_list';

  static const vesselStructureId = 'vesselStructureId';
  static const vesselComponentId = 'vesselComponentId';
  static const componentName = 'componentName';
  static const parentEquipmentId = 'parentEquipmentId';
  static const code = 'code';
  static const equipmentTypeId = 'equipmentTypeId';
  static const equipmentType = 'equipmentType';

  static const createTableQuery = '''
  CREATE TABLE $tableName (
    $vesselStructureId INTEGER PRIMARY KEY,
    $vesselComponentId INTEGER,
    $componentName TEXT,
    $parentEquipmentId INTEGER,
    $code TEXT,
    $equipmentTypeId INTEGER,
    $equipmentType TEXT
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
