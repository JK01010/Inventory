import 'package:sqflite/sqflite.dart';

import '../../../../features/good_receipts/data/models/item_category_config_model.dart';
import '../../../di/service_locator.dart';
import '../../../utils/app_logger.dart';
import '../tables/item_category_config_table.dart';

abstract interface class ItemCategoryConfigDataProcessor {
  Future<void> insertItemCategoryConfigItems({
    required List<ItemCategoryConfigModelData> itemCategoryConfigModelList,
  });
}

class ItemCategoryConfigDataProcessorImpl
    implements ItemCategoryConfigDataProcessor {
  ItemCategoryConfigDataProcessorImpl({required this.db});
  final Database db;
  @override
  Future<void> insertItemCategoryConfigItems({
    required List<ItemCategoryConfigModelData> itemCategoryConfigModelList,
  }) async {
    try {
      final Batch batch = db.batch();
      for (var itemCategoryConfigModel in itemCategoryConfigModelList) {
        batch.insert(
          ItemCategoryConfigTable.tableName,
          {
            ItemCategoryConfigTable.itemCategoryID:
                itemCategoryConfigModel.itemCategoryId,
            ItemCategoryConfigTable.propertyCode:
                itemCategoryConfigModel.propertyCode,
            ItemCategoryConfigTable.propertyValue:
                itemCategoryConfigModel.propertyValue,
            ItemCategoryConfigTable.propertyID:
                itemCategoryConfigModel.propertyId,
          },
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }
      await batch.commit();
    } catch (e) {}
  }
}
