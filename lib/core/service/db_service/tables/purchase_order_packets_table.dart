class PurchaseOrderPacketsTable {
  static const tableName = 'PurchaseOrderPacketsTable';

  static const id = "id";
  static const poHdId = 'poHdId';
  static const width = 'width';
  static const length = 'length';
  static const height = 'height';
  static const weight = 'weight';
  static const actualVolume = 'actualVolume';
  static const packetName = 'packetName';

  static const createTableQuery = '''
  CREATE TABLE $tableName (
    $id INTEGER PRIMARY KEY,
    $poHdId INTEGER,
    $width REAL,
    $length TEXT,
    $height INTEGER,
    $weight INTEGER,
    $actualVolume INTEGER,
    $packetName TEXT
  )
''';
}
