import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../features/common_feature/data/model/quality_list_model.dart';
import '../../../../features/good_receipts/data/models/goods_receipt_purchase_item_detail_model.dart';
import '../../../di/service_locator.dart';
import '../../../utils/app_logger.dart';
import '../app_database.dart';
import '../tables/quality_table.dart';
import '../tables/split_location_table.dart';

abstract interface class QualityTableDataProcessor {
  Future<void> insertQualityList({
    required List<QualityListData> qualityListData,
  });

  Future<List<Map<String, dynamic>>> getQualityList();
}

class QualityTableDataProcessorImpl implements QualityTableDataProcessor {
  QualityTableDataProcessorImpl({required this.db});

  final Database db;

  @override
  Future<void> insertQualityList({
    required List<QualityListData> qualityListData,
  }) async {
    final Batch batch = db.batch();

    for (var element in qualityListData) {
      final existing = await db.query(
        QualityTable.tableName,
        where: '${QualityTable.id} = ?',
        whereArgs: [element.id],
        limit: 1,
      );
      if (existing.isEmpty) {
        batch.insert(
          QualityTable.tableName,
          element.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      } else {
        batch.rawQuery(
          """
        UPDATE ${QualityTable.tableName} SET ${QualityTable.isActive} = ? WHERE ${QualityTable.id} = ?
        """,
          [element.isActive == true ? 1 : 0],
        );
      }
    }
    await batch.commit();
  }

  @override
  Future<List<Map<String, dynamic>>> getQualityList() async {
    return db.query(
      QualityTable.tableName,
      where: "${QualityTable.isActive} = ?",
      whereArgs: [1],
    );
  }
}
