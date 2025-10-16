import 'dart:convert';
import 'dart:developer';

import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/cupertino.dart';

import '../../../../config/default_api_payload.dart';
import '../../../../config/dropdown_payload.dart' hide Pagination;
import '../../../../config/network_config.dart';
import '../../../../core/constants/api_constant.dart';
import '../../../../core/constants/app_encrypted_storage_keys.dart';
import '../../../../core/constants/constant.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/service/db_service/table_data_manipulation/common_data_processor.dart';
import '../../../../core/service/db_service/table_data_manipulation/failed_common_api_local_data_source.dart';
import '../../../../core/service/db_service/table_data_manipulation/meta_local_data_source.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../good_receipts/data/models/goods_receipt_purchase_item_detail_model.dart';
import '../../../good_receipts/data/models/goods_receipt_transaction_item_detail_model.dart';
import '../../../item_master/data/models/ports_list_common_response_model.dart';
import '../model/admin_structure_model.dart';
import '../model/default_location_model.dart';
import '../model/failed_common_api_model.dart';
import '../model/fetch_imdg_class_model.dart';
import '../model/item_category_model.dart';
import '../model/item_section_model.dart';
import '../model/item_sub_section_model.dart';
import '../model/meta_local_params.dart';
import '../model/quality_list_model.dart';
import '../model/stock_location_model.dart';
import '../model/storage_location_model.dart';
import '../model/vessel_model.dart';

abstract interface class CommonNetworkDataSource {
  Future<void> insertItemCategory();

  Future<List<ItemCategoryModel>> fetchAllItemCategory();

  //ItemSection
  Future<void> insertItemSection();

  Future<List<ItemSectionModel>> fetchAllItemSection();

  //ItemSubSection
  Future<void> insertItemSubSection();

  Future<List<ItemSubSectionModel>> fetchAllItemSubSection();

  Future<void> insertStorageLocationData({
    int? pageNo,
    int? referenceTypeId,
    int? referenceId,
  });

  Future<PortListResponseModel> fetchPort({
    Map<String, dynamic>? queryParameters,
  });

  Future<List<CommonStockLocationModel>> fetchStockLocation();

  Future<List<DefaultLocationModel>> fetchDefaultLocation();

  Future<GoodsReceiptTransactionItemDetailResponseModel?> getAllItems();

  Future<VesselModelResponse?> getAllVesselSpecification();

  Future<GoodsReceiptPurchaseItemDetailResponseModel?> getAllPoItems();

  Future<QualityListResponseModel?> getQualityList();

  Future<AdminStructureModelResponse?> getAllAdminStructureData();
}

class CommonNetworkDataSourceImpl extends CommonNetworkDataSource {
  CommonNetworkDataSourceImpl({
    required this.commonDatasource,
    required this.encryptedSharedPreferences,
    required this.appNetworkClient,
    required this.metaLocalDataSource,
    required this.failedCommonApiLocalDataSource,
  });

  final CommonDatasource commonDatasource;
  final EncryptedSharedPreferences encryptedSharedPreferences;
  final AppNetworkClient appNetworkClient;
  final MetaLocalDataSource metaLocalDataSource;
  final FailedCommonApiLocalDataSource failedCommonApiLocalDataSource;

  ///Fetch IMDG

  //ItemCategory

  @override
  Future<void> insertItemCategory() async {
    var lastModifiedTimeStamp = encryptedSharedPreferences.getString(
      AppEncryptedStorageKeys.lastModifiedTimeStampInsItemCategory,
    );

    /*if (lastModifiedTimeStamp != null) {
      filters.add(
        FilterCondition(
          field: "ModifiedOn",
          operator: "gt",
          value: lastModifiedTimeStamp,
        ),
      );
    }*/

    DropdownApiPayload apiPayload = DropdownApiPayload(
      tags: ["dropdownSearch"],
      pagination: PaginationParams(pageNo: 0, pageSize: 100),
    );

    debugPrint(" pyLd ${apiPayload.toJson()}");

    final response = await appNetworkClient.post(
      ApiConstant.fetchItemCategory,
      data: apiPayload.toJson(),
    );

    final data = ItemCategoryResponseModel.fromJson(response);

    if (data.reportData.isNotEmpty) {
      await commonDatasource.clearItemCategoryData();
      await commonDatasource.insertItemCategory(
        itemCategoryModel: data.reportData ?? [],
      );
    }
    return;
  }

