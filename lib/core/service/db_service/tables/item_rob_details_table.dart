class ItemRobDetailsTable{
  static const tableName="ItemRobDetails";
  static const String id = "id";
  static const String storageLocationID = "StorageLocationID";
  static const String storageLocation = "StorageLocation";
  static const String storageLocationHierarchy = "StorageLocationHierarchy";
  static const String referenceID = "ReferenceID";
  static const String referenceSubID = "ReferenceSubID";
  static const String referenceTypeID = "ReferenceTypeID";
  static const String itemID = "ItemID";
  static const String itemLinkID = "ItemLinkID";
  static const String inventoryDate = "InventoryDate";
  static const String expiryDate = "ExpiryDate";
  static const String totalROB = "TotalROB";
  static const String newStock = "NewStock";
  static const String reconditionedStock = "ReconditionedStock";
  static const String receivedQty = "ReceivedQty";

  static String createTableQuery='''
  CREATE TABLE $tableName (
    $id INTEGER PRIMARY KEY AUTOINCREMENT,
    $storageLocationID INTEGER ,
    $storageLocation TEXT ,
    $storageLocationHierarchy TEXT ,
    $referenceID INTEGER ,
    $referenceSubID INTEGER ,
    $referenceTypeID INTEGER ,
    $itemID INTEGER ,
    $itemLinkID INTEGER ,
    $inventoryDate TEXT ,
    $expiryDate TEXT,
    $totalROB REAL,
    $newStock REAL,
    $reconditionedStock REAL,
    $receivedQty REAL
    )
  ''';
}