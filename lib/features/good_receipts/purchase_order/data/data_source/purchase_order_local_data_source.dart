import '../../../../../core/service/db_service/table_data_manipulation/purchsase_order_table_data_processor.dart';
import '../model/purchase_order_filter_model.dart';
import '../model/purchase_order_model.dart';

abstract interface class PurchaseOrderLocalDataSource {
  Future<List<PurchaseOrderModel>> getAllPurchaseOrderFromDb({
    PurchaseOrderFilterModel? filter,
  });
  Future<void> insertPurchaseOrderList({
    required List<PurchaseOrderModel> purchaseOrderModelList,
  });
}

class PurchaseOrderLocalDataSourceImpl implements PurchaseOrderLocalDataSource {
  PurchaseOrderLocalDataSourceImpl({
    required this.purchaseOrderTableDataProcessor,
  });

  final PurchaseOrderTableDataProcessor purchaseOrderTableDataProcessor;
  @override
  Future<List<PurchaseOrderModel>> getAllPurchaseOrderFromDb({
    PurchaseOrderFilterModel? filter,
  }) async {
    final List<Map<String, dynamic>> purchaseOrderList =
        await purchaseOrderTableDataProcessor.getAllPurchaseOrderFromDb(
          filter: filter,
        );
    return purchaseOrderList.map(PurchaseOrderModel.fromJson).toList();
  }

  @override
  Future<void> insertPurchaseOrderList({
    required List<PurchaseOrderModel> purchaseOrderModelList,
  }) async {
    purchaseOrderTableDataProcessor.insertPurchaseOrder(
      purchaseOrderModelList: purchaseOrderModelList,
    );
  }
}
