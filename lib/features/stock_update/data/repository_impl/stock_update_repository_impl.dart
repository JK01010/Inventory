import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/service/db_service/table_data_manipulation/srock_update_datasource.dart';
import '../../../common_feature/data/data_source/common_local_data_source.dart';
import '../../domin/entities/srock_update_entity_model.dart';
import '../../domin/entities/stock_update_rfid_scanning_view_entity_model.dart';
import '../../domin/entities/stock_update_view_entity_model.dart';
import '../../domin/failures/stock_update_failures.dart';
import '../../domin/repository/stock_update_repository.dart';
import '../data_source/stock_update_local_data_source.dart';
import '../data_source/stock_update_remote_data_source.dart';
import '../models/stocck_update_transaction_fetch_api_response_model.dart';
import '../models/stock_update_response_model.dart';
import '../models/stock_update_rfid_listing_view_model.dart';
import '../models/stock_update_transaction_save_request_model.dart';
import '../models/stock_update_transaction_save_response_model.dart';
import '../models/stock_update_view_model.dart';

class StockUpdateRepositoryImpl implements StockUpdateRepository {
  const StockUpdateRepositoryImpl({
    required this.stockUpdateLocalDataSource,
    required this.stockUpdateRemoteDataSource,
    required this.commonLocalDataSource,
    required this.stockUpdateDataProcessor,
  });

  final StockUpdateLocalDataSource stockUpdateLocalDataSource;
  final StockUpdateRemoteDataSource stockUpdateRemoteDataSource;
  final CommonLocalDataSource commonLocalDataSource;
  final StockUpdateDataProcessor stockUpdateDataProcessor;

  @override
  Future<Either<StockUpdateFailures, Unit>> insertStockUpdateList() async {
    await stockUpdateRemoteDataSource.getAllStockUpdateTransactionList();
    return right(unit);
  }

  @override
  Future<Either<StockUpdateFailures, Unit>> singleInsertData({
    required StockUpdateEntity model,
  }) async {
    StockUpdateModel insertData = StockUpdateModel.fromEntity(entity: model);
    stockUpdateLocalDataSource.singleInsertData(model: insertData);
    return right(unit);
  }

  @override
  Future<Either<StockUpdateFailures, Unit>> multipleInsertData({
    required List<StockUpdateEntity> list,
  }) async {
    List<StockUpdateModel> mappedList =
        list.map((e) => StockUpdateModel.fromEntity(entity: e)).toList();
    stockUpdateLocalDataSource.multipleInsertData(list: mappedList);
    return right(unit);
  }

  @override
  Future<Either<StockUpdateFailures, List<StockUpdateViewEntity>>>
  fetchAllViewStockUpdateList({required int offSet}) async {
    List<StockUpdateViewModel> stockUpdateList =
        await stockUpdateLocalDataSource.fetchStockUpdateViewData(offSet: 0);
    final List<StockUpdateViewEntity> list =
        stockUpdateList.map((e) => e.toEntity()).toList();
    return right(list);
  }

  @override
  Future<Either<StockUpdateFailures, List<StockUpdateViewEntity>>>
  fetchSearchViewStockUpdateList({required String searchText}) async {
    List<StockUpdateViewModel> stockUpdateList =
        await stockUpdateLocalDataSource.fetchSearchStockUpdateViewData(
          searchText: searchText,
        );
    final List<StockUpdateViewEntity> list =
        stockUpdateList.map((e) => e.toEntity()).toList();
    return right(list);
  }

  @override
  Future<Either<StockUpdateFailures, List<StockUpdateViewEntity>>>
  fetchAllViewStockUpdateListForFilter({
    required String itemName,
    required String articleNo,
  }) async {
    List<StockUpdateViewModel> stockUpdateList =
        await stockUpdateLocalDataSource.fetchStockUpdateViewDataForFilter(
          itemName: itemName,
          articleNo: articleNo,
        );
    final List<StockUpdateViewEntity> model =
        stockUpdateList.map((e) => e.toEntity()).toList();
    return right(model);
  }

