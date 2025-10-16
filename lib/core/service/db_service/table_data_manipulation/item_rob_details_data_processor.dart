import 'package:sqflite/sqflite.dart';

import '../../../../features/good_receipts/data/models/item_rob_details_model.dart';
import '../../../di/service_locator.dart';
import '../../../utils/app_logger.dart';
import '../tables/item_rob_details_table.dart';

abstract interface class ItemRobDetailsDataProcessor{
  Future<void> insertItemRobDetails({required List<ItemRobDetailsModelData> itemRobDetailsModelList});
  Future<List<Map<String, dynamic>>> getItemRobDetails(); // 🔥 add this
}

class ItemRobDetailsDataProcessorImpl implements ItemRobDetailsDataProcessor{
  ItemRobDetailsDataProcessorImpl({required this.db});
  final Database db;
  @override
  Future<void> insertItemRobDetails({required List<ItemRobDetailsModelData> itemRobDetailsModelList}) async {
    try{
      final Batch batch = db.batch();
      for (var itemRobDetailsModel in itemRobDetailsModelList) {
        batch.insert(
          ItemRobDetailsTable.tableName,
          {
            ItemRobDetailsTable.storageLocationID:
                itemRobDetailsModel.storageLocationId,
            ItemRobDetailsTable.storageLocation:
                itemRobDetailsModel.storageLocation,
            ItemRobDetailsTable.storageLocationHierarchy:
                itemRobDetailsModel.storageLocationHierarchy,
            ItemRobDetailsTable.referenceID: itemRobDetailsModel.referenceId,
            ItemRobDetailsTable.referenceSubID:
                itemRobDetailsModel.referenceSubId,
            ItemRobDetailsTable.referenceTypeID:
                itemRobDetailsModel.referenceTypeId,
            ItemRobDetailsTable.itemID: itemRobDetailsModel.itemId,
            ItemRobDetailsTable.itemLinkID: itemRobDetailsModel.itemLinkId,
            ItemRobDetailsTable.inventoryDate: itemRobDetailsModel
                .inventoryDate.toString(),
            ItemRobDetailsTable.expiryDate: itemRobDetailsModel.expiryDate!=null?itemRobDetailsModel.expiryDate.toString():"",
            ItemRobDetailsTable.totalROB: itemRobDetailsModel.totalRob,
            ItemRobDetailsTable.newStock: itemRobDetailsModel.newStock,
            ItemRobDetailsTable.reconditionedStock: itemRobDetailsModel.reconditionedStock,

          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit();
    }catch(e){
      sl<AppLogger>().info(
        "Exception in inserting item Rob Details data : ${e.toString()}  ",
      );

  }

  }

  @override
  Future<List<Map<String, dynamic>>> getItemRobDetails() async {
    try {
      return await db.query(ItemRobDetailsTable.tableName);
    } catch (e) {
      sl<AppLogger>().info("Exception in fetching ItemRobDetails : ${e.toString()}");
      return [];
    }
  }

}