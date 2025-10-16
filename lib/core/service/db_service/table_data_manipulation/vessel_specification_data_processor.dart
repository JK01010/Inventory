import 'package:sqflite_sqlcipher/sqflite.dart';
import '../../../../features/common_feature/data/model/vessel_model.dart';
import '../../../../features/good_receipts/data/models/transaction_filter_model.dart';
import '../tables/transaction_table.dart';
import '../tables/vessel_specification_table.dart';

abstract interface class VesselSpecificationDataProcessor {
  Future<void> insertVesselData({required List<VesselModel> vesselModel});

  Future<List<Map<String, dynamic>>> getAllVesselData();
}

class VesselSpecificationDataProcessorImpl
    implements VesselSpecificationDataProcessor {
  VesselSpecificationDataProcessorImpl({required this.db});

  final Database db;

  @override
  Future<void> insertVesselData({
    required List<VesselModel> vesselModel,
  }) async {
    final Batch batch = db.batch();
    for (var element in vesselModel) {
      batch.insert(
        VesselTable.tableName,
        element.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

  @override
  Future<List<Map<String, dynamic>>> getAllVesselData({
    TransactionFilterModel? filter,
  }) async {
    const table = VesselTable.tableName;

    final data = await db.query(table);

    return data;
  }
}
