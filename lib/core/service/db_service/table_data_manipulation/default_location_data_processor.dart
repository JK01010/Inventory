import 'package:sqflite/sqflite.dart';
import '../../../../features/common_feature/data/model/default_location_model.dart';
import '../../../di/service_locator.dart';
import '../../../utils/app_logger.dart';
import '../app_database.dart';
import '../tables/default_location_table.dart';

abstract interface class DefaultLocationDataProcessor {
  Future<void> insertDefaultLocationItems({
    required List<DefaultLocationModel> defaultLocationModelList,
  });

  Future<List<Map<String, dynamic>>> getDefaultLocationItems();

  Future<void> clearDefaultLocationTable();
}

class DefaultLocationDataProcessorImpl implements DefaultLocationDataProcessor {
  DefaultLocationDataProcessorImpl({required this.db});

  final Database db;

  @override
  Future<void> insertDefaultLocationItems({
    required List<DefaultLocationModel> defaultLocationModelList,
  }) async {
    final Batch batch = db.batch();

    for (var defaultLocationModelItem in defaultLocationModelList) {
      batch.insert(
        DefaultLocationTable.tableName,
        defaultLocationModelItem.toJson(),
      );
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<List<Map<String, dynamic>>> getDefaultLocationItems() async {
    final db = await AppDatabase.getInstance();
    return db.query(DefaultLocationTable.tableName);
  }

  @override
  Future<void> clearDefaultLocationTable() async {
    await db.delete(DefaultLocationTable.tableName);
  }
}
