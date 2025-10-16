import 'package:sqflite/sqflite.dart';

class ItemMasterTable {
  static const tableName = 'item_master';

  static const activeFlag = 'activeFlag';
  static const itemCode = 'itemCode';
  static const drawingNo = 'drawingNo';
  static const equipmentFlag = 'equipmentFlag';
  static const equipmentId = 'equipmentId';
  static const equipmentName = 'equipmentName';
  static const itemId = 'itemId';
  static const totalAcceptedQty = 'totalAcceptedQty';
  static const returnQty = 'returnQty';
  static const articleNumber = 'articleNumber';
  static const itemName = 'itemName';
  static const partNo = 'partNo';
  static const uomId = 'uomId';
  static const uomName = 'uomName';
  static const uomCode = 'uomCode';
  static const stockAdjustmentFlag = 'stockAdjustmentFlag';
  static const defaultStorageLocationId = 'defaultStorageLocationId';
  static const categoryId = 'categoryId';
  static const sectionId = 'sectionId';
  static const subSectionId = 'subSectionId';
  static const serialNo = 'serialNo';
  static const ihm = 'ihm';
  static const groupId = 'groupId';
  static const mdRequired = 'mdRequired';
  static const sDocRequired = 'sDocRequired';
  static const zeroDeclaration = 'zeroDeclaration';
  static const packSize = 'packSize';
  static const iMDGClassName = 'iMDGClassName';
  static const minStock = 'minStock';
  static const maxStock = 'maxStock';
  static const spareId = 'spareId';

  static const createTableQuery = '''
CREATE TABLE $tableName (
  $itemId INTEGER PRIMARY KEY,
  $itemCode TEXT,
  $defaultStorageLocationId INTEGER,
  $partNo TEXT,
  $drawingNo TEXT,
  $articleNumber TEXT ,
  $itemName TEXT ,
  $uomId INTEGER ,
  $uomCode TEXT ,
  $uomName TEXT ,
  $totalAcceptedQty INTEGER,
  $returnQty INTEGER ,
  $stockAdjustmentFlag TEXT ,
  $equipmentId INTEGER ,
  $equipmentName TEXT ,
  $equipmentFlag TEXT ,
  $activeFlag INTEGER ,
  $categoryId INTEGER ,
  $sectionId INTEGER ,
  $subSectionId INTEGER ,
  $serialNo TEXT ,
  $ihm INTEGER ,
  $groupId INTEGER ,
  $mdRequired INTEGER ,
  $sDocRequired INTEGER ,
  $zeroDeclaration INTEGER ,
  $packSize TEXT ,
  $iMDGClassName TEXT,
  $minStock INTEGER ,  
  $maxStock INTEGER ,
  $spareId INTEGER 
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
