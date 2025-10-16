class AdminStructureTable{

  static const tableName = 'admin_structure';

  static const id = 'id';
  static const code = 'code';
  static const typeName = 'typeName';
  static const isActive = 'isActive';

  static const createTableQuery = '''
  CREATE TABLE $tableName (
    $id INTEGER PRIMARY KEY,
    $code TEXT,
    $typeName TEXT,
    $isActive INTEGER
  )
''';

}