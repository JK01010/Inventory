import 'package:sqflite/sqflite.dart';

import '../../../features/bagging_tagging_confirmtaion/model/bagging_item_details_model.dart';
import 'tables/bagging_item_details_table.dart' show BaggingItemDetailsTable;

abstract interface class BaggingItemDetailsDataSource {
  Future<void> insertItemDetailsData({
    required List<BaggingItemDetailModel> baggingItemDetailModel,
  });
  Future<List<Map<String, dynamic>>> getAllBaggingItemDetails();
  Future<void> clearItemDetailsDataTable();
}

class BaggingItemDetailsDataSourceImpl implements BaggingItemDetailsDataSource {
  BaggingItemDetailsDataSourceImpl({required this.db});

  final Database db;
  @override
  Future<void> insertItemDetailsData({
    required List<BaggingItemDetailModel> baggingItemDetailModel,
  }) async {
    final Batch batch = db.batch();

    for (var element in baggingItemDetailModel) {
      batch.insert(BaggingItemDetailsTable.tableName, {
        BaggingItemDetailsTable.itemId: element.itemId,
        BaggingItemDetailsTable.roughItemId: element.roughItemId,
        BaggingItemDetailsTable.articleNo: element.articleNo,
        BaggingItemDetailsTable.partNo: element.partNo,
        BaggingItemDetailsTable.productName: element.productName,
        BaggingItemDetailsTable.plateDrawingNo: element.plateDrawingNo,
        BaggingItemDetailsTable.uom: element.uom,
        BaggingItemDetailsTable.packSize: element.packSize,
        BaggingItemDetailsTable.poQty: element.poQty,
        BaggingItemDetailsTable.unitPrize: element.unitPrize,
        BaggingItemDetailsTable.totalAcceptedQty: element.totalAcceptedQty,
        BaggingItemDetailsTable.returnQty: element.returnQty,
        BaggingItemDetailsTable.imdgClass: element.imdgClass,
        BaggingItemDetailsTable.remarksFromVendor: element.remarksFromVendor,
        BaggingItemDetailsTable.equipment: element.equipment,
        BaggingItemDetailsTable.itemCategory: element.itemCategory,
        BaggingItemDetailsTable.itemSection: element.itemSection,
        BaggingItemDetailsTable.itemSubSection: element.itemSubSection,
        BaggingItemDetailsTable.receivedQty: element.receivedQty,
        BaggingItemDetailsTable.damageWrongQty: element.damageWrongQty,
        BaggingItemDetailsTable.newStock: element.newStock,
        BaggingItemDetailsTable.reconditionStock: element.reconditionStock,
        BaggingItemDetailsTable.quality: element.quality,
        BaggingItemDetailsTable.expiryDate: element.expiryDate,
        BaggingItemDetailsTable.batchNo: element.batchNo,
        BaggingItemDetailsTable.serialNo: element.serialNo,
        BaggingItemDetailsTable.remarks: element.remarks,
        BaggingItemDetailsTable.defaultStorageLocation:
            element.defaultStorageLocation,
        BaggingItemDetailsTable.attachment: element.attachment,
        BaggingItemDetailsTable.mdRequired: element.mdRequired,
        BaggingItemDetailsTable.sDocRequired: element.sDocRequired,
        BaggingItemDetailsTable.zeroDeclaration: element.zeroDeclaration,
        BaggingItemDetailsTable.iHMMaterialQty: element.iHMMaterialQty,
        BaggingItemDetailsTable.iHMAttachment: element.iHMAttachment,
      });
    }
    await batch.commit();
  }

  @override
  Future<List<Map<String, dynamic>>> getAllBaggingItemDetails() {
    return db.query(BaggingItemDetailsTable.tableName);
  }

  @override
  Future<void> clearItemDetailsDataTable() async {
    await db.delete(BaggingItemDetailsTable.tableName);
  }
}
