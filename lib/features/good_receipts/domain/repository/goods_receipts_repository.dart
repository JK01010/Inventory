import 'package:fpdart/fpdart.dart';

import '../../../common_feature/domain/entities/fetch_imdg_class_entity.dart';
import '../../../common_feature/domain/entities/storage_location_entity.dart';
import '../entities/goods_receipt_attachment_entity.dart';
import '../entities/goods_receipt_ihm_attachment_entity.dart';
import '../entities/goods_receipt_label_attachment_entity.dart';
import '../entities/goods_receipt_purchase_item_detail_entity.dart';
import '../entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../entities/goods_receipt_transaction_entity.dart';
import '../entities/grn_create_label_entity.dart';
import '../entities/grn_location_mapping_entity.dart';
import '../entities/grn_location_serial_mapping_entity.dart';
import '../entities/item_category_config_entity.dart';
import '../entities/item_rob_details_entity.dart';
import '../entities/packet_details_entity.dart';
import '../entities/purchase_order_hd_entity.dart';
import '../entities/split_location_entity.dart';
import '../entities/transaction_filter_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../use_cases/get_pending_po_split_location_data_use_case.dart';
import '../use_cases/get_po_item_details_usecase.dart';
import '../use_cases/goods_receipts_po_usecase/save_goods_receipts_usecase.dart';

abstract interface class GoodsReceiptsRepository {
  ///Goods Receipts Page

  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptsTransactionEntity>>>
  searchFromTransactionList({required String query});

  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptsTransactionEntity>>>
  searchTransactionGrn({required String grnNo});

  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptsTransactionEntity>>>
  getAllTransactions({TransactionFilterEntity? filter});

  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptsTransactionEntity>>>
  filterTransactionList({
    required TransactionFilterEntity transactionFilterEntity,
  });

  ///

  Future<Either<GoodsReceiptsFailures, PurchaseOrderHDEntity>>
  getGoodsReceiptDetailsById(int poId);

  Future<Either<GoodsReceiptsFailures, Unit>> insertGoodsReceiptsAttachments();

  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptAttachmentEntity>>>
  getGoodsReceiptAttachmentList(int poId);

  Future<Either<GoodsReceiptsFailures, Unit>> insertGoodsReceiptsDetailLabel();

  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  getGoodsReceiptDetailLabelItems(String poId);

  Future<Either<GoodsReceiptsFailures, Unit>> syncTransactionList({
    required List<GoodsReceiptsTransactionEntity> transactionEntityItem,
  });

  Future<Either<GoodsReceiptsFailures, PurchaseOrderHDEntity>>
  updateGoodsReceiptsPoDetail(PurchaseOrderHDEntity purchaseOrderHDEntity);

  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  updateGoodsReceiptsDetailLabelList(
    List<GoodsReceiptPurchaseOrderLineItemEntity>
    goodsReceiptPurchaseItemDetailEntity,
  );

  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptAttachmentEntity>>>
  insertCapturedOrSelectedMediaAttachments(
    List<GoodsReceiptAttachmentEntity> goodsReceiptAttachmentEntityList,
  );

  Future<
    Either<GoodsReceiptsFailures, GoodsReceiptPurchaseOrderLineItemEntity?>
  >
  goodsReceiptGetLabelDetailById(int dtId, int hdId, int itemId);

  Future<Either<GoodsReceiptsFailures, GoodsReceiptPurchaseOrderLineItemEntity>>
  goodsReceiptCreateLabelSaveDetail(
    GoodsReceiptPurchaseOrderLineItemEntity
    goodsReceiptPurchaseItemDetailEntity,
  );

  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptLabelAttachmentEntity>>>
  getGoodsReceiptLabelAttachmentList(
    GoodsReceiptPurchaseOrderLineItemEntity
    goodsReceiptPurchaseItemDetailEntity,
  );

  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptLabelAttachmentEntity>>>
  insertCapturedOrSelectedMediaLabelAttachments(
    List<GoodsReceiptLabelAttachmentEntity>
    goodsReceiptLabelAttachmentEntityList,
  );

  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptIhmAttachmentEntity>>>
  getGoodsReceiptIhmAttachmentList(String itemId);

  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseItemDetailEntity>>
  >
  getPOItemListForSelectedGRNTransaction(int poId);

