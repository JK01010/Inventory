import 'package:fpdart/fpdart.dart';
import '../../../../config/network_config.dart';
import '../../../../core/service/db_service/table_data_manipulation/admin_structure_data_processor.dart';
import '../../../../core/service/db_service/table_data_manipulation/common_data_processor.dart';
import '../../../../core/service/db_service/table_data_manipulation/default_location_data_processor.dart';
import '../../../../core/service/db_service/table_data_manipulation/stock_location_data_processor.dart';
import '../../../../core/service/db_service/table_data_manipulation/vessel_specification_data_processor.dart';
import '../../../bagging_tagging_confirmtaion/domain/usecase/get_all_bagging_item_details_usecase.dart';
import '../../../consumption/data/models/equipment_fetch_api_response_model.dart';
import '../../../consumption/data/models/equipment_list_model.dart';
import '../../../good_receipts/data/models/goods_receipt_purchase_item_detail_model.dart';
import '../../../good_receipts/data/models/goods_receipt_transaction_item_detail_model.dart';
import '../../../good_receipts/data/models/pending_po_split_location_model.dart';
import '../../../good_receipts/data/models/stock_location_model.dart';
import '../../../good_receipts/transaction_item_detail/data/models/split_location_model.dart';
import '../../../item_master/data/models/ports_list_common_response_model.dart';
import '../model/admin_structure_model.dart';
import '../model/default_location_model.dart';
import '../model/item_master_common_response_model.dart';
import '../model/quality_list_model.dart';
import '../model/stock_location_model.dart';
import '../model/storage_location_model.dart';
import '../model/vessel_model.dart';

abstract interface class CommonLocalDataSource {
  //fetch itemMaster details using storageLocationId
  Future<List<ItemMasterModel>> fetchItemDetailsBasedOnStorageLocationId({
    required int id,
  });

  Future<List<ItemMasterModel>> fetchItemDetailsBasedOnItemId({
    required int id,
  });

  Future<List<ConsumptionEquipmentListModel>> getAllEquipmentList();

  Future<List<ConsumptionEquipmentListApiModel>> getEquipmentChildrenList();

  Future<Unit> insertStorageLocationData();

  Future<List<StorageLocationModel>> getStorageLocationByParentId(int parentId);

  //quality
  Future<Unit> insertQualityListItems({
    required List<QualityListData> qualityListData,
  });

  Future<List<QualityListData>> fetchQualityList();

  Future<Unit> insertCommonPortList({required List<PortModel> portModelList});

  Future<List<PortModel>> getAllPortsFromDb({required String query});

  Future<Unit> insertStockLocationData({
    required List<CommonStockLocationModel> commonStockLocationModelList,
  });

  Future<Unit> insertDefaultLocationData({
    required List<DefaultLocationModel> defaultLocationModelList,
  });


  Future<void> insertVesselSpecification({
    required List<VesselModel> vesselModel,
  });

  Future<List<VesselModel>> getAllVesselSpecification();
  Future<void> clearPoItemsData();

  Future<void> insertPoItemsData({
    required List<GoodsReceiptPurchaseItemDetailModel> itemsDetailData,
  });

  Future<void> insertPendingPoSplitLocationDataList({
    required List<PendingPoSplitLocationModel> pendingPoSplitLocationModelList,
  });

  Future<void> insertAdminStructure({required List<AdminStructureModel> list});
  Future<List<AdminStructureModel>> getAllAdminStructureDetailsDb();
}

class CommonLocalDataSourceImpl extends CommonLocalDataSource {
  CommonLocalDataSourceImpl({
    required this.commonDatasource,
    required this.networkClient,
    required this.stockLocationDataProcessor,
    required this.defaultLocationDataProcessor,
    required this.vesselSpecificationDataProcessor,
    required this.adminStructureDataProcessor,
  });

  final CommonDatasource commonDatasource;
  final AppNetworkClient networkClient;
  final StockLocationDataProcessor stockLocationDataProcessor;
  final DefaultLocationDataProcessor defaultLocationDataProcessor;
  final VesselSpecificationDataProcessor vesselSpecificationDataProcessor;
  final AdminStructureDataProcessor adminStructureDataProcessor;

