import 'package:sqflite/sqflite.dart';

class BaggingTaggingPendingTable {
  static const tableName = 'bt_purchase_hd';

  static const String id = "id";
  static const String poId = "poId";
  static const String poCode = "poCode";
  static const String portId = "portId";
  static const String poRemark = "poRemark";
  static const String transactionMobRefId = "transactionMobRefId";
  static const String items = "items";
  static const String grnNo = "grnNo";
  static const String grnDate = "grnDate";
  static const String isFull = "isFull";
  static const String modifiedOn = "modifiedOn";
  static const String deliveryRef = "deliveryRef";
  static const String isBaggingComplete = "isBaggingComplete";
  static const String tag = "tag";
  static const String status = "status";
  static const String syncStatus = "syncStatus";
  static const String syncMessage = "syncMessage";
  static const String storageLocation = "storageLocation";
  static const String eta = "eta";
  static const String categoryId = "categoryId";
  static const String categoryName = "categoryName";
  static const String receivedDate = "receivedDate";
  static const String title = "title";
  static const String countryCode = "countryCode";
  static const String countryName = "countryName";
  static const String packetSize = "packetSize";
  static const String weight = "weight";
  static const String actualVolume = "actualVolume";
  static const String partial = "partial";

  static String createTableQuery = '''
  CREATE TABLE $tableName (
    $id INTEGER NOT NULL PRIMARY KEY,
    $poId TEXT NOT NULL,
    $poCode TEXT NOT NULL,
    $portId INTEGER,
    $poRemark TEXT,
    $transactionMobRefId TEXT,
    $items TEXT,
    $grnNo TEXT,
    $tag TEXT,
    $isBaggingComplete TEXT,
    $isFull TEXT,
    $modifiedOn TEXT,
    $grnDate TEXT,
    $deliveryRef TEXT,
    $status TEXT,
    $syncStatus TEXT,
    $syncMessage TEXT,
    $storageLocation TEXT,
    $eta TEXT,
    $title TEXT,
    $receivedDate TEXT,
    $categoryId TEXT,
    $categoryName TEXT,
    $countryCode TEXT,
    $countryName TEXT,
    $packetSize TEXT,
    $weight TEXT,
    $actualVolume TEXT,
    $partial TEXT
    )
  ''';


  static Future<void> onUpgrade(
      Database db,
      int oldVersion,
      int newVersion,
      ) async {
    if (oldVersion < newVersion) {
    }
  }
}