  @override
  Future<List<ItemCategoryModel>> fetchAllItemCategory() async {
    final List<Map<String, dynamic>> data =
        await commonDatasource.fetchAllItemCategory();

    final List<ItemCategoryModel> fetchCatergoryList =
        data.map(ItemCategoryModel.fromJson).toList();
    return fetchCatergoryList;
  }

  //Item Section

  @override
  Future<void> insertItemSection() async {
    var lastModifiedTimeStamp = encryptedSharedPreferences.getString(
      AppEncryptedStorageKeys.lastModifiedTimeStampInsItemSection,
    );

    /*if (lastModifiedTimeStamp != null) {
      filters.add(
        FilterCondition(
          field: "ModifiedOn",
          operator: "gt",
          value: lastModifiedTimeStamp,
        ),
      );
    }*/

    DropdownApiPayload apiPayload = DropdownApiPayload(
      tags: ["dropdownSearch"],
      pagination: PaginationParams(pageNo: 0, pageSize: 100),
    );

    final response = await appNetworkClient.post(
      ApiConstant.fetchItemSection,
      data: apiPayload.toJson(),
    );

    final data = ItemSectionResponseModel.fromJson(response);

    if (data.reportData.isNotEmpty) {
      await commonDatasource.clearItemSectionData();
      await commonDatasource.insertItemSection(
        itemSectionModel: data.reportData ?? [],
      );
    }
    return;
  }

  @override
  Future<List<ItemSectionModel>> fetchAllItemSection() async {
    final List<Map<String, dynamic>> data =
        await commonDatasource.fetchAllItemSection();

    final List<ItemSectionModel> fetchSectionList =
        data.map(ItemSectionModel.fromJson).toList();
    return fetchSectionList;
  }

  //ItemSubSection

  @override
  Future<void> insertItemSubSection() async {
    var lastModifiedTimeStamp = encryptedSharedPreferences.getString(
      AppEncryptedStorageKeys.lastModifiedTimeStampInsItemSubSection,
    );

    /*if (lastModifiedTimeStamp != null) {
      filters.add(
        FilterCondition(
          field: "ModifiedOn",
          operator: "gt",
          value: lastModifiedTimeStamp,
        ),
      );
    }*/

    DropdownApiPayload apiPayload = DropdownApiPayload(
      tags: ["dropdownSearch"],
      pagination: PaginationParams(pageNo: 0, pageSize: 100),
    );

    final response = await appNetworkClient.post(
      ApiConstant.fetchItemSubSection,
      data: apiPayload.toJson(),
    );

    final data = ItemSubSectionResponseModel.fromJson(response);

    if (data.reportData.isNotEmpty) {
      await commonDatasource.clearItemSubSectionData();
      await commonDatasource.insertItemSubSection(
        itemSubSectionModel: data.reportData ?? [],
      );
    }
    return;
  }

  @override
  Future<List<ItemSubSectionModel>> fetchAllItemSubSection() async {
    final List<Map<String, dynamic>> data =
        await commonDatasource.fetchAllItemSubSection();

    final List<ItemSubSectionModel> fetchSubSectionList =
        data.map(ItemSubSectionModel.fromJson).toList();
    return fetchSubSectionList;
  }