  // CommonLocalDataSourceImpl({required this.commonDatasource,
  //   required this.networkClient,
  // }) : _networkClient = networkClient;

  @override
  Future<List<ItemMasterModel>> fetchItemDetailsBasedOnStorageLocationId({
    required int id,
  }) async {
    final List<Map<String, dynamic>> data = await commonDatasource
        .fetchItemsBasedOnStorageLocationId(id: id);
    final List<ItemMasterModel> mappedDataList =
        data.map(ItemMasterModel.fromMap).toList();
    return mappedDataList;
  }

  @override
  Future<List<ItemMasterModel>> fetchItemDetailsBasedOnItemId({
    required int id,
  }) async {
    final List<Map<String, dynamic>> data = await commonDatasource
        .fetchItemsBasedOnItemId(id: id);
    final List<ItemMasterModel> mappedDataList =
        data.map(ItemMasterModel.fromMap).toList();
    return mappedDataList;
  }

  @override
  Future<List<ConsumptionEquipmentListModel>> getAllEquipmentList() async {
    final List<Map<String, dynamic>> data =
        await commonDatasource.getAllEquipmentList();

    final List<ConsumptionEquipmentListModel> equipmentList =
        data.map(ConsumptionEquipmentListModel.fromMap).toList();
    return equipmentList;
  }

  @override
  Future<List<ConsumptionEquipmentListApiModel>>
  getEquipmentChildrenList() async {
    final List<Map<String, dynamic>> data =
        await commonDatasource.getEquipmentChildrenList();

    final List<ConsumptionEquipmentListApiModel> getEquipmentChildrenList =
        data.map(ConsumptionEquipmentListApiModel.fromMap).toList();
    return getEquipmentChildrenList;
  }

  @override
  Future<Unit> insertStorageLocationData() async {
    /*  final String jsonString = await rootBundle.loadString(
      'assets/data/storage_location.json',
    );

    final StorageLocationResponseModel data =
        StorageLocationResponseModel.fromJson(json.decode(jsonString));
    await commonDatasource.clearStorageLocationTable();
    await commonDatasource.insertStorageLocationItems(
      storageLocationModelList: data.reportData!,
    );*/
    return unit;
  }

  @override
  Future<List<StorageLocationModel>> getStorageLocationByParentId(
    int parentId,
  ) async {
    final List<Map<String, dynamic>> data = await commonDatasource
        .getStorageLocationsByParentId(parentId);
    List<StorageLocationModel> storageLocationModelList =
        data.map(StorageLocationModel.fromMap).toList();

    return storageLocationModelList;
  }

  @override
  Future<Unit> insertQualityListItems({
    required List<QualityListData> qualityListData,
  }) async {
    await commonDatasource.insertQualityListItems(
      qualityModelList: qualityListData,
    );
    return unit;
  }

  @override
  Future<List<QualityListData>> fetchQualityList() async {
    final List<Map<String, dynamic>> data =
        await commonDatasource.fetchQualityList();

    final List<QualityListData> qualityList =
        data.map(QualityListData.fromJson).toList();
    return qualityList;
  }

  @override
  Future<Unit> insertCommonPortList({
    required List<PortModel> portModelList,
  }) async {
    await commonDatasource.insertCommonPortList(portList: portModelList);
    return unit;
  }

  @override
  Future<List<PortModel>> getAllPortsFromDb({required String query}) async {
    final List<Map<String, Object?>> portResponse = await commonDatasource
        .getAllPorts(query: query);

    final List<PortModel> portModel =
        portResponse.map((e) {
          final map = Map<String, Object?>.from(e);

          map["isUnLoccodeRqd"] = map["isUnLoccodeRqd"] == 1;
          map["isActive"] = map["isActive"] == 1;
          map["isDeleted"] = map["isDeleted"] == 1;

          return PortModel.fromJson(map);
        }).toList();

    return portModel;
  }

  @override
  Future<Unit> insertStockLocationData({
    required List<CommonStockLocationModel> commonStockLocationModelList,
  }) async {
    /// Clear table before inserting new data
    await stockLocationDataProcessor.clearStockLocationTable();

    /// Transform 'CommonStockLocationModel' response to 'StockLocationModel' list for table insertion
    final transformedList =
        transformApiResponseToStockLocationModels(commonStockLocationModelList)
            .where((e) => (e.quantity ?? 0) > 0) // optional filter
            .toList();

    /// Insert filtered data
    await stockLocationDataProcessor.insertStockLocationItems(
      stockLocationModelList: transformedList,
    );

    return unit;
  }

