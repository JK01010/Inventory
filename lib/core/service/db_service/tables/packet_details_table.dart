import 'package:sqflite/sqflite.dart';

import 'goods_receipt_detail_label_table.dart';
import 'purchase_order_table.dart';

class PacketDetailsTable {
  static const tableName = 'packet_details';

  static const id = 'id';
  static const poId = 'poId';
  static const poDtId = 'poDtId';
  static const width = 'width';
  static const length = 'length';
  static const height = 'height';
  static const weight = 'weight';
  static const actualVolume = 'actualVolume';
  static const packetName = 'packetName';
  static const grnHdId = 'grnHdId';

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY,
      $poId TEXT NOT NULL,
      $poDtId INTEGER NOT NULL,
      $width REAL NOT NULL,
      $length REAL NOT NULL,
      $height REAL NOT NULL,
      $weight REAL NOT NULL,
      $actualVolume REAL NOT NULL,
      $packetName TEXT NOT NULL,
      $grnHdId INTEGER NOT NULL,
      FOREIGN KEY ($poId) REFERENCES Purchase_HD(${PurchaseOrderTable.poHdId})
    )
  ''';

  //,
  //       FOREIGN KEY ($poDtId) REFERENCES purchase_DT(${GoodsReceiptDetailLabelTable.grnId})

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
