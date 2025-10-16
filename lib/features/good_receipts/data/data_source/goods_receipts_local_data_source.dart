import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/service/db_service/table_data_manipulation/purchase_order_attachment_data_processor.dart';
import '../../../../core/service/db_service/table_data_manipulation/goods_receipt_detail_data_processor.dart';
import '../../../../core/service/db_service/table_data_manipulation/goods_receipt_detail_label_data_processor.dart';
import '../../../../core/service/db_service/table_data_manipulation/item_rob_details_data_processor.dart';
import '../../../../core/service/db_service/table_data_manipulation/packet_details_data_processor.dart';
import '../../../../core/service/db_service/table_data_manipulation/pending_po_split_location_table_processor.dart';
import '../../../../core/service/db_service/table_data_manipulation/purchsase_order_table_data_processor.dart';
import '../../../../core/service/db_service/table_data_manipulation/split_location_data_processor.dart';
import '../../../../core/service/db_service/table_data_manipulation/stock_location_data_processor.dart';
import '../../../../core/service/db_service/table_data_manipulation/transactions_table_data_processor.dart';
import '../../../common_feature/data/model/fetch_imdg_class_model.dart';
import '../../../common_feature/data/model/storage_location_model.dart';
import '../../purchase_order/domain/entity/purchase_order_filter_entity.dart';
import '../../domain/use_cases/get_pending_po_split_location_data_use_case.dart';
import '../../domain/use_cases/get_po_item_details_usecase.dart';
import '../../transaction_item_detail/data/models/split_location_model.dart';
import '../models/goods_receipt_detail_attachment_response_model.dart';
import '../models/goods_receipt_ihm_attachment_model.dart';
import '../models/goods_receipt_label_attachment_model.dart';
import '../models/goods_receipt_purchase_item_detail_model.dart';
import '../models/goods_receipt_transaction_item_detail_model.dart';
import '../../transaction/data/model/transaction_model.dart';
import '../models/grn_location_serial_mapping_model.dart';
import '../models/grn_packet_details_fetch_api_response_model.dart';
import '../models/item_rob_details_model.dart';
import '../models/packet_details_model.dart';
import '../models/pending_po_split_location_model.dart';
import '../models/purcase_order_hd_model.dart';
import '../models/transaction_filter_model.dart';

abstract interface class GoodsReceiptsLocalDataSource {
  Future<List<PurchaseOrderHDModel>> getAllGoodsResponseHd({
    PurchaseOrderFilterEntity? filter,
  });

  Future<Unit> insertData();

  Future<PurchaseOrderHDModel> goodsReceiptDetailEntity(int poId);

  Future<Unit> insertGoodsReceiptAttachmentData();

  Future<List<GoodsReceiptDetailAttachmentModel>>
  getGoodsReceiptDetailAttachment(int poId);

  Future<Unit> insertGoodsReceiptsDetailLabel();

  Future<List<GoodsReceiptPurchaseItemDetailModel>>
  getGoodsReceiptDetailLabelItems(String poId);

  Future<PurchaseOrderHDModel> updateGoodsReceiptsPoDetail(
    PurchaseOrderHDModel purchaseOrderHDModel,
  );

  Future<List<GoodsReceiptDetailAttachmentModel>>
  insertCapturedOrSelectedMediaAttachments(
    List<GoodsReceiptDetailAttachmentModel> goodsReceiptAttachmentModelList,
  );

  Future<List<GoodsReceiptPurchaseItemDetailModel>>
  updateGoodsReceiptsDetailLabelList(
    List<GoodsReceiptPurchaseItemDetailModel>
    goodsReceiptPurchaseItemDetailEntity,
  );

  Future<GoodsReceiptPurchaseItemDetailModel?> goodsReceiptGetLabelDetailById(
    int dtId,
    int hdId,
    int itemId,
  );

  Future<GoodsReceiptPurchaseItemDetailModel> goodsReceiptCreateLabelSaveDetail(
    GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailModel,
  );

  /// Goods Receipts Page
  Future<List<PurchaseOrderHDModel>> searchFromPoList({required String query});

