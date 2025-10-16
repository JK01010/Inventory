import 'package:sqflite_sqlcipher/sqflite.dart';
import '../../../../features/common_feature/data/model/admin_structure_model.dart';
import '../../../../features/common_feature/data/model/vessel_model.dart';
import '../../../../features/good_receipts/data/models/transaction_filter_model.dart';
import '../tables/admin_structure.dart';
import '../tables/transaction_table.dart';
import '../tables/vessel_specification_table.dart';

abstract interface class AdminStructureDataProcessor {

  Future<void> insertAdminStructure({required List<AdminStructureModel> list});

  Future<List<Map<String, dynamic>>> getAllAdminStructureDetails();
}

class AdminStructureDataProcessorImpl
    implements AdminStructureDataProcessor {
  AdminStructureDataProcessorImpl({required this.db});

  final Database db;

  @override
  Future<void> insertAdminStructure({
    required List<AdminStructureModel> list,
  }) async {
    final Batch batch = db.batch();
    for (var element in list) {
      batch.insert(
        AdminStructureTable.tableName,
        element.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

  @override
  Future<List<Map<String, dynamic>>> getAllAdminStructureDetails({
    TransactionFilterModel? filter,
  }) async {
    const table = AdminStructureTable.tableName;

    final data = await db.query(table);

    return data;
  }
}
