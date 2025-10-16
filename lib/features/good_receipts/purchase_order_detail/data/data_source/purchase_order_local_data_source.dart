import '../../../../../core/service/db_service/table_data_manipulation/purchase_order_attachment_data_processor.dart';
import '../../../../../core/service/db_service/table_data_manipulation/purchase_order_items_table_processor.dart';
import '../../../../../core/service/db_service/table_data_manipulation/purchase_order_packets_table_data_processor.dart';
import '../../../../packets/add_packets_sheet/data/model/packets_data_model.dart';
import '../../../purchase_order/data/model/purchase_order_attachment_model.dart';
import '../models/purchase_order_items_list_model.dart';

abstract interface class PurchaseOrderDetailsLocalDataSource {
  Future<List<PurchaseOrderItemsData>> getPurchaseOrderItems({
    required int poHdId,
  });

  Future<void> insertPurchaseOrderItems({
    required List<PurchaseOrderItemsData> purchaseOrderItems,
  });

  Future<int> clearPurchaseOrderItems();

  Future<void> insertPurchaseOrderAttachments({
    required List<PurchaseOrderAttachmentModel> purchaseOrderAttachmentModel,
  });

  Future<void> insertOrUpdatePurchaseOrderPackets({
    required List<PacketsDataModel> purchaseOrderPackets,
  });
}

class PurchaseOrderDetailsLocalDataSourceImpl
    implements PurchaseOrderDetailsLocalDataSource {
  PurchaseOrderDetailsLocalDataSourceImpl({
    required this.purchaseOrderItemsTableProcessor,
    required this.purchaseOrderAttachmentDataProcessor,
    required this.purchaseOrderPacketsTableDataProcessor,
  });

  final PurchaseOrderItemsTableProcessor purchaseOrderItemsTableProcessor;
  final PurchaseOrderAttachmentDataProcessor
  purchaseOrderAttachmentDataProcessor;

  final PurchaseOrderPacketsTableDataProcessor
  purchaseOrderPacketsTableDataProcessor;

  @override
  Future<List<PurchaseOrderItemsData>> getPurchaseOrderItems({
    required int poHdId,
  }) async {
    final purchaseOrderItemsList = await purchaseOrderItemsTableProcessor
        .getPurchaseOrderItemsData(poHdId: poHdId);
    return purchaseOrderItemsList.map(PurchaseOrderItemsData.fromJson).toList();
  }

  @override
  Future<void> insertPurchaseOrderItems({
    required List<PurchaseOrderItemsData> purchaseOrderItems,
  }) async {
    return purchaseOrderItemsTableProcessor.insertPurchaseOrderItemsList(
      purchaseOrderItemsData: purchaseOrderItems,
    );
  }

  @override
  Future<int> clearPurchaseOrderItems() async {
    return purchaseOrderItemsTableProcessor.clearPurchaseOrderItemsTable();
  }

  @override
  Future<void> insertPurchaseOrderAttachments({
    required List<PurchaseOrderAttachmentModel> purchaseOrderAttachmentModel,
  }) async {
    return purchaseOrderAttachmentDataProcessor.insertPurchaseOrderAttachments(
      purchaseOrderAttachmentModel: purchaseOrderAttachmentModel,
    );
  }

  @override
  Future<void> insertOrUpdatePurchaseOrderPackets({
    required List<PacketsDataModel> purchaseOrderPackets,
  }) async {
    return purchaseOrderPacketsTableDataProcessor
        .insertOrUpdatePurchaseOrderPackets(packets: purchaseOrderPackets);
  }
}
