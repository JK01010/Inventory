import 'package:sqflite/sqflite.dart';
import '../../../../features/good_receipts/purchase_order_item_detail/data/models/serial_number_data.dart';
import '../tables/purchase_order_item_serial_numbers_table.dart';

abstract interface class PurchaseOrderItemSerialNumbersTableProcessor {
  Future<void> insertPurchaseOrderItemsSerialNumbers({
    required List<SerialNumberData> serialNumberData,
  });

  Future<List<Map<String, dynamic>>> getPurchaseOrderItemsSerialNumbers({
    required int poHdId,
    required int poDtId,
  });
}

class PurchaseOrderItemSerialNumbersTableProcessorImpl
    implements PurchaseOrderItemSerialNumbersTableProcessor {
  PurchaseOrderItemSerialNumbersTableProcessorImpl({required this.db});

  final Database db;

  @override
  Future<void> insertPurchaseOrderItemsSerialNumbers({
    required List<SerialNumberData> serialNumberData,
  }) async {
    final Batch batch = db.batch();
    for (var element in serialNumberData) {
      final existingRecord = await db.query(
        PurchaseOrderItemsSerialNumbersTable.tableName,
        where: '${PurchaseOrderItemsSerialNumbersTable.serialNumberId} = ?',
        whereArgs: [element.id],
      );
      if (existingRecord.isEmpty) {
        batch.insert(
          PurchaseOrderItemsSerialNumbersTable.tableName,
          element.toJsonForPurchaseOrderTableSave(),
        );
      } else {
        batch.update(
          PurchaseOrderItemsSerialNumbersTable.tableName,
          element.toJsonForPurchaseOrderTableSave(),
          where: '${PurchaseOrderItemsSerialNumbersTable.serialNumberId} = ?',
          whereArgs: [element.id],
        );
      }
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<List<Map<String, dynamic>>> getPurchaseOrderItemsSerialNumbers({
    required int poHdId,
    required int poDtId,
  }) async {
    final result = await db.query(
      PurchaseOrderItemsSerialNumbersTable.tableName,
      where:
          '${PurchaseOrderItemsSerialNumbersTable.poHdId} = ? AND ${PurchaseOrderItemsSerialNumbersTable.poDtId} = ?',
      whereArgs: [poHdId, poDtId],
    );
    return result;
  }
}
