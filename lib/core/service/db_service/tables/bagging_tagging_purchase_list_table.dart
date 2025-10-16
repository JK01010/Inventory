import 'package:sqflite/sqflite.dart';

class BaggingTaggingPurchaseListTable {
  static const tableName = 'bt_purchase_dt';

  static const String id = "id";
  static const String itemId = "itemId";
  static const String poHdId = "poHdId";
  static const String receivedQty = "receivedQty";
  static const String remark = "remark";
  static const String qualityId = "qualityId";
  static const String flag = "flag";
  static const String tags = "tags";
  static const String imdgClassId = "imdgClassId";
  static const String unitPrice = "unitPrice";
  static const String packetSize = "packetSize";
  static const String poQty = "poQty";
  static const String remarksFromVendor = "remarksFromVendor";
  static const String reconditionedQty = "reconditionedQty";
  static const String damagedQty = "damagedQty";
  static const String newQty = "newQty";
  static const String batchName = "batchName";
  static const String expiryDate = "expiryDate";

  static String createTableQuery = '''
  CREATE TABLE $tableName (
    $id INTEGER NOT NULL PRIMARY KEY,
    $itemId INTEGER NOT NULL,
    $poHdId INTEGER NOT NULL,
    $receivedQty INTEGER NOT NULL,
    $remark TEXT,
    $qualityId INTEGER,
    $flag TEXT,
    $tags TEXT,
    $imdgClassId INTEGER,
    $unitPrice TEXT,
    $packetSize TEXT,
    $poQty INTEGER,
    $remarksFromVendor TEXT,
    $reconditionedQty INTEGER,
    $damagedQty INTEGER,
    $newQty INTEGER,
    $batchName TEXT,
    $expiryDate TEXT
    )
  ''';

  static Future<void> onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < newVersion) {}
  }
}
