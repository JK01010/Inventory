class PurchaseOrderItemsSerialNumbersTable {
  static const tableName = 'PurchaseOrderItemsSerialNumbers';

  static const poHdId = 'poHdId';
  static const poDtId = 'poDtId';
  static const serialNumberId = 'serialNumberId';
  static const serialNumber = 'serialNumber';
  static const typeId = 'typeId';
  static const splitLocationId = 'splitLocationId';
  static const isManuallyEdited = 'isManuallyEdited';

  static const createTableQuery = '''
  CREATE TABLE $tableName (
    $serialNumberId INTEGER PRIMARY KEY,
    $poHdId INTEGER,
    $poDtId INTEGER,
    $serialNumber TEXT,
    $typeId INTEGER,
    $splitLocationId INTEGER,
    $isManuallyEdited INTEGER DEFAULT 0
  )
''';
}