  Future<List<PurchaseOrderHDModel>> filterSearchFromPoList({
    required String query,
  });

  Future<List<GoodsReceiptLabelAttachmentModel>>
  getGoodsReceiptLabelAttachments(
    GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailModel,
  );

  Future<List<GoodsReceiptLabelAttachmentModel>>
  insertCapturedOrSelectedMediaLabelAttachments(
    List<GoodsReceiptLabelAttachmentModel> goodsReceiptLabelAttachmentModelList,
  );

  Future<List<GoodsReceiptIhmAttachmentModel>> getGoodsReceiptIhmAttachments(
    String itemId,
  );

  Future<List<GoodsReceiptTransactionItemDetailModel>>
  getAllGoodsReceiptTransactionDetail();

  Future<GoodsReceiptTransactionItemDetailModel>
  getGoodsReceiptTransactionDetailById(int transactionId);

  Future<Unit> insertStockLocationData();

  Future<Unit> updateStockLocationByItemId(int itemId);

  Future<Unit> insertPacketDetailsData({
    required List<GRNPacketDetailsModel> grnPacketDetailsModelList,
  });

  Future<Unit> getPacketDetailsData();

  Future<Unit> insertSplitLocationData(
    List<SplitLocationData> splitLocationData,
  );

  Future<List<SplitLocationData>> getSplitLocationByPurchaseItemDetail(
    GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailModel,
  );

  Future<Unit> insertOrUpdateSplitLocationList(
    List<SplitLocationData> splitLocationModelList,
  );

  Future<List<GoodsReceiptPurchaseItemDetailModel>>
  deleteGoodsReceiptsLabelItemById(
    GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailModel,
  );

  Future<List<SplitLocationData>> deleteSplitStorageLocationItemById(
    SplitLocationData splitLocationModel,
    GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailModel,
  );

  //bagging and Tagging
  Future<List<PacketDetailsModel>> getPacketDetailsByPoId({
    required String grnId,
  });

  Future<List<StorageLocationModel>> getAllStorageLocations();


  Future<List<PacketDetailsModel>> goodsReceiptSavePacketDetailList(
    List<PacketDetailsModel> packetDetailModelList,
  );

  Future<List<GoodsReceiptPurchaseItemDetailModel>>
  getAllGRLabelItemsToCreateNewLabel(int poId);

  Future<Unit> insertGRNLocationSerialMappingData(
    List<GRNLocationSerialMappingModel> grnLocationSerialMappingModel,
  );

  Future<List<GRNLocationSerialMappingModel>> getGRNLocationSerialMappingList();

  Future<List<GoodsReceiptPurchaseItemDetailModel>>
  goodsReceiptGetAllPoLineItemsData();

  Future<void> insertItemRobDetails({
    required List<ItemRobDetailsModelData> itemRobDetailsModelData,
  });

  Future<List<ItemRobDetailsModelData>> getItemRobDetails();

  Future<GoodsReceiptPurchaseItemDetailModel?> getPoItemDetails({
    required GetPoItemDetailsParams getPoItemDetailsParams,
  });

  Future<List<PendingPoSplitLocationModel>> getPendingPoSplitLocationData({
    required GetPendingPoSplitLocationDataParams
    getPendingPoSplitLocationDataParams,
  });
}

class GoodsReceiptsLocalDataSourceImpl implements GoodsReceiptsLocalDataSource {
  GoodsReceiptsLocalDataSourceImpl({
    required this.pendingPoTableDataManipulation,
    required this.goodsReceiptDetailDataProcessor,
    required this.transactionsTableDataProcessor,
    required this.goodsReceiptDetailLabelDataProcessor,
    required this.stockLocationDataProcessor,
    required this.packetDetailsDataProcessor,
    required this.splitLocationDataProcessor,
    required this.itemRobDetailsDataProcessor,
    required this.pendingPoSplitLocationTableProcessor,
  });

  final PurchaseOrderTableDataProcessor pendingPoTableDataManipulation;
  final GoodsReceiptDetailDataProcessor goodsReceiptDetailDataProcessor;

