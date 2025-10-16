import 'dart:convert';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../config/default_api_payload.dart';
import '../../../../config/network_config.dart';
import '../../../../core/constants/api_constant.dart';
import '../../../../core/constants/app_encrypted_storage_keys.dart';
import '../../../../core/constants/constant.dart';
import '../../../../core/service/db_service/table_data_manipulation/goods_receipt_detail_label_data_processor.dart';
import '../../../../core/service/db_service/table_data_manipulation/item_category_config_data_processor.dart';
import '../../../../core/service/db_service/table_data_manipulation/purchsase_order_table_data_processor.dart';
import '../../../../core/service/db_service/table_data_manipulation/transactions_table_data_processor.dart';
import '../../../../core/service/db_service/tables/goods_receipt_detail_label_table.dart';
import '../../../common_feature/data/model/storage_location_model.dart';
import '../models/goods_receipt_detail_attachment_response_model.dart';
import '../models/goods_receipt_ihm_attachment_model.dart';
import '../models/goods_receipt_label_attachment_model.dart';
import '../models/goods_receipt_purchase_item_detail_model.dart';
import '../models/goods_receipt_transaction_item_detail_model.dart';
import '../../transaction/data/model/transaction_model.dart';
import '../models/grn_location_mapping_model.dart';

import '../models/grn_location_serial_mapping_model.dart';

import '../models/grn_create_label_model.dart';

import '../models/grn_packet_details_fetch_api_response_model.dart';
import '../models/item_category_config_model.dart';
import '../models/item_rob_details_model.dart';
import '../models/purcase_order_hd_model.dart';
import '../models/transaction_filter_model.dart';

abstract interface class GoodsReceiptsRemoteDataSource {
  Future<Unit> insertData();

  Future<bool> changeLockStatus({required String poId});

  Future<PurchaseOrderHDModel> goodsReceiptDetailEntity(int poId);

  Future<Unit> insertGoodsReceiptAttachmentData();

  Future<List<GoodsReceiptDetailAttachmentModel>>
  getGoodsReceiptDetailAttachment(int poId);

  Future<List<TransactionModel>> getAllTransaction();

  Future<Unit> insertGoodsReceiptsDetailLabel();

  Future<List<GoodsReceiptPurchaseItemDetailModel>>
  getGoodsReceiptDetailLabelItems(String poId);

  Future<Unit> updateSyncList({required List<String> transactionListId});

  Future<List<TransactionModel>> filterTransactionList({
    required TransactionFilterModel transactionFilterModel,
  });

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

  Future<List<GRNPacketDetailsModel>> insertPacketDetailsData();

  Future<Unit> getPacketDetailsData();

  Future<List<StorageLocationModel>> getStorageLocationByParentId(int parentId);

  Future<Unit> insertSplitLocationData();

  // Future<List<SplitLocationModel>> getSplitLocationByPurchaseItemDetail(
  //   GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailModel,
  // );
  //
  // Future<Unit> insertOrUpdateSplitLocationList(
  //   List<SplitLocationModel> splitLocationModelList,
  // );
  //
  // Future<List<GoodsReceiptPurchaseItemDetailModel>>
  // deleteGoodsReceiptsLabelItemById(
  //   GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailModel,
  // );
  //
  // Future<List<SplitLocationModel>> deleteSplitStorageLocationItemById(
  //   SplitLocationModel splitLocationModel,
  //   GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailModel,
  // );

  Future<Unit> insertQualityListItems();

  Future<List<GoodsReceiptPurchaseItemDetailModel>>
  getAllGRLabelItemsToCreateNewLabel();

  Future<List<GRNLocationMappingModel>> fetchGRNLocationMappingList();

  Future<List<GRNLocationSerialMappingModel>>
  fetchGRNLocationSerialMappingList();

  Future<List<ItemCategoryConfigModelData>> getItemCategoryConfig();

  Future<List<GRNCreateLabelReportData>> saveGrnCreateLabel(
    int grnId,
    List<int> itemIds,
  );

  Future<List<ItemRobDetailsModelData>> fetchItemRobDetails({
    required int itemID,
  });

  Future<Map<String, dynamic>> saveGoodsReceiptApi({
    required Map<String, dynamic> payload,
  });
}

