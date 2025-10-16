import 'package:sqflite/sqflite.dart';

class BaggingItemDetailsTable {
  static const tableName = 'bagging_item_details';

  static const String itemId = "itemId";
  static const String roughItemId = "roughItemId";
  static const String articleNo = "articleNo";
  static const String partNo = "partNo";
  static const String productName = "productName";
  static const String plateDrawingNo = "plateDrawingNo";
  static const String uom = "uom";
  static const String packSize = "packSize";
  static const String poQty = "poQty";
  static const String unitPrize = "unitPrize";
  static const String totalAcceptedQty = "totalAcceptedQty";
  static const String returnQty = "returnQty";
  static const String imdgClass = "imdgClass";
  static const String remarksFromVendor = "remarksFromVendor";
  static const String equipment = "equipment";
  static const String itemCategory = "itemCategory";
  static const String itemSection = "itemSection";
  static const String itemSubSection = "itemSubSection";
  static const String receivedQty = "receivedQty";
  static const String damageWrongQty = "damageWrongQty";
  static const String newStock = "newStock";
  static const String reconditionStock = "reconditionStock";
  static const String quality = "quality";
  static const String expiryDate = "expiryDate";
  static const String batchNo = "batchNo";
  static const String serialNo = "serialNo";
  static const String remarks = "remarks";
  static const String defaultStorageLocation = "defaultStorageLocation";
  static const String attachment = "attachment";
  static const String mdRequired = "mdRequired";
  static const String sDocRequired = "sDocRequired";
  static const String zeroDeclaration = "zeroDeclaration";
  static const String iHMMaterialQty = "iHMMaterialQty";
  static const String iHMAttachment = "iHMAttachment";

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      $itemId INTEGER NOT NULL,
      $roughItemId INTEGER NOT NULL,
      $articleNo INTEGER NOT NULL,
      $partNo INTEGER NOT NULL,
      $productName TEXT NOT NULL,
      $plateDrawingNo INTEGER NOT NULL,
      $uom TEXT NOT NULL,
      $packSize INTEGER NOT NULL,
      $poQty INTEGER NOT NULL,
      $unitPrize INTEGER NOT NULL,
      $totalAcceptedQty INTEGER NOT NULL,
      $returnQty INTEGER NOT NULL,
      $imdgClass TEXT NOT NULL,
      $remarksFromVendor TEXT NOT NULL,
      $equipment TEXT NOT NULL,
      $itemCategory TEXT NOT NULL,
      $itemSection INTEGER NOT NULL,
      $itemSubSection INTEGER NOT NULL,
      $receivedQty INTEGER NOT NULL,
      $damageWrongQty INTEGER NOT NULL,
      $newStock INTEGER NOT NULL,
      $reconditionStock INTEGER NOT NULL,
      $quality INTEGER NOT NULL,
      $expiryDate TEXT NOT NULL,
      $batchNo TEXT NOT NULL,
      $serialNo TEXT NOT NULL,
      $remarks TEXT NOT NULL,
      $defaultStorageLocation TEXT NOT NULL,
      $attachment TEXT,
      $mdRequired TEXT NOT NULL,
      $sDocRequired TEXT NOT NULL,
      $zeroDeclaration TEXT NOT NULL,
      $iHMMaterialQty TEXT NOT NULL,
      $iHMAttachment TEXT      

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