  final TransactionsTableDataProcessor transactionsTableDataProcessor;
  final GoodsReceiptDetailLabelDataProcessor
  goodsReceiptDetailLabelDataProcessor;
  final StockLocationDataProcessor stockLocationDataProcessor;
  final PacketDetailsDataProcessor packetDetailsDataProcessor;
  final SplitLocationDataProcessor splitLocationDataProcessor;
  final ItemRobDetailsDataProcessor itemRobDetailsDataProcessor;
  final PendingPoSplitLocationTableProcessor
  pendingPoSplitLocationTableProcessor;

  @override
  Future<List<PurchaseOrderHDModel>> getAllGoodsResponseHd({
    PurchaseOrderFilterEntity? filter,
  }) async {
    // final List<Map<String, dynamic>> data = await pendingPoTableDataManipulation
    //     .getAllPendingPO(filter: filter);

    // final List<PurchaseOrderHDModel> goodsReceiptHdModelList =
    //     data.map(PurchaseOrderHDModel.fromJson).toList();
    // return goodsReceiptHdModelList;

    return [];
  }

  @override
  Future<Unit> insertData() async {
    // final String jsonString = await rootBundle.loadString(
    //   'assets/data/goods_receipts.json',
    // );
    // final decodeJson = json.decode(jsonString);

    // final PurchaseOrderHDResponseModel data =
    //     PurchaseOrderHDResponseModel.fromJson(decodeJson);
    // await pendingPoTableDataManipulation.clearPendingPoTable();
    // await pendingPoTableDataManipulation.insertGoodsReceiptsPo(
    //   goodsReceiptHDModelList: data.reportData ?? [],
    // );

    return unit;
  }

  @override
  Future<PurchaseOrderHDModel> goodsReceiptDetailEntity(int poId) async {
    final List<Map<String, dynamic>> data =
        await goodsReceiptDetailDataProcessor.getGoodsReceiptPoDetail('$poId');
    if (data.isEmpty) {
      return PurchaseOrderHDModel(
        poCode: '',
        poHdId: 0,
        title: '',
        vendorDeliveryDate: '',
        remarksToVendor: '',
        requisitionCategoryId: 0,
        requisitionCategory: '',
        reqCategoryCode: '',
        deliveryPort: '',
        portCode: '',
        vendorReference: '',

        grnId: 0,
        receiptNo: '',
        receiptDate: '',
        poNo: '',
        poId: -1,
        inSights: '',
        reqCategoryId: -1,
        category: '',
        priorityId: -1,
        priority: '',
        vendorId: -1,
        vendorName: '',
        deliveryDate: '',
        deliveryToId: -1,
        deliveryTo: '',
        poTitle: '',
        totalNoOfProducts: -1,
        plannedNoOfProducts: -1,
        entityId: -1,
        entity: '',
        remarksForVendor: '',
        poCost: 0.0,
        weight: 0.0,
        actualVolume: 0.0,
        currencyName: '',
        noOfPackets: 0,
        presentProperties: '',
        deliveryToLocationId: -1,
        deliveryToLocation: '',
        totalAmountReportingCurrency: 0.0,
        poRemarks: '',
        isBaggingCompleted: false,
        modifiedOn: '',
        portId: -1,
        isFull: false,
        isLocked: false,
        referenceID: -1,
        referenceSubID: -1,
        referenceTypeID: -1,
      );
    }
    final PurchaseOrderHDModel poHDModel = PurchaseOrderHDModel.fromJson(
      data.first,
    );
    return poHDModel;
  }

  @override
  Future<Unit> insertGoodsReceiptAttachmentData() async {
    // try {
    //   final String jsonString = await rootBundle.loadString(
    //     'assets/data/goods_receipt_attachment.json',
    //   );
    //   final GoodsReceiptDetailAttachmentResponseModel data =
    //       GoodsReceiptDetailAttachmentResponseModel.fromMap(
    //         json.decode(jsonString),
    //       );
    //   // await goodsReceiptDetailAttachmentDataProcessor.clearGoodsReceiptAttachmentTable();

    //   await goodsReceiptDetailAttachmentDataProcessor
    //       .clearGoodsReceiptAttachmentTable();
    //   await goodsReceiptDetailAttachmentDataProcessor
    //       .insertGoodsReceiptDetailAttachments(
    //         goodsReceiptDetailAttachmentList:
    //             data.goodsReceiptDetailAttachmentModel,
    //       );
    // } catch (e) {}
    return unit;
  }