  List<StockLocationModel> transformApiResponseToStockLocationModels(
    List<CommonStockLocationModel> completeStockData,
  ) {
    return completeStockData.map((e) {
      return StockLocationModel(
        id: null,
        // DB will auto-increment
        itemId: e.itemID,
        storageLocationId: e.storageLocationID,
        quantity: (e.totalROB as num?)?.toInt(),
        tags: '', // keeping empty for now
      );
    }).toList();
  }

  @override
  Future<Unit> insertDefaultLocationData({
    required List<DefaultLocationModel> defaultLocationModelList,
  }) async {
    /// Clear table before inserting new data
    await defaultLocationDataProcessor.clearDefaultLocationTable();

    /// insert default location data to DB
    await defaultLocationDataProcessor.insertDefaultLocationItems(
      defaultLocationModelList: defaultLocationModelList,
    );

    return unit;
  }




  @override
  Future<List<VesselModel>> getAllVesselSpecification() async {
    final List<Map<String, dynamic>> vesselData =
        await vesselSpecificationDataProcessor.getAllVesselData();

    return vesselData.map((e) {
      final data = Map<String, dynamic>.from(e);
      data["isVesselFromNewOwner"] =
          data["isVesselFromNewOwner"] == 1 ? true : false;
      data["isPartiallyCrewManaged"] =
          data["isPartiallyCrewManaged"] == 1 ? true : false;
      data["isRovingTeam"] = data["isRovingTeam"] == 1 ? true : false;
      data["rejoinedVessel"] = data["rejoinedVessel"] == 1 ? true : false;
      data["isSharedVessel"] = data["isSharedVessel"] == 1 ? true : false;
      data["isDualClass"] = data["isDualClass"] == 1 ? true : false;
      data["isHistoryExists"] = data["isHistoryExists"] == 1 ? true : false;
      data["exVessel"] = data["exVessel"] == 1 ? true : false;
      data["realVessel"] = data["realVessel"] == 1 ? true : false;
      data["isAccountClosed"] = data["isAccountClosed"] == 1 ? true : false;
      data["isActive"] = data["isActive"] == 1 ? true : false;
      data["isDeleted"] = data["isDeleted"] == 1 ? true : false;

      return VesselModel.fromJson(data);
    }).toList();
  }

  @override
  Future<void> insertVesselSpecification({
    required List<VesselModel> vesselModel,
  }) async {
    await vesselSpecificationDataProcessor.insertVesselData(
      vesselModel: vesselModel,
    );
  }

  @override
  Future<void> clearPoItemsData() async {
    await commonDatasource.clearPoItems();
  }

  @override
  Future<void> insertPendingPoSplitLocationDataList({
    required List<PendingPoSplitLocationModel> pendingPoSplitLocationModelList,
  }) async {
    await commonDatasource.insertPendingPoSplitLocationData(
      pendingPoSplitLocationModelList: pendingPoSplitLocationModelList,
    );
  }

  @override
  Future<void> insertPoItemsData({
    required List<GoodsReceiptPurchaseItemDetailModel> itemsDetailData,
  }) async {
    await commonDatasource.insertPoItemsData(itemsData: itemsDetailData);
  }

  @override
  Future<void> insertAdminStructure({
    required List<AdminStructureModel> list,
  }) async {
    await adminStructureDataProcessor.insertAdminStructure(list: list);
  }

  @override
  Future<List<AdminStructureModel>> getAllAdminStructureDetailsDb() async {
    final List<Map<String, dynamic>> adminStructureData =
        await adminStructureDataProcessor.getAllAdminStructureDetails();

    return adminStructureData.map((e) {
      final data = Map<String, dynamic>.from(e);
      data["isActive"] = data["isActive"] == 1 ? true : false;
      data["isDeleted"] = data["isDeleted"] == 1 ? true : false;
      return AdminStructureModel.fromJson(data);
    }).toList();
  }
}
