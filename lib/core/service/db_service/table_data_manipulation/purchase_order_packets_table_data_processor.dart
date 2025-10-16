import 'package:sqflite/sqflite.dart';
import '../../../../features/packets/add_packets_sheet/data/model/packets_data_model.dart';
import '../tables/purchase_order_packets_table.dart';

abstract interface class PurchaseOrderPacketsTableDataProcessor {
  Future<void> insertOrUpdatePurchaseOrderPackets({
    required List<PacketsDataModel> packets,
  });

  Future<List<Map<String, dynamic>>> getPurchaseOrderPackets({
    required int poHdId,
  });
}

class PurchaseOrderPacketsTableDataProcessorImpl
    implements PurchaseOrderPacketsTableDataProcessor {
  PurchaseOrderPacketsTableDataProcessorImpl({required this.db});

  final Database db;

  @override
  Future<void> insertOrUpdatePurchaseOrderPackets({
    required List<PacketsDataModel> packets,
  }) async {
    final Batch batch = db.batch();
    for (var element in packets) {
      final existingRecord = await db.query(
        PurchaseOrderPacketsTable.tableName,
        where: '${PurchaseOrderPacketsTable.id} = ?',
        whereArgs: [element.id],
      );
      if (existingRecord.isEmpty) {
        batch.insert(PurchaseOrderPacketsTable.tableName, element.toJson());
      } else {
        batch.update(
          PurchaseOrderPacketsTable.tableName,
          element.toJson(),
          where: '${PurchaseOrderPacketsTable.id} = ?',
          whereArgs: [element.id],
        );
      }
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<List<Map<String, dynamic>>> getPurchaseOrderPackets({
    required int poHdId,
  }) async {
    final result = await db.query(
      PurchaseOrderPacketsTable.tableName,
      where: '${PurchaseOrderPacketsTable.poHdId} = ?',
      whereArgs: [poHdId],
    );
    return result;
  }
}