  @override
  Future<List<GoodsReceiptDetailAttachmentModel>>
  getGoodsReceiptDetailAttachment(int poId) async {
    return [];
  }

  @override
  Future<Unit> insertGoodsReceiptsDetailLabel() async {
    // try {
    //   final String jsonString = await rootBundle.loadString(
    //     'assets/data/good_receipt_label_detail.json',
    //   );
    //   final GoodsReceiptPurchaseItemDetailResponseModel data =
    //       GoodsReceiptPurchaseItemDetailResponseModel.fromJson(
    //         json.decode(jsonString),
    //       );
    // } catch (e) {}
    return unit;
  }

  @override
  Future<List<GoodsReceiptPurchaseItemDetailModel>>
  getGoodsReceiptDetailLabelItems(String poId) async {
    final List<Map<String, dynamic>> data =
        await goodsReceiptDetailLabelDataProcessor
            .getGoodsReceiptDetailLabelItems(poId);
    List<GoodsReceiptPurchaseItemDetailModel>
    goodsReceiptPurchaseItemDetailModelList = [];
    try {
      goodsReceiptPurchaseItemDetailModelList =
          data.map(GoodsReceiptPurchaseItemDetailModel.fromMap).toList();
    } catch (e) {}
    return goodsReceiptPurchaseItemDetailModelList;
  }

  @override
  Future<PurchaseOrderHDModel> updateGoodsReceiptsPoDetail(
    PurchaseOrderHDModel purchaseOrderHDModel,
  ) async {
    await goodsReceiptDetailDataProcessor.updateGoodsReceiptPoDetail(
      purchaseOrderHDModel,
    );
    final List<Map<String, dynamic>> data =
        await goodsReceiptDetailDataProcessor.getGoodsReceiptPoDetail(
          '${purchaseOrderHDModel.poHdId!}',
        );
    if (data.isNotEmpty) {}
    final PurchaseOrderHDModel poHDModel = PurchaseOrderHDModel.fromJson(
      data.first,
    );
    return poHDModel;
  }

  @override
  Future<List<GoodsReceiptDetailAttachmentModel>>
  insertCapturedOrSelectedMediaAttachments(
    List<GoodsReceiptDetailAttachmentModel> goodsReceiptAttachmentModelList,
  ) async {
    try {
      return [];
    } catch (e) {}
    return [];
  }

  @override
  Future<List<GoodsReceiptPurchaseItemDetailModel>>
  updateGoodsReceiptsDetailLabelList(
    List<GoodsReceiptPurchaseItemDetailModel>
    goodsReceiptPurchaseItemDetailModelList,
  ) async {
    await goodsReceiptDetailLabelDataProcessor.updateGoodsReceiptLabelList(
      goodsReceiptPurchaseItemDetailModelList,
    );
    final List<Map<String, dynamic>> data =
        await goodsReceiptDetailLabelDataProcessor
            .getGoodsReceiptDetailLabelItems(
              '${goodsReceiptPurchaseItemDetailModelList[0].poHdId}',
            );
    final List<GoodsReceiptPurchaseItemDetailModel>
    goodsReceiptPurchaseItemDetailList =
        data.map(GoodsReceiptPurchaseItemDetailModel.fromMap).toList();
    return goodsReceiptPurchaseItemDetailList;
  }

  @override
  Future<GoodsReceiptPurchaseItemDetailModel?> goodsReceiptGetLabelDetailById(
    int dtId,
    int hdId,
    int itemId,
  ) async {
    final List<Map<String, dynamic>> data =
        await goodsReceiptDetailLabelDataProcessor
            .goodsReceiptGetLabelDetailById(dtId, hdId, itemId);
    late GoodsReceiptPurchaseItemDetailModel
    goodsReceiptPurchaseItemDetailModel;
    if (data.isNotEmpty) {
      goodsReceiptPurchaseItemDetailModel =
          GoodsReceiptPurchaseItemDetailModel.fromMap(data.first);
      return goodsReceiptPurchaseItemDetailModel;
    }
    return null;
  }