  @override
  Future<void> insertStorageLocationData({
    int? pageNo,
    int? referenceTypeId,
    int? referenceId,
  }) async {
    pageNo ??= 1;
    MetaLocalParams metaLocalParams = MetaLocalParams(
      vesselId: AppConstant.vesselId,
      code: ApiConstant.fetchStorageLocation,
    );
    String? lastModifiedTimeStamp = await metaLocalDataSource.fetchLastCallTime(
      metaLocalParams: metaLocalParams,
    );

    final List<FilterCondition> filters = [];
    filters.add(FilterCondition(field: "ID", operator: "gte", value: 1));
    if (lastModifiedTimeStamp != null) {
      filters.add(
        FilterCondition(
          field: "ModifiedOn",
          operator: "gt",
          value: lastModifiedTimeStamp,
        ),
      );
    }
    filters.addAll([
      FilterCondition(field: "ReferenceID", operator: "eq", value: referenceId),
      // FilterCondition(field: "ReferenceSubID", operator: "eq", value: 1395),
      FilterCondition(
        field: "ReferenceTypeID",
        operator: "eq",
        value: referenceTypeId,
      ),
    ]);

    DefaultApiPayload apiPayload = DefaultApiPayload(
      fields: [
        Field(field: "ID"),
        Field(field: "ParentID"),
        Field(field: "Code"),
        Field(field: "LocName"),
        Field(field: "Description"),
        Field(field: "VesselLocationID"),
        Field(field: "IsActive"),
        Field(field: "ReferenceTypeID"),
        Field(field: "ReferenceID"),
        Field(field: "ReferenceSubID"),
        Field(field: "ParentLocName"),
        // Field(field: "ModifiedOn"),
      ],

      filter: FilterGroup(logic: "and", filters: filters),
      sort: [SortOption(field: "ID", direction: "Asc")],
      paginationParams: PaginationParams(
        pageNo: pageNo,
        pageSize: 5000 /* AppConstant.pageSize*/,
      ),
    );

    log("Storage Location Api url : ${ApiConstant.fetchStorageLocation}");
    log("Storage Location Api Payload : ${apiPayload.toJson()}");

    final response = await appNetworkClient.post(
      ApiConstant.fetchStorageLocation,
      data: apiPayload.toJson(),
    );

    final StorageLocationResponseModel data =
        StorageLocationResponseModel.fromJson(response);

    // if (lastModifiedTimeStamp != null) {
    //   filters.add(
    //     FilterCondition(
    //       field: "ModifiedOn",
    //       operator: "gt",
    //       value: lastModifiedTimeStamp,
    //     ),
    //   );
    // }

    await commonDatasource.insertStorageLocationItems(
      storageLocationModelList: data.reportData ?? [],
    );

    List<FailedCommonApiModel> failedCommonApiModelList =
        await failedCommonApiLocalDataSource.fetchApiListViaEndPoint(
          endPoint: ApiConstant.fetchStorageLocation,
        );
    if (failedCommonApiModelList.isNotEmpty) {
      for (var requestModel in failedCommonApiModelList) {
        String storedRequestInDb = requestModel.apiPayLoad.toString().trim();
        String jsonRequestString = AppUtils.convertStoredApiRequestToJsonString(
          storedRequestInDb,
        );
        DefaultApiPayload apiPayload = DefaultApiPayload.fromJson(
          jsonDecode(jsonRequestString),
        );
        await failedCommonApiLocalDataSource.updateExecutedAt(
          id: requestModel.id,
        );
        await insertStorageLocationData(
          pageNo: apiPayload.paginationParams?.pageNo,
        );
        await Future.delayed(Duration(seconds: 1));
      }
    } else {
      if (pageNo * AppConstant.pageSize < data.recordCount &&
          lastModifiedTimeStamp == null) {
        pageNo++;

        await insertStorageLocationData(pageNo: pageNo);
      } else {
        await metaLocalDataSource.insertApiLastModifiedDate(
          metaLocalParams: MetaLocalParams(
            vesselId: AppConstant.vesselId,
            code: ApiConstant.fetchStorageLocation,
          ),
        );
      }
    }
    return;
  }