  Future<Either<GoodsReceiptsFailures, Unit>> updateStockLocationByItemId(
    int itemId,
  );

  Future<Either<GoodsReceiptsFailures, List<SplitLocationEntity>>>
  getSplitLocationByPurchaseItemDetail(
    GoodsReceiptPurchaseOrderLineItemEntity
    goodsReceiptPurchaseOrderLineItemEntity,
  );

  Future<Either<GoodsReceiptsFailures, Unit>> insertOrUpdateSplitLocationEntity(
    List<SplitLocationEntity> splitLocationEntityList,
  );

  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  deleteGoodsReceiptsLabelItemById(
    GoodsReceiptPurchaseOrderLineItemEntity
    goodsReceiptPurchaseOrderLineItemEntity,
  );

  Future<Either<GoodsReceiptsFailures, List<SplitLocationEntity>>>
  deleteSplitStorageLocationItemById(
    SplitLocationEntity splitLocationEntity,
    GoodsReceiptPurchaseOrderLineItemEntity
    goodsReceiptPurchaseOrderLineItemEntity,
  );

  //packet
  Future<Either<GoodsReceiptsFailures, List<PacketDetailsEntity>>>
  getPacketDetailsByPoId({required String grnId});

  Future<Either<GoodsReceiptsFailures, List<StorageLocationEntity>>>
  getAllStorageLocations();

  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseItemDetailEntity>>
  >
  getAllGrnTransactionItems();

  Future<Either<GoodsReceiptsFailures, List<PacketDetailsEntity>>>
  goodsReceiptSavePacketDetailList({
    required List<PacketDetailsEntity> packetDetailEntityList,
  });

  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  getAllGRLabelItemsToCreateNewLabel({required int poId});

  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  createNewLabelListToUpdateGRLabelLisWithPoId({
    required List<GoodsReceiptPurchaseOrderLineItemEntity> createNewLabelList,
    required int poId,
  });

  Future<Either<GoodsReceiptsFailures, List<GRNLocationMappingEntity>>>
  fetchGRNLocationMappingList();

  Future<Either<GoodsReceiptsFailures, List<GRNLocationSerialMappingEntity>>>
  fetchGRNLocationSerialMappingList();

  Future<Either<GoodsReceiptsFailures, List<ItemCategoryConfigEntity>>>
  getItemCategoryConfig();

  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  goodsReceiptGetAllPoLineItemsData();

  Future<Either<GoodsReceiptsFailures, List<GRNCreateLabelEntity>>>
  grnCreateLabel(int grnId, List<int> itemIds);

  Future<Either<GoodsReceiptsFailures, List<ItemRobDetailsEntity>>>
  getItemRobDetails({required int itemID});

  Future<Either<GoodsReceiptsFailures, bool>> saveGoodReceiptsApi(
    SaveGoodsReceiptsParams saveGoodsReceiptsParams,
  );

  Future<Either<GoodsReceiptsFailures, bool>> saveBaggingAndTagging(
    BaggingAndTaggingParams saveGoodsReceiptsParams,
  );

  Future<
    Either<GoodsReceiptsFailures, GoodsReceiptPurchaseOrderLineItemEntity?>
  >
  getPoItemDetails({required GetPoItemDetailsParams getPoItemDetailsParams});

  Future<Either<GoodsReceiptsFailures, List<SplitLocationEntity>>>
  getPendingPoSplitLocationData({
    required GetPendingPoSplitLocationDataParams
    getPendingPoSplitLocationDataParams,
  });
}
