class ItemCategoryConfigTable{
  static const tableName= "ItemCategoryConfigTable";
  static const String id = "id";
  static const String propertyValue = "PropertyValue";
  static const String itemCategoryID = "ItemCategoryID";
  static const String propertyID = "PropertyID";
  static const String propertyCode = "PropertyCode";


  static String createTableQuery='''
  CREATE TABLE $tableName (
    $id INTEGER PRIMARY KEY AUTOINCREMENT,
    $propertyValue TEXT NOT NULL,
    $itemCategoryID INTEGER NOT NULL,
    $propertyID INTEGER NOT NULL,
    $propertyCode TEXT NOT NULL
  )
''';
}