  @override
  Future<GoodsReceiptPurchaseItemDetailModel> goodsReceiptCreateLabelSaveDetail(
    GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailEntity,
  ) async {
    await goodsReceiptDetailLabelDataProcessor.goodsReceiptCreateLabelSaveLabel(
      goodsReceiptPurchaseItemDetailEntity,
    );
    GoodsReceiptPurchaseItemDetailModel? goodsReceiptPurchaseItemDetailModel;
    final List<Map<String, dynamic>> data =
        await goodsReceiptDetailLabelDataProcessor
            .goodsReceiptGetLabelDetailById(
              goodsReceiptPurchaseItemDetailEntity.grnId!,
              goodsReceiptPurchaseItemDetailEntity.poId!,
              goodsReceiptPurchaseItemDetailEntity.itemId!,
            );
    if (data.isNotEmpty) {
      return goodsReceiptPurchaseItemDetailModel =
          GoodsReceiptPurchaseItemDetailModel.fromMap(data.first);
    } else {}
    return GoodsReceiptPurchaseItemDetailModel();
  }

  @override
  Future<List<GoodsReceiptLabelAttachmentModel>>
  getGoodsReceiptLabelAttachments(
    GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailModel,
  ) async {

    return [];
  }

  @override
  Future<List<GoodsReceiptLabelAttachmentModel>>
  insertCapturedOrSelectedMediaLabelAttachments(
    List<GoodsReceiptLabelAttachmentModel> grLabelAttachmentModelList,
  ) async {
    try {

      return [];
    } catch (e) {}
    return [];
  }

  @override
  Future<List<GoodsReceiptIhmAttachmentModel>> getGoodsReceiptIhmAttachments(
    String itemId,
  ) async {

    return [];
  }

  @override
  Future<List<PurchaseOrderHDModel>> searchFromPoList({
    required String query,
  }) async {
    // final data = await pendingPoTableDataManipulation.searchPurchaseOrder(
    //   query: query,
    // );
    // final List<PurchaseOrderHDModel> purchaseOrderList =
    //     data.map(PurchaseOrderHDModel.fromJson).toList();
    // return purchaseOrderList;

    return [];
  }

  @override
  Future<List<PurchaseOrderHDModel>> filterSearchFromPoList({
    required String query,
  }) async {
    // final data = await pendingPoTableDataManipulation.filterSearchPurchaseOrder(
    //   query: query,
    // );
    // final List<PurchaseOrderHDModel> purchaseOrderList =
    //     data.map(PurchaseOrderHDModel.fromJson).toList();
    // return purchaseOrderList;

    return [];
  }

  @override
  Future<List<GoodsReceiptTransactionItemDetailModel>>
  getAllGoodsReceiptTransactionDetail() async {
    final List<Map<String, dynamic>> data =
        await goodsReceiptDetailLabelDataProcessor
            .getAllGoodsReceiptTransactionDetail();
    List<GoodsReceiptTransactionItemDetailModel>
    goodsReceiptTransactionItemDetailModelList = [];
    try {
      goodsReceiptTransactionItemDetailModelList =
          data.map(GoodsReceiptTransactionItemDetailModel.fromMap).toList();
    } catch (e) {}
    return goodsReceiptTransactionItemDetailModelList;
  }

  @override
  Future<GoodsReceiptTransactionItemDetailModel>
  getGoodsReceiptTransactionDetailById(int transactionId) async {
    final List<Map<String, dynamic>> data =
        await goodsReceiptDetailLabelDataProcessor
            .getGoodsReceiptTransactionDetailById(transactionId);
    GoodsReceiptTransactionItemDetailModel
    goodsReceiptTransactionItemDetailModel =
        GoodsReceiptTransactionItemDetailModel.fromMap(data.first);
    return goodsReceiptTransactionItemDetailModel;
  }