  @override
  Future<PortListResponseModel> fetchPort({
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await appNetworkClient.get(
      ApiConstant.fetchPort,
      queryParameters: queryParameters,
    );

    return PortListResponseModel.fromJson(response);
  }

  @override
  Future<List<CommonStockLocationModel>> fetchStockLocation() async {
    int pageNo = 1;

    ///pass actual value

    DefaultApiPayload apiPayload = DefaultApiPayload(
      fields: [
        Field(field: "StorageLocationID"),
        Field(field: "StorageLocation"),
        Field(field: "StorageLocationHierarchy"),
        Field(field: "ReferenceID"),
        Field(field: "ReferenceSubID"),
        Field(field: "ReferenceTypeID"),
        Field(field: "ItemID"),
        Field(field: "ItemLinkID"),
        Field(field: "GRNNO"),
        Field(field: "TotalROB"),
        Field(field: "ReceivedQty"),
        Field(field: "MDocReq"),
        Field(field: "SDocReq"),
        Field(field: "ZeroDocReq"),
        Field(field: "IhmMaterialCount"),
        Field(field: "POAttachment"),
        Field(field: "IHMAttachment"),
        Field(
          field: "InventoryDate",
          aggregate: "max",
          aliasName: "InventoryDate",
        ),
        Field(field: "ExpiryDate", aggregate: "max", aliasName: "ExpiryDate"),
        Field(field: "UnitPrice", aggregate: "max", aliasName: "UnitPrice"),
        Field(field: "NewStock", aggregate: "sum", aliasName: "NewStock"),
        Field(
          field: "ReconditionedStock",
          aggregate: "sum",
          aliasName: "ReconditionedStock",
        ),
      ],
      sort: [SortOption(field: "InventoryDate", direction: "desc")],
      groupBy: [
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
        "IHMAttachment",
      ],
      filter: FilterGroup(
        logic: "and",
        filters: [
          /* FilterCondition(
            field: "ItemID",
            operator: "in",
            value: 2016222759435029,
          ),*/
          /* FilterGroup(
            logic: "or",
            filters: [
              FilterCondition(field: "NewStock", operator: "gt", value: 0),
              FilterCondition(
                field: "ReconditionedStock",
                operator: "gt",
                value: 0,
              ),
            ],
          ),*/
        ],
      ),
      paginationParams: PaginationParams(
        pageNo: pageNo,
        pageSize: AppConstant.pageSize,
      ),
    );

    final response = await appNetworkClient.post(
      ApiConstant.stockLocation,
      data: apiPayload.toJson(),
    );

    final List<dynamic> data = response['reportData'] ?? [];

    return data.map((e) => CommonStockLocationModel.fromJson(e)).toList();
  }

  @override
  Future<List<DefaultLocationModel>> fetchDefaultLocation() async {
    final apiPayload = DefaultApiPayload(
      fields: [
        Field(field: "LocationVesselMappingID"),
        Field(field: "ItemID"),
        Field(field: "ItemVersionID"),
        Field(field: "ItemLinkID"),
        Field(field: "PartNumber"),
        Field(field: "Code"),
        Field(field: "UomQuantity"),
        Field(field: "ROBCount"),
        Field(field: "SectionName"),
        Field(field: "SubSectionName"),
        Field(field: "Description"),
        Field(field: "ItemName"),
        Field(field: "CategoryName"),
        Field(field: "IsActive"),
      ],
      filter: FilterGroup(logic: "and", filters: []),
      paginationParams: PaginationParams(
        pageNo: 1,
        pageSize: AppConstant.pageSize,
      ),
    );

    final response = await appNetworkClient.post(
      ApiConstant.defaultLocation,
      data: apiPayload.toJson(),
    );

    final List<dynamic> data = response['reportData'] ?? [];

    return data.map((e) => DefaultLocationModel.fromJson(e)).toList();
  }

  @override
  Future<GoodsReceiptTransactionItemDetailResponseModel?> getAllItems() async {
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
        Field(field: "DrawingPositionNumber"),
        Field(field: "DrawingNumber"),
        Field(field: "UnitPrice"),
        Field(field: "EquipmentID"),
        Field(field: "EquipmentName"),
        Field(field: "GRNDTID"),
      ],
      filter: FilterGroup(logic: "and", filters: []),
      sort: [SortOption(field: "grnID", direction: "Asc")],
      paginationParams: PaginationParams(
        pageNo: 1,
        pageSize: AppConstant.pageSize,
      ),
    );
    log(
      "split location api url --- ${ApiConstant.fetchAllGRNTransactionItems}",
    );
    final response = await appNetworkClient.post(
      ApiConstant.fetchAllGRNTransactionItems,
      data: apiPayload.toJson(),
    );
    return GoodsReceiptTransactionItemDetailResponseModel.fromJson(response);
  }

  @override
  Future<VesselModelResponse?> getAllVesselSpecification() async {
    final Map<String, dynamic> payload = {
      "code": "",
      "recordStatus": "CU",
      "isActive": true,
      "isPagination": false,
      "pageOffset": 0,
      "pageNext": 0,
      "fleetID": [],
      "primaryManagerID": [],
      "vesselTypeID": [],
      "vesselSubTypeID": [],
      "vesselSizeID": [],
      "managementTypeID": [],
      "vesselGroupID": [],
    };

    final response = await appNetworkClient.post(
      ApiConstant.getAllVesselSpecification,
      data: payload,
    );
    return VesselModelResponse.fromJson(response);
  }

  @override
  Future<GoodsReceiptPurchaseItemDetailResponseModel?> getAllPoItems() async {
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
      filter: FilterGroup(logic: "and", filters: []),
      sort: [SortOption(field: "PODTID", direction: "Desc")],
      paginationParams: PaginationParams(
        pageNo: 1,
        pageSize: AppConstant.pageSize,
      ),
    );

    final response = await appNetworkClient.post(
      ApiConstant.fetchGoodsReceiptPoLineItems,
      data: apiPayload.toJson(),
    );
    return GoodsReceiptPurchaseItemDetailResponseModel.fromJson(response);
  }

  @override
  Future<QualityListResponseModel?> getQualityList() async {
    DefaultApiPayload apiPayload = DefaultApiPayload(
      fields: [
        Field(field: "ID"),
        Field(field: "HDID"),
        Field(field: "HDCode"),
        Field(field: "Code"),
        Field(field: "TypeName"),
        Field(field: "IsActive"),
        Field(field: "SortOrder"),
        Field(field: "Remarks"),
        Field(field: "CreatedByID"),
        Field(field: "CreatedOn"),
        Field(field: "ModifiedByID"),
        Field(field: "ModifiedOn"),
      ],
      filter: FilterGroup(logic: "and", filters: []),
      sort: [],
      paginationParams: PaginationParams(
        pageNo: 1,
        pageSize: AppConstant.pageSize,
      ),
    );

    final response = await appNetworkClient.post(
      ApiConstant.fetchQualityAdmin,
      data: apiPayload.toJson(),
    );
    return QualityListResponseModel.fromJson(response);
  }

  @override
  Future<AdminStructureModelResponse?> getAllAdminStructureData() async {
    final Map<String, dynamic> payload = {
      "IsActive": true,
      "IsPagination": false,
      "PageNext": 0,
      "PageOffset": 0,
      "AdminStructureHDCode": "TT"
    };

    final response = await appNetworkClient.post(
      ApiConstant.adminStructure,
      data: payload,
    );
    return AdminStructureModelResponse.fromJson(response);
  }
}