class GoodsReceiptsRemoteDataSourceImpl
    implements GoodsReceiptsRemoteDataSource {
  GoodsReceiptsRemoteDataSourceImpl({
    required this.appNetworkClient,
    required this.encryptedSharedPreferences,
    required this.purchaseOrderTableDataProcessor,
    required this.goodsReceiptDetailLabelDataProcessor,
    required this.transactionsTableDataProcessor,
    required this.itemCategoryConfigDataProcessor,
  });

  final AppNetworkClient appNetworkClient;
  final EncryptedSharedPreferences encryptedSharedPreferences;
  final PurchaseOrderTableDataProcessor purchaseOrderTableDataProcessor;
  final GoodsReceiptDetailLabelDataProcessor
  goodsReceiptDetailLabelDataProcessor;
  final TransactionsTableDataProcessor transactionsTableDataProcessor;
  final ItemCategoryConfigDataProcessor itemCategoryConfigDataProcessor;

  @override
  Future<bool> changeLockStatus({required String poId}) {
    // TODO: implement changeLockStatus
    throw UnimplementedError();
  }

  @override
  Future<List<GoodsReceiptPurchaseItemDetailModel>>
  deleteGoodsReceiptsLabelItemById(
    GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailModel,
  ) {
    // TODO: implement deleteGoodsReceiptsLabelItemById
    throw UnimplementedError();
  }

  // @override
  // Future<List<SplitLocationModel>> deleteSplitStorageLocationItemById(
  //   SplitLocationModel splitLocationModel,
  //   GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailModel,
  // ) {
  //   // TODO: implement deleteSplitStorageLocationItemById
  //   throw UnimplementedError();
  // }

  @override
  Future<List<TransactionModel>> filterTransactionList({
    required TransactionFilterModel transactionFilterModel,
  }) {
    // TODO: implement filterTransactionList
    throw UnimplementedError();
  }

  @override
  Future<List<GoodsReceiptTransactionItemDetailModel>>
  getAllGoodsReceiptTransactionDetail() {
    // TODO: implement getAllGoodsReceiptTransactionDetail
    throw UnimplementedError();
  }

  @override
  Future<List<TransactionModel>> getAllTransaction() async {
    String? lastModifiedTimeStamp = encryptedSharedPreferences.getString(
      AppEncryptedStorageKeys.lastModifiedTimeStampInsList,
    );
    var filters = [FilterCondition(field: "GrnId", operator: "gt", value: "0")];

    if (lastModifiedTimeStamp != null) {
      filters.add(
        FilterCondition(
          field: "ModifiedOn",
          operator: "gt",
          value: lastModifiedTimeStamp,
        ),
      );
    }

    DefaultApiPayload apiPayload = DefaultApiPayload(
      fields: [
        Field(field: "GrnId"),
        Field(field: "ReceiptNo"),
        Field(field: "ReceiptDate"),
        Field(field: "PoNo"),
        Field(field: "PoId"),
        Field(field: "Insights"),
        Field(field: "ReqCategoryID"),
        Field(field: "Category"),
        Field(field: "PriorityID"),
        Field(field: "Priority"),
        Field(field: "VendorID"),
        Field(field: "VendorName"),
        Field(field: "DelivryDate"),
        Field(field: "DeliveryToID"),
        Field(field: "DlvryTO"),
        Field(field: "POtitle"),
        Field(field: "TotalNOofprudcts"),
        Field(field: "PlannedNoOfPdcts"),
        Field(field: "EntityID"),
        Field(field: "Entity"),
        Field(field: "RemarksForVendor"),
        Field(field: "pocost"),
        Field(field: "Weight"),
        Field(field: "Actualvolume"),
        Field(field: "CurrencyName"),
        Field(field: "NoOfPackets"),
        Field(field: "PresentProperties"),
        Field(field: "DeliveryToLocationID"),
        Field(field: "DeliveryToLocation"),
        Field(field: "TotalAmountReportingCurrency"),
        Field(field: "PoRemarks"),
        Field(field: "IsBaggingCompleted"),
        Field(field: "WorkFlowID"),
        Field(field: "WorkFlowStatusID"),
        Field(field: "ModifiedOn"),
        Field(field: "PortID"),
        Field(field: "IsFull"),
        Field(field: "DeliveryReference"),
        Field(field: "IsBaggingTaggingApplicable"),
      ],
      filter: FilterGroup(logic: "and", filters: filters),
      sort: [SortOption(field: "PoId", direction: "Desc")],
      paginationParams: PaginationParams(pageNo: 1, pageSize: 1000),
    );

    final response = await appNetworkClient.post(
      ApiConstant.fetchGoodsReceiptTransactionGRNItems,
      data: apiPayload.toJson(),
    );
    final data = TransactionResponseModel.fromJson(response);

    final List<TransactionModel> goodsReceiptTransactionList =
        data.reportData ?? [];

    return goodsReceiptTransactionList;
  }

  @override
  Future<List<GoodsReceiptDetailAttachmentModel>>
  getGoodsReceiptDetailAttachment(int poId) {
    // TODO: implement getGoodsReceiptDetailAttachment
    throw UnimplementedError();
  }

  @override
  Future<List<GoodsReceiptPurchaseItemDetailModel>>
  getGoodsReceiptDetailLabelItems(String poId) async {
    List<FilterCondition> filters = [];

    if (poId != "0") {
      filters.add(
        FilterCondition(
          field: GoodsReceiptDetailLabelTable.poHdId,
          operator: "eq",
          value: poId,
        ),
      );
    }

    DefaultApiPayload apiPayload = DefaultApiPayload(
      fields: [
        Field(field: "PODTID"),
        Field(field: "SLNO"),
        Field(field: "PartNumber"),
        Field(field: "ProductName"),
        Field(field: "UOMID"),
        Field(field: "PackSize"),
        Field(field: "Quantity"),
        Field(field: "ROB"),
        Field(field: "ProductDescription"),
        Field(field: "UnitPrice"),
        Field(field: "ContractPrice"),
        Field(field: "DiscountPercentage"),
        Field(field: "Discount"),
        Field(field: "VATID"),
        Field(field: "VATPercentage"),
        Field(field: "AccountID"),
        Field(field: "AccountCode"),
        Field(field: "AccountName"),
        Field(field: "SubAccountID"),
        Field(field: "SubAccountCode"),
        Field(field: "SubAccountName"),
        Field(field: "AnalysisCodeID"),
        Field(field: "AnalysisCode"),
        Field(field: "AnalysisName"),
        Field(field: "LeadDays"),
        Field(field: "VendorDeliveryDate"),
        Field(field: "RemarksToVendor"),
        Field(field: "IsMD"),
        Field(field: "IsSDOC"),
        Field(field: "ZeroDeclaration"),
        Field(field: "IHMMaterialQty"),
        Field(field: "EccnNo"),
        Field(field: "HSCode"),
        Field(field: "CountryName"),
        Field(field: "PARTNO"),
        Field(field: "CategoryName"),
        Field(field: "ItemCategoryID"),
        Field(field: "ItemSectionID"),
        Field(field: "SectionName"),
        Field(field: "itemSubSectionID"),
        Field(field: "SubSectionName"),
        Field(field: "Vessel"),
        Field(field: "Entity"),
        Field(field: "EntityID"),
        Field(field: "POHDID"),
        Field(field: "ItemId"),
        Field(field: "ArticleNumber"),
        Field(field: "ItemUom"),
        Field(field: "PackUOM"),
        Field(field: "ServiceDescription"),
        Field(field: "EquipmentName"),
        Field(field: "EquipmentDescription"),
        Field(field: "EquipmentModelNumber"),
        Field(field: "EquimentSerialNo"),
        Field(field: "EquipmentManufacturer"),
        Field(field: "DeliveryCode"),
        Field(field: "DeliveryTypeName"),
        Field(field: "UniqueItemReference"),
        Field(field: "IsDeleted"),
        Field(field: "ItemLinkID"),
        Field(field: "ItemVersionID"),
        Field(field: "ParentID"),
        Field(field: "ParentItemLinkID"),
        Field(field: "ParentItemVersionID"),
        Field(field: "IMDGCode"),
        Field(field: "IMDGName"),
        Field(field: "ExportControl"),
        Field(field: "DrawingNumber"),
      ],
      filter: FilterGroup(logic: "and", filters: filters),
      sort: [SortOption(field: "PODTID", direction: "Desc")],
      paginationParams: PaginationParams(
        pageNo: 1,
        pageSize: AppConstant.pageSize,
      ),
    );

    /// Not needed
    final response = await appNetworkClient.post('', data: apiPayload.toJson());

    final data = GoodsReceiptPurchaseItemDetailResponseModel.fromJson(response);
    final List<GoodsReceiptPurchaseItemDetailModel>
    goodsReceiptPoHeaderLineItemListApiModel = data.reportData!.toList();

    await goodsReceiptDetailLabelDataProcessor.insertGoodsReceiptsLabelItems(
      goodsReceiptPurchaseItemDetailModelList: data.reportData ?? [],
    );
    return goodsReceiptPoHeaderLineItemListApiModel;
  }

  @override
  Future<List<GoodsReceiptIhmAttachmentModel>> getGoodsReceiptIhmAttachments(
    String itemId,
  ) {
    // TODO: implement getGoodsReceiptIhmAttachments
    throw UnimplementedError();
  }

  @override
  Future<List<GoodsReceiptLabelAttachmentModel>>
  getGoodsReceiptLabelAttachments(
    GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailModel,
  ) {
    // TODO: implement getGoodsReceiptLabelAttachments
    throw UnimplementedError();
  }

  @override
  Future<GoodsReceiptTransactionItemDetailModel>
  getGoodsReceiptTransactionDetailById(int transactionId) {
    // TODO: implement getGoodsReceiptTransactionDetailById
    throw UnimplementedError();
  }

  @override
  Future<Unit> getPacketDetailsData() {
    // TODO: implement getPacketDetailsData
    throw UnimplementedError();
  }

  // @override
  // Future<List<SplitLocationModel>> getSplitLocationByPurchaseItemDetail(
  //   GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailModel,
  // ) {
  //   // TODO: implement getSplitLocationByPurchaseItemDetail
  //   throw UnimplementedError();
  // }

  @override
  Future<List<StorageLocationModel>> getStorageLocationByParentId(
    int parentId,
  ) {
    // TODO: implement getStorageLocationByParentId
    throw UnimplementedError();
  }

  @override
  Future<GoodsReceiptPurchaseItemDetailModel> goodsReceiptCreateLabelSaveDetail(
    GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailModel,
  ) {
    // TODO: implement goodsReceiptCreateLabelSaveDetail
    throw UnimplementedError();
  }

  @override
  Future<PurchaseOrderHDModel> goodsReceiptDetailEntity(int poId) {
    // TODO: implement goodsReceiptDetailEntity
    throw UnimplementedError();
  }

  @override
  Future<GoodsReceiptPurchaseItemDetailModel?> goodsReceiptGetLabelDetailById(
    int dtId,
    int hdId,
    int itemId,
  ) {
    Future<List<GoodsReceiptPurchaseItemDetailModel>>
    goodsReceiptPurchaseItemDetailModelList = getGoodsReceiptDetailLabelItems(
      '$hdId',
    );
    return goodsReceiptPurchaseItemDetailModelList.then((
      List<GoodsReceiptPurchaseItemDetailModel> purchaseLabelItemList,
    ) {
      if (purchaseLabelItemList.isNotEmpty) {
        return purchaseLabelItemList.first;
      }
      return null;
    });
  }

  @override
  Future<List<GoodsReceiptDetailAttachmentModel>>
  insertCapturedOrSelectedMediaAttachments(
    List<GoodsReceiptDetailAttachmentModel> goodsReceiptAttachmentModelList,
  ) {
    // TODO: implement insertCapturedOrSelectedMediaAttachments
    throw UnimplementedError();
  }

  @override
  Future<List<GoodsReceiptLabelAttachmentModel>>
  insertCapturedOrSelectedMediaLabelAttachments(
    List<GoodsReceiptLabelAttachmentModel> goodsReceiptLabelAttachmentModelList,
  ) {
    // TODO: implement insertCapturedOrSelectedMediaLabelAttachments
    throw UnimplementedError();
  }

  @override
  Future<Unit> insertData() {
    // TODO: implement insertData
    throw UnimplementedError();
  }

  @override
  Future<Unit> insertGoodsReceiptAttachmentData() {
    // TODO: implement insertGoodsReceiptAttachmentData
    throw UnimplementedError();
  }

  @override
  Future<Unit> insertGoodsReceiptsDetailLabel() {
    // TODO: implement insertGoodsReceiptsDetailLabel
    throw UnimplementedError();
  }

  // @override
  // Future<Unit> insertOrUpdateSplitLocationList(
  //   List<SplitLocationModel> splitLocationModelList,
  // ) {
  //   // TODO: implement insertOrUpdateSplitLocationList
  //   throw UnimplementedError();
  // }

  @override
  Future<List<GRNPacketDetailsModel>> insertPacketDetailsData() async {
    String? lastModifiedTimeStamp = encryptedSharedPreferences.getString(
      AppEncryptedStorageKeys.lastModifiedTimeStampInsGRNPacketDetails,
    );

    var code = "SPS_GRN_PACKETS";
    var entityName = "GRNPacketDetails";
    var moduleCode = "SPS";

    final List<Map<String, dynamic>> entitySchema = [
      {
        "name": "ID",
        "type": "bigint",
        "maxLength": null,
        "isNullable": "YES",
        "displayName": "ID",
        "description": "ID",
      },
      {
        "name": "PacketNo",
        "type": "int",
        "maxLength": null,
        "isNullable": "YES",
        "displayName": "PacketNo",
        "description": "PacketNo",
      },
      {
        "name": "Weight",
        "type": "numeric",
        "maxLength": null,
        "isNullable": "YES",
        "displayName": "Weight",
        "description": "Weight",
      },
      {
        "name": "Height",
        "type": "numeric",
        "maxLength": null,
        "isNullable": "YES",
        "displayName": "Height",
        "description": "Height",
      },
      {
        "name": "Width",
        "type": "numeric",
        "maxLength": null,
        "isNullable": "YES",
        "displayName": "Width",
        "description": "Width",
      },
      {
        "name": "ActualVolume",
        "type": "numeric",
        "maxLength": null,
        "isNullable": "YES",
        "displayName": "ActualVolume",
        "description": "ActualVolume",
      },
      {
        "name": "Length",
        "type": "numeric",
        "maxLength": null,
        "isNullable": "YES",
        "displayName": "Length",
        "description": "Length",
      },
      {
        "name": "GRNHDID",
        "type": "bigint",
        "maxLength": null,
        "isNullable": "YES",
        "displayName": "GRNHDID",
        "description": "GRNHDID",
      },
      {
        "name": "PacketName",
        "type": "varchar",
        "maxLength": 500,
        "isNullable": "NO",
        "displayName": "PacketName",
        "description": "PacketName",
      },
    ];

    // Create the DefaultApiPayload
    final DefaultApiPayload apiPayload = DefaultApiPayload(
      fields: [
        Field(field: "ID"),
        Field(field: "PacketNo"),
        Field(field: "Weight"),
        Field(field: "Height"),
        Field(field: "Width"),
        Field(field: "ActualVolume"),
        Field(field: "Length"),
        Field(field: "GRNHDID"),
        Field(field: "PacketName"),
      ],
      filter: FilterGroup(logic: "or", filters: []),
      sort: [],
      paginationParams: PaginationParams(pageNo: 1, pageSize: 1000),
      groupBy: [],
    );

    // Build the complete payload
    Map<String, dynamic> completePayload = {
      "Code": code,
      "EntityName": entityName,
      "ModuleCode": moduleCode,
      "EntitySchema": entitySchema,
      ...apiPayload.toJson(),
    };

    final response = await appNetworkClient.post(
      ApiConstant.fetchGrnPacketDetails,
      data: completePayload,
    );

    final data = GrnPacketDetailsResponseModel.fromJson(response);

    List<GRNPacketDetailsModel> packetDetailsFromApi = [];
    if (data.reportData != null && data.reportData!.isNotEmpty) {
      packetDetailsFromApi = data.reportData ?? [];
    }
    return packetDetailsFromApi;
  }

  @override
  Future<Unit> insertQualityListItems() {
    // TODO: implement insertQualityListItems
    throw UnimplementedError();
  }

  @override
  Future<Unit> insertSplitLocationData() {
    // TODO: implement insertSplitLocationData
    throw UnimplementedError();
  }

  @override
  Future<Unit> insertStockLocationData() {
    // TODO: implement insertStockLocationData
    throw UnimplementedError();
  }

  @override
  Future<List<PurchaseOrderHDModel>> searchFromPoList({required String query}) {
    // TODO: implement searchFromPoList
    throw UnimplementedError();
  }

  @override
  Future<List<GoodsReceiptPurchaseItemDetailModel>>
  updateGoodsReceiptsDetailLabelList(
    List<GoodsReceiptPurchaseItemDetailModel>
    goodsReceiptPurchaseItemDetailEntity,
  ) {
    // TODO: implement updateGoodsReceiptsDetailLabelList
    throw UnimplementedError();
  }

  @override
  Future<PurchaseOrderHDModel> updateGoodsReceiptsPoDetail(
    PurchaseOrderHDModel purchaseOrderHDModel,
  ) {
    // TODO: implement updateGoodsReceiptsPoDetail
    throw UnimplementedError();
  }

  @override
  Future<Unit> updateStockLocationByItemId(int itemId) {
    // TODO: implement updateStockLocationByItemId
    throw UnimplementedError();
  }

  @override
  Future<Unit> updateSyncList({required List<String> transactionListId}) {
    // TODO: implement updateSyncList
    throw UnimplementedError();
  }

  @override
  Future<List<GoodsReceiptPurchaseItemDetailModel>>
  getAllGRLabelItemsToCreateNewLabel() async {
    List<FilterCondition> filters = [];

    DefaultApiPayload apiPayload = DefaultApiPayload(
      fields: [
        Field(field: "PoID"),
        Field(field: "poNo"),
        Field(field: "grnID"),
        Field(field: "grnNo"),
        Field(field: "itemID"),
        Field(field: "itemVersionID"),
        Field(field: "itemLinkID"),
        Field(field: "parentItemID"),
        Field(field: "parentItemVersionID"),
        Field(field: "parentItemLinkID"),
        Field(field: "receivedQty"),
        Field(field: "convertedStockQty"),
        Field(field: "newStock"),
        Field(field: "damagedOrwrongSupply"),
        Field(field: "reconditionedStock"),
        Field(field: "expiryDate"),
        Field(field: "uomID"),
        Field(field: "qualityID"),
        Field(field: "batchNo"),
        Field(field: "remarks"),
        Field(field: "isMD"),
        Field(field: "isSDOC"),
        Field(field: "zeroDeclaration"),
        Field(field: "ihmMaterialQty"),
        Field(field: "articleNo"),
        Field(field: "productName"),
        Field(field: "productDescription"),
        Field(field: "eccnNo"),
        Field(field: "hsCode"),
        Field(field: "countryName"),
        Field(field: "isAntiPiracy"),
        Field(field: "isPyroTechnics"),
        Field(field: "imdgClassID"),
        Field(field: "className"),
        Field(field: "partNo"),
        Field(field: "categoryName"),
        Field(field: "itemCategoryID"),
        Field(field: "itemSectionID"),
        Field(field: "sectionName"),
        Field(field: "itemSubSectionID"),
        Field(field: "subSectionName"),
        Field(field: "itemUom"),
        Field(field: "isExportControl"),
        Field(field: "isIHM"),
        Field(field: "isCritical"),
        Field(field: "isIMDG"),
        Field(field: "vessel"),
        Field(field: "POQuantity"),
        Field(field: "isBagTagItem"),
      ],
      filter: FilterGroup(logic: "and", filters: filters),
      sort: [SortOption(field: "PoId", direction: "Desc")],
      paginationParams: PaginationParams(
        pageNo: 1,
        pageSize: AppConstant.pageSize,
      ),
    );

    final response = await appNetworkClient.post(
      ApiConstant.fetchAllGRNTransactionItems,
      data: apiPayload.toJson(),
    );

    final data = GoodsReceiptPurchaseItemDetailResponseModel.fromJson(response);
    final List<GoodsReceiptPurchaseItemDetailModel>
    goodsReceiptPurchaseItemDetailModelList = data.reportData!.toList();

    // await goodsReceiptDetailLabelDataProcessor.clearGoodsReceiptLabelTable();
    await goodsReceiptDetailLabelDataProcessor.insertGoodsReceiptsLabelItems(
      goodsReceiptPurchaseItemDetailModelList: data.reportData ?? [],
    );

    return goodsReceiptPurchaseItemDetailModelList;
  }

  @override
  Future<List<GRNLocationMappingModel>> fetchGRNLocationMappingList() async {
    int pageNo = 1;

    final Map<String, dynamic> apiPayload = {
      "Fields": [
        {"field": "ID", "aggregate": null},
        {"field": "GRNHDID", "aggregate": null},
        {"field": "GRNDTID", "aggregate": null},
        {"field": "StorageLocationID", "aggregate": null},
        {"field": "Code", "aggregate": null},
        {"field": "LocationName", "aggregate": null},
        {"field": "Description", "aggregate": null},
        {"field": "ItemID", "aggregate": null},
        {"field": "ParentItemID", "aggregate": null},
        {"field": "TypeID", "aggregate": null},
        {"field": "Quantity", "aggregate": null},
        {"field": "ParentID", "aggregate": null},
        {"field": "IsActive", "aggregate": null},
        {"field": "LocationHierarchy", "aggregate": null},
      ],
      "Sort": [],
      "GroupBy": [],
      "Filter": {
        "logic": "and",
        "filters": [
          {
            "field": "GRNHDID",
            "operator": "in",
            "value": "286902", // <-- can make this dynamic later
          },
        ],
      },
      "PaginationParams": {"pageNo": pageNo, "pageSize": AppConstant.pageSize},
    };

    ///TODO - API call (uncomment when API is working)
    final response = await appNetworkClient.post(
      ApiConstant.grnLocationMapping1,
      data: apiPayload,
    );

    // TODO - remove dummy response afterwards
    // final Map<String, dynamic> dummyJson = {
    //   "moduleCode": "SPS",
    //   "entityName": "GRNLocationMapping",
    //   "reportData": [
    //     {
    //       "ID": 323609,
    //       "GRNHDID": 286902,
    //       "GRNDTID": 723002,
    //       "StorageLocationID": 10149764,
    //       "Code": "BAG_TAG",
    //       "LocationName": "Bagging Tagging Location",
    //       "Description": "Bagging Tagging  Location",
    //       "ItemID": 50135090,
    //       "ParentItemID": 0,
    //       "TypeID": 2,
    //       "Quantity": 2.0000,
    //       "ParentID": null,
    //       "IsActive": true,
    //       "LocationHierarchy": "Bagging Tagging Location"
    //     },
    //     {
    //       "ID": 324414,
    //       "GRNHDID": 286902,
    //       "GRNDTID": 724205,
    //       "StorageLocationID": 10149764,
    //       "Code": "BAG_TAG",
    //       "LocationName": "Bagging Tagging Location",
    //       "Description": "Bagging Tagging  Location",
    //       "ItemID": 2016235777271639,
    //       "ParentItemID": 0,
    //       "TypeID": 2,
    //       "Quantity": 1.0000,
    //       "ParentID": null,
    //       "IsActive": true,
    //       "LocationHierarchy": "Bagging Tagging Location"
    //     },
    //   ],
    //   "recordCount": 2,
    //   "entityValidation": {"status": true, "validationMessages": []}
    // };

    final List<dynamic> data = response['reportData'] ?? [];

    return data.map((e) => GRNLocationMappingModel.fromJson(e)).toList();
  }

  @override
  Future<List<GRNLocationSerialMappingModel>>
  fetchGRNLocationSerialMappingList() async {
    int pageNo = 1;

    //TODO - remove dummy response afterwards
    /// Dummy JSON response
    const Map<String, dynamic> dummyJson = {
      "moduleCode": "SPS",
      "entityName": "GRNLocationSerialMapping",
      "reportData": [
        {
          "ID": 999,
          "SerialNumberID": 115755719,
          "SerialNumber": "2222-25000078",
          "GRNHDID": 286902,
          "GRNDTID": 723002,
        },
        {
          "ID": 1000,
          "SerialNumberID": 115770935,
          "SerialNumber": "2222-25000079",
          "GRNHDID": 286902,
          "GRNDTID": 723002,
        },
        {
          "ID": 1001,
          "SerialNumberID": 115786152,
          "SerialNumber": "2222-25000080",
          "GRNHDID": 286902,
          "GRNDTID": 726614,
        },
      ],
      "recordCount": 3,
      "entityValidation": {"status": true, "validationMessages": []},
    };

    /// Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    final Map<String, dynamic> apiPayload = {
      "Fields": [
        {"field": "ID", "aggregate": null},
        {"field": "SerialNumberID", "aggregate": null},
        {"field": "SerialNumber", "aggregate": null},
        {"field": "GRNHDID", "aggregate": null},
        {"field": "GRNDTID", "aggregate": null},
      ],
      "Sort": [],
      "GroupBy": [],
      "Filter": {
        "logic": "and",
        "filters": [
          {
            "field": "GRNHDID",
            "operator": "eq",
            "value": 286902, // <-- can make this dynamic if needed
          },
        ],
      },
      "PaginationParams": {"pageNo": pageNo, "pageSize": AppConstant.pageSize},
    };
    //TODO - uncomment this afterwards
    // final response = await appNetworkClient.post(
    //   ApiConstant.grnLocationSerialMapping,
    //   data: apiPayload,
    // );

    final List<dynamic> data = dummyJson['reportData'] ?? [];

    return data.map((e) => GRNLocationSerialMappingModel.fromJson(e)).toList();
  }

  @override
  Future<List<ItemCategoryConfigModelData>> getItemCategoryConfig() async {
    List<FilterCondition> filters = [
      // FilterCondition(
      //   field: "PropertyCode",
      //   operator: "eq",
      //   value: "GRN_BT_MND",
      // ),
    ];
    DefaultApiPayload apiPayload = DefaultApiPayload(
      fields: [
        Field(field: "PropertyValue"),
        Field(field: "ItemCategoryID"),
        Field(field: "PropertyID"),
        Field(field: "PropertyCode"),
      ],
      filter: FilterGroup(logic: "and", filters: filters),
      paginationParams: PaginationParams(pageNo: 1, pageSize: 100),
    );
    final response = await appNetworkClient.post(
      ApiConstant.fetchItemConfigEntity,
      data: apiPayload.toJson(),
    );

    final data = ItemCategoryConfigResponseModel.fromJson(response);
    final List<ItemCategoryConfigModelData> itemCategoryConfigModelList =
        data.reportData!.toList();
    await itemCategoryConfigDataProcessor.insertItemCategoryConfigItems(
      itemCategoryConfigModelList: data.reportData ?? [],
    );
    return itemCategoryConfigModelList;
  }

  @override
  Future<List<ItemRobDetailsModelData>> fetchItemRobDetails({required int itemID}) async {

    final  apiPayload = {
      "Fields": [
        {
          "field": "StorageLocationID",
          "aggregate": null
        },
        {
          "field": "StorageLocation",
          "aggregate": null
        },
        {
          "field": "StorageLocationHierarchy",
          "aggregate": null
        },
        {
          "field": "ReferenceID",
          "aggregate": null
        },
        {
          "field": "ReferenceSubID",
          "aggregate": null
        },
        {
          "field": "ReferenceTypeID",
          "aggregate": null
        },
        {
          "field": "ItemID",
          "aggregate": null
        },
        {
          "field": "ItemLinkID",
          "aggregate": null
        },
        {
          "field": "GRNNO",
          "aggregate": null
        },
        {
          "field": "TotalROB",
          "aggregate": null
        },
        {
          "field": "ReceivedQty",
          "aggregate": null
        },
        {
          "field": "MDocReq",
          "aggregate": null
        },
        {
          "field": "SDocReq",
          "aggregate": null
        },
        {
          "field": "ZeroDocReq",
          "aggregate": null
        },
        {
          "field": "IhmMaterialCount",
          "aggregate": null
        },
        {
          "field": "POAttachment",
          "aggregate": null
        },
        {
          "field": "IHMAttachment",
          "aggregate": null
        },
        {
          "field": "InventoryDate",
          "aggregate": "max",
          "AliasName": "InventoryDate"
        },
        {
          "field": "ExpiryDate",
          "aggregate": "max",
          "AliasName": "ExpiryDate"
        },
        {
          "field": "UnitPrice",
          "aggregate": "max",
          "AliasName": "UnitPrice"
        },
        {
          "field": "NewStock",
          "aggregate": "sum",
          "AliasName": "NewStock"
        },
        {
          "field": "ReconditionedStock",
          "aggregate": "sum",
          "AliasName": "ReconditionedStock"
        }
      ],
      "Sort": [
        {
          "field": "InventoryDate",
          "Direction": "desc"
        }
      ],
      "GroupBy": [
        "StorageLocationID",
        "StorageLocation",
        "StorageLocationHierarchy",
        "ReferenceID",
        "ReferenceSubID",
        "ReferenceTypeID",
        "ItemID",
        "ItemLinkID",
        "GRNNO",
        "TotalROB",
        "ReceivedQty",
        "MDocReq",
        "SDocReq",
        "ZeroDocReq",
        "IhmMaterialCount",
        "POAttachment",
        "IHMAttachment"
      ],
      "Filter": {
        "logic": "and",
        "filters": [
          {
            "logic": "or",
            "filters": [
              {
                "field": "NewStock",
                "operator": "gt",
                "value": 0
              },
              {
                "field": "ReconditionedStock",
                "operator": "gt",
                "value": 0
              }
            ]
          }
        ]
      },
      "PaginationParams": {
        "pageNo": 0,
        "pageSize": 100
      }
    };

    final response = await appNetworkClient.post(
      ApiConstant.stockLocation,
      data: apiPayload,
    );

    // final List<dynamic> data = response['reportData'] ?? [];
    //
    // return data.map((e) => ItemRobDetailsModelData.fromJson(e)).toList();

    final data = ItemRobDetailsResponseModel.fromJson(response);
    final List<ItemRobDetailsModelData> itemRobDetailsModelDataList = data.reportData!.toList();
    ///todo implement db
    // await itemCategoryConfigDataProcessor.insertItemCategoryConfigItems(
    //   itemCategoryConfigModelList: data.reportData ?? [],
    // );
    // log("data::::::::${data.reportData}");
    debugPrint("itemRobDetailsModelDataList: ${json.encode(itemRobDetailsModelDataList)}");
    debugPrint(
      "itemRobDetailsModelDataList: ${itemRobDetailsModelDataList.map((e) => e.toJson()).toList()}",
    );

    return itemRobDetailsModelDataList;
  }

  @override
  Future<List<GRNCreateLabelReportData>> saveGrnCreateLabel(
    int grnId,
    List<int> itemIds,
  ) async {
    String itemIdsAsString = itemIds.map((id) => id.toString()).join(',');

    List<FilterCondition> filter = [
      FilterCondition(field: "GRNHDID", operator: "eq", value: grnId),
      FilterCondition(field: "ItemID", operator: "in", value: itemIdsAsString),
    ];

    final apiPayload = DefaultApiPayload(
      fields: [
        Field(field: "ItemID"),
        Field(field: "ArticleCode"),
        Field(field: "ItemName"),
        Field(field: "UomID"),
        Field(field: "UOM"),
        Field(field: "PartNumber"),
        Field(field: "DrawingNumber"),
        Field(field: "DrawingPositionNumber"),
        Field(field: "ReceiptDate"),
        Field(field: "StorageLocationID"),
        Field(field: "StorageLocationName"),
        Field(field: "SerialNumber"),
        Field(field: "GRNHDID"),
      ],
      sort: [SortOption(field: "ArticleCode", direction: "asc")],
      groupBy: [],
      filter: FilterGroup(logic: "and", filters: filter),
      paginationParams: PaginationParams(pageNo: 1, pageSize: 100),
    );

    final response = await appNetworkClient.post(
      ApiConstant.grnCreateLabelEntity,
      data: apiPayload.toJson(),
    );
    final data = GRNCreateLabelModel.fromJson(response);

    return data.reportData!.toList();
  }

  @override
  Future<Map<String, dynamic>> saveGoodsReceiptApi({
    required Map<String, dynamic> payload,
  }) async {
    debugPrint(
      "ApiConstant.saveGoodsReceiptsAp : ${ApiConstant.saveGoodsReceiptsApi}",
    );
    debugPrint("payload  : ${jsonEncode(payload)}");
    final response = await appNetworkClient.post(
      ApiConstant.saveGoodsReceiptsApi,
      data: jsonEncode(payload),
    );

    return response;
  }
}
