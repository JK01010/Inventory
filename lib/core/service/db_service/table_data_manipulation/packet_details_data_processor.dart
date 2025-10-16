import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../features/good_receipts/data/models/grn_packet_details_fetch_api_response_model.dart';
import '../../../../features/good_receipts/data/models/packet_details_model.dart';
import '../../../di/service_locator.dart';
import '../../../utils/app_logger.dart';
import '../app_database.dart';
import '../tables/packet_details_table.dart';

abstract interface class PacketDetailsDataProcessor {
  Future<void> insertPacketDetailsItems({
    required List<GRNPacketDetailsModel> packetDetailModelList,
  });

  Future<List<Map<String, dynamic>>> getPacketDetailsItems();

  Future<Unit> updatePacketDetailsByPoId(
    String poId,
    PacketDetailsModel packetDetailsModel,
  );

  Future<Unit> updatePacketDetailsByPoDtId(
    int poDtId,
    PacketDetailsModel packetDetailsModel,
  );

  Future<List<Map<String, dynamic>>> getPacketDetailsByPoId({
    required String grnId,
  });

  Future<List<Map<String, dynamic>>> getPacketDetailsByPoDtId(int poDtId);

  Future<void> clearPacketDetailsTable();
}

class PacketDetailsDataProcessorImpl implements PacketDetailsDataProcessor {
  PacketDetailsDataProcessorImpl({required this.db});

  final Database db;

  @override
  Future<void> insertPacketDetailsItems({
    required List<GRNPacketDetailsModel> packetDetailModelList,
  }) async {
    final Batch batch = db.batch();

    for (var packetDetailModelItem in packetDetailModelList) {
      batch.insert(PacketDetailsTable.tableName, {
        PacketDetailsTable.id: packetDetailModelItem.id,
        // PacketDetailsTable.poId: packetDetailModelItem.poId,
        // PacketDetailsTable.poDtId: packetDetailModelItem.poDtId,
        PacketDetailsTable.poId: 0,
        PacketDetailsTable.poDtId: 0,
        PacketDetailsTable.width: packetDetailModelItem.width,
        PacketDetailsTable.length: packetDetailModelItem.length,
        PacketDetailsTable.height: packetDetailModelItem.height,
        PacketDetailsTable.weight: packetDetailModelItem.weight,
        PacketDetailsTable.actualVolume: packetDetailModelItem.actualVolume,
        PacketDetailsTable.packetName: packetDetailModelItem.packetName,
        PacketDetailsTable.grnHdId: packetDetailModelItem.grnHdId,
      });
    }
    await batch.commit();
  }

  @override
  Future<List<Map<String, dynamic>>> getPacketDetailsItems() async {
    final db = await AppDatabase.getInstance();
    return db.query(PacketDetailsTable.tableName);
  }

  @override
  Future<void> clearPacketDetailsTable() async {
    await db.delete(PacketDetailsTable.tableName);
  }

  @override
  Future<List<Map<String, dynamic>>> getPacketDetailsByPoId({
    required String grnId,
  }) async {
    // First try to get data using grnId for bagging tagging
    final grnResults = await db.rawQuery(
      '''
    SELECT * FROM ${PacketDetailsTable.tableName} 
    WHERE ${PacketDetailsTable.grnHdId} = ?
    ''',
      [grnId],
    );

    // If no results found with grnId, fall back to poId for goods receipt
    if (grnResults.isEmpty) {
      return db.rawQuery(
        '''
      SELECT * FROM ${PacketDetailsTable.tableName} 
      WHERE ${PacketDetailsTable.poId} = ?
      ''',
        [grnId],
      );
    }

    return grnResults;
  }

  @override
  Future<List<Map<String, dynamic>>> getPacketDetailsByPoDtId(
    int poDtId,
  ) async {
    final db = await AppDatabase.getInstance();
    return db.rawQuery(
      '''
    SELECT * FROM ${PacketDetailsTable.tableName} 
    WHERE ${PacketDetailsTable.poDtId} = ?
    ''',
      [poDtId],
    );
  }

  @override
  Future<Unit> updatePacketDetailsByPoId(
    String poId,
    PacketDetailsModel packetDetailsModel,
  ) async {
    await db.rawUpdate(
      '''
      UPDATE ${PacketDetailsTable.tableName}
      SET 
      ${PacketDetailsTable.actualVolume}=?
      WHERE ${PacketDetailsTable.poDtId} IN ($poId)
      ''',
      ["${packetDetailsModel.actualVolume}"],
    );
    return unit;
  }

  @override
  Future<Unit> updatePacketDetailsByPoDtId(
    int poDtId,
    PacketDetailsModel packetDetailsModel,
  ) async {
    await db.rawUpdate(
      '''
      UPDATE ${PacketDetailsTable.tableName}
      SET 
      ${PacketDetailsTable.actualVolume}=?
      WHERE ${PacketDetailsTable.poDtId} IN ($poDtId)
      ''',
      ["${packetDetailsModel.actualVolume}"],
    );
    return unit;
  }
}