  @override
  Future<Unit> insertStockLocationData() async {
    /*   final String jsonString = await rootBundle.loadString(
      'assets/data/stock_location.json',
    );

    final StockLocationResponseModel data = StockLocationResponseModel.fromJson(
      json.decode(jsonString),
    );
    await stockLocationDataProcessor.clearStockLocationTable();
    await stockLocationDataProcessor.insertStockLocationItems(
      stockLocationModelList: data.stockLocationModelList!,
    );*/
    return unit;
  }

  @override
  Future<Unit> updateStockLocationByItemId(int itemId) async {
    await stockLocationDataProcessor.updateStockLocationsByItemId(itemId);
    final List<Map<String, dynamic>> data =
        await stockLocationDataProcessor.getStockLocationItems();
    if (data.isNotEmpty) {}
    return unit;
  }

  @override
  Future<Unit> insertPacketDetailsData({
    required List<GRNPacketDetailsModel> grnPacketDetailsModelList,
  }) async {
    await packetDetailsDataProcessor.clearPacketDetailsTable();
    await packetDetailsDataProcessor.insertPacketDetailsItems(
      packetDetailModelList: grnPacketDetailsModelList,
    );
    return unit;
  }

  @override
  Future<Unit> getPacketDetailsData() async {
    final List<Map<String, dynamic>> data =
        await packetDetailsDataProcessor.getPacketDetailsItems();
    if (data.isNotEmpty) {}
    return unit;
  }

  @override
  Future<Unit> insertSplitLocationData(
    List<SplitLocationData> splitLocationData,
  ) async {
    await splitLocationDataProcessor.insertSplitLocationItems(
      splitLocationData: splitLocationData,
    );
    return unit;
  }

  @override
  Future<List<SplitLocationData>> getSplitLocationByPurchaseItemDetail(
    GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailModel,
  ) async {
    // final List<Map<String, dynamic>> data = await splitLocationDataProcessor
    //     .getGoodsReceiptSplitLocationByPurchaseItemDetail(
    //       goodsReceiptPurchaseItemDetailModel,
    //     );
    // if (data.isNotEmpty) {}
    // List<SplitLocationData> splitLocationModelList =
    //     data.map(SplitLocationData.fromJson).toList();
    // return splitLocationModelList;
    return [];
  }

  @override
  Future<Unit> insertOrUpdateSplitLocationList(
    List<SplitLocationData> splitLocationModelList,
  ) async {
    await splitLocationDataProcessor.insertOrUpdateSplitLocationItems(
      splitLocationModelList,
    );
    return unit;
  }

  @override
  Future<List<GoodsReceiptPurchaseItemDetailModel>>
  deleteGoodsReceiptsLabelItemById(
    GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailModel,
  ) async {
    await goodsReceiptDetailLabelDataProcessor.deleteGoodsReceiptsLabelItemById(
      goodsReceiptPurchaseItemDetailModel,
    );
    return getGoodsReceiptDetailLabelItems(
      '${goodsReceiptPurchaseItemDetailModel.poId}',
    );
  }

  @override
  Future<List<SplitLocationData>> deleteSplitStorageLocationItemById(
    SplitLocationData splitLocationModel,
    GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailModel,
  ) async {
    await splitLocationDataProcessor.deleteSplitStorageLocationItemById(
      splitLocationModel,
    );
    return getSplitLocationByPurchaseItemDetail(
      goodsReceiptPurchaseItemDetailModel,
    );
  }

  @override
  Future<List<PacketDetailsModel>> getPacketDetailsByPoId({
    required String grnId,
  }) async {
    final List<Map<String, dynamic>> data = await packetDetailsDataProcessor
        .getPacketDetailsByPoId(grnId: grnId);

    final List<PacketDetailsModel> packetDetailsList =
        data.map(PacketDetailsModel.fromMap).toList();
    return packetDetailsList;
  }

  @override
  Future<List<StorageLocationModel>> getAllStorageLocations() async {
    final List<Map<String, dynamic>> data =
        await goodsReceiptDetailDataProcessor.getAllStorageLocations();
    List<StorageLocationModel> storageLocationModelList =
        data.map(StorageLocationModel.fromMap).toList();

    return storageLocationModelList;
  }