  @override
  Future<Either<StockUpdateFailures, List<StockUpdateRfidListingViewEntity>>>
  fetchRfidScanningList({required List<String> rfIds}) async {
    List<StockUpdateRfidListingViewModel> stockUpdateList =
        await stockUpdateLocalDataSource.fetchRfidScanningList(rfId: rfIds);
    final List<StockUpdateRfidListingViewEntity> model =
        stockUpdateList.map((e) => e.toEntity()).toList();
    return right(model);
  }

  @override
  Future<Either<StockUpdateFailures, Unit>>
  saveStockUpdateTransactionApiCall() async {
    final vesselData =
    await commonLocalDataSource.getAllVesselSpecification();

    final adminStructure =
    await commonLocalDataSource.getAllAdminStructureDetailsDb();

    String? vesselCode = vesselData.first.code;
    int? referenceTypeId = vesselData.first.siteTypeID;
    int? referenceSubId = vesselData.first.id;
    int? referenceId = vesselData.first.vesselRegID;

    int? adminStructureId;
    if(adminStructure.isNotEmpty){
      try{
        adminStructureId = adminStructure.firstWhere((element)
        => element.code == "ADJUST" && element.isActive == true).id;
      }catch(e){
        adminStructureId = null;
      }
    }

    final List<Map<String, dynamic>> data =
        await stockUpdateDataProcessor
            .fetchUnSyncedStockUpdateTransactionList();
    final List<StockUpdateTrnFetchApiModel> locationList =
        data.map(StockUpdateTrnFetchApiModel.fromMap).toList();

    if (locationList.isNotEmpty) {
    for (int i = 0; i < locationList.length; i++) {
        var qty = locationList[i].quantity;
        int newStock = qty.toInt();

        StockReqEntityModel mappedItem = StockReqEntityModel(
          stockID: null,
          itemID: locationList[i].itemId,
          itemLinkID: 0,
          storageLocationID: locationList[i].storageLocationId,
          referenceTypeID: referenceTypeId ?? 1,
          referenceID: referenceId ?? 1,
          referenceSubID: /*referenceSubId??*/ 13,//not needed in future
          expiryDate: null,
          unitPrice: 0.0,
          totalNewStockRob: locationList[i].newStock != null ? locationList[i].newStock!.toInt() : 0,
          totalRecondStockRob: locationList[i].reconditionStock != null ? locationList[i].reconditionStock!.toInt() : 0,
          totalRob: locationList[i].totalRob,
          equipmentID: 0,
          totalQuantity: 0,
          remarks: locationList[i].remarks,
          previousLocationID: locationList[i].storageLocationId,
          previousROB: 0,
          uomID: 0,
          batchNo: null,
          isIHM: false,
          isNoStock: false,
          storageLocationCode: "",
          newStock: newStock,
          reconditionStock: null,
          damageStock: null,
          installationTypeID: null,
          installationRefID: null,
          itemTransactionDate: locationList[i].modifiedOn,
          stockGrnList: [],
          stockSerialList: [],
        );

        StockUpdateTransactionSaveRequestModel requestModel =
            StockUpdateTransactionSaveRequestModel(
              grnID: null,
              transactionType: "ADJUST",
              //code for stock update
              transactionTypeID: adminStructureId??359,
              frequencyID: null,
              remarks: locationList[i].remarks,
              fromLocationID: locationList[i].storageLocationId,
              toLocationID: null,
              vesselCode: vesselCode ?? "788",
              stockReqEntity: [mappedItem],
            );


        StockUpdateTransactionSaveResponseModel? data =
            await stockUpdateRemoteDataSource.saveStockUpdateTransactionList(
              savePayload: requestModel,
            );

        if (data != null && data.status.isNotEmpty && data.status == "Y") {
          if (data.transactionHD.isNotEmpty) {
            await stockUpdateDataProcessor.updateSyncedDataFromApiStockUpdate(
              transactionHdId: locationList.first.transactionId,
              responseModel: data.transactionHD,
            );
          }
        }
      }
    }
    return right(unit);
  }
}