  @override
  Future<List<PacketDetailsModel>> goodsReceiptSavePacketDetailList(
    List<PacketDetailsModel> packetDetailModelList,
  ) async {
    /*  await packetDetailsDataProcessor.insertPacketDetailsItems(
      packetDetailModelList: packetDetailModelList,
    );*/
    final List<Map<String, dynamic>> data = await packetDetailsDataProcessor
        .getPacketDetailsByPoId(grnId: packetDetailModelList[0].poId);

    final List<PacketDetailsModel> packetDetailsList =
        data.map(PacketDetailsModel.fromMap).toList();
    return packetDetailsList;
  }

  @override
  Future<List<GoodsReceiptPurchaseItemDetailModel>>
  getAllGRLabelItemsToCreateNewLabel(int poId) async {
    final List<Map<String, dynamic>> data =
        await goodsReceiptDetailLabelDataProcessor
            .getAllGRLabelItemsToCreateNewLabel(poId);
    List<GoodsReceiptPurchaseItemDetailModel>
    goodsReceiptPurchaseItemDetailModelList = [];
    try {
      goodsReceiptPurchaseItemDetailModelList =
          data.map(GoodsReceiptPurchaseItemDetailModel.fromMap).toList();
    } catch (e) {}
    return goodsReceiptPurchaseItemDetailModelList;
  }

  @override
  Future<Unit> insertGRNLocationSerialMappingData(
    List<GRNLocationSerialMappingModel> grnLocationSerialMappingModel,
  ) async {
    await goodsReceiptDetailLabelDataProcessor
        .insertGRNLocationSerialMappingData(grnLocationSerialMappingModel);
    return unit;
  }

  @override
  Future<List<GRNLocationSerialMappingModel>>
  getGRNLocationSerialMappingList() async {
    final List<GRNLocationSerialMappingModel> data =
        await goodsReceiptDetailLabelDataProcessor
            .getGRNLocationSerialMappingList();

    return data;
  }

  @override
  Future<List<GoodsReceiptPurchaseItemDetailModel>>
  goodsReceiptGetAllPoLineItemsData() async {
    final List<Map<String, dynamic>> data =
        await goodsReceiptDetailLabelDataProcessor.getGoodsReceiptPoLineItems();
    List<GoodsReceiptPurchaseItemDetailModel>
    goodsReceiptPurchaseItemDetailModelList = [];
    try {
      goodsReceiptPurchaseItemDetailModelList =
          data.map(GoodsReceiptPurchaseItemDetailModel.fromMap).toList();
    } catch (e) {}
    return goodsReceiptPurchaseItemDetailModelList;
  }

  @override
  Future<void> insertItemRobDetails({
    required List<ItemRobDetailsModelData> itemRobDetailsModelData,
  }) async {
    await itemRobDetailsDataProcessor.insertItemRobDetails(
      itemRobDetailsModelList: itemRobDetailsModelData,
    );
  }

  @override
  Future<List<ItemRobDetailsModelData>> getItemRobDetails() async {
    final data = await itemRobDetailsDataProcessor.getItemRobDetails();
    return data.map(ItemRobDetailsModelData.fromJson).toList();
  }

  @override
  Future<GoodsReceiptPurchaseItemDetailModel?> getPoItemDetails({
    required GetPoItemDetailsParams getPoItemDetailsParams,
  }) async {
    return null;
    // final data = await goods.getItemRobDetails();
    // return data.map(ItemRobDetailsModelData.fromJson).toList();
  }

  @override
  Future<List<PendingPoSplitLocationModel>> getPendingPoSplitLocationData({
    required GetPendingPoSplitLocationDataParams
    getPendingPoSplitLocationDataParams,
  }) async {
    // final data = await pendingPoSplitLocationTableProcessor
    //     .getSplitLocationItems(
    //       getPendingPoSplitLocationDataParams:
    //           getPendingPoSplitLocationDataParams,
    //     );
    // return data.map(PendingPoSplitLocationModel.fromJson).toList();
    return [];
  }
}
