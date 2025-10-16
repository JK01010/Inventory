import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/error/error_codes.dart';
import '../../../../core/service/db_service/table_data_manipulation/consumption_transaction_data_processor.dart';
import '../../../../core/service/other_service/file_logger_service.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../common_feature/data/data_source/common_local_data_source.dart';
import '../../domin/entities/con_transaction_view_entity_model.dart';
import '../../domin/entities/consumption_location_entity.dart';
import '../../domin/entities/consumption_rfid_scanning_view_entity_model.dart';
import '../../domin/entities/consumption_transaction_entity_model.dart';
import '../../domin/failures/consumption_failures.dart';
import '../../domin/repository/consumption_repository.dart';
import '../data_source/consumption_transaction_local_data_source.dart';
import '../data_source/consumption_transaction_remote_data_source.dart';
import '../exceptions/consumption_exceptions.dart';
import '../models/con_transaction_view_model.dart';
import '../models/consumption_location_model.dart';
import '../models/consumption_rfid_scanning_view_model.dart';
import '../models/consumption_taransaction_response_model.dart';
import '../models/consumption_transaction_fetch_api_response_model.dart';
import '../models/consumption_transaction_save_api_request_model.dart';
import '../models/consumption_transaction_save_api_response_model.dart';

class ConsumptionRepositoryImpl implements ConsumptionRepository {
  const ConsumptionRepositoryImpl({
    required this.appLogger,
    required this.fileLoggerService,
    required this.consumptionTransactionLocalDataSource,
    required this.consumptionTransactionRemoteDataSource,
    required this.commonLocalDataSource,
    required this.consumptionTransactionDataProcessor,
  });

  final AppLogger appLogger;
  final FileLoggerService fileLoggerService;
  final ConsumptionTransactionLocalDataSource
  consumptionTransactionLocalDataSource;
  final ConsumptionTransactionRemoteDataSource
  consumptionTransactionRemoteDataSource; //accessing dataSource
  final CommonLocalDataSource commonLocalDataSource;
  final ConsumptionTransactionDataProcessor consumptionTransactionDataProcessor;

  //error function
  Either<ConsumptionFailures, T> _errorFun<T>({
    required String errorCode,
    required String message,
    required ConsumptionExceptions exceptions,
  }) {
    appLogger.error(errorCode, message);
    fileLoggerService.logToFile(logText: errorCode, pageType: message);

    switch (exceptions) {
      case ConsumptionServerException():
        return left(
          ConsumptionServerFailure(code: errorCode, message: message),
        );
      case ConsumptionTransactionInsertDbException():
        return left(
          ConsumptionGetAllTransactionListFailure(
            code: errorCode,
            message: message,
          ),
        );
    }
  }

  @override
  Future<Either<ConsumptionFailures, Unit>>
  insertConsumptionTransaction() async {
    try {
      await consumptionTransactionRemoteDataSource
          .getAllConsumptionTransactionListFromApi();
      return right(unit);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.consumptionDbWriteFail,
        message: e.toString(),
        exceptions: ConsumptionTransactionInsertDbException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: ConsumptionTransactionInsertDbException(),
      );
    }
  }

  @override
  Future<Either<ConsumptionFailures, List<ConTransactionViewEntity>>>
  fetchAllConsumptionTransactionList() async {
    try {
      List<ConTransactionViewModel> consumptionTransactionModel =
          await consumptionTransactionLocalDataSource
              .fetchAllConsumptionTransactionList();
      final List<ConTransactionViewEntity> list =
          consumptionTransactionModel.map((e) => e.toEntity()).toList();
      return right(list);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.consumptionFetchFailed,
        message: e.toString(),
        exceptions: ConsumptionTransactionInsertDbException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: ConsumptionTransactionInsertDbException(),
      );
    }
  }

  @override
  Future<Either<ConsumptionFailures, List<ConTransactionViewEntity>>>
  searchConTransactionDataFromDb({required String searchText}) async {
    List<ConTransactionViewModel> consumptionTransactionModel =
        await consumptionTransactionLocalDataSource
            .searchConTransactionDataFromDb(searchText: searchText);
    final List<ConTransactionViewEntity> list =
        consumptionTransactionModel.map((e) => e.toEntity()).toList();
    return right(list);
  }

  @override
  Future<Either<ConsumptionFailures, List<ConTransactionViewEntity>>>
  fetchConsumptionTransactionFilterList(
    String itemName,
    String articleNo,
  ) async {
    try {
      List<ConTransactionViewModel> consumptionTransactionModel =
          await consumptionTransactionLocalDataSource
              .fetchConsumptionTransactionListFilter(itemName, articleNo);
      final List<ConTransactionViewEntity> list =
          consumptionTransactionModel.map((e) => e.toEntity()).toList();
      return right(list);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.consumptionFetchFailed,
        message: e.toString(),
        exceptions: ConsumptionTransactionInsertDbException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: ConsumptionTransactionInsertDbException(),
      );
    }
  }

  @override
  Future<Either<ConsumptionFailures, List<ConsumptionRfidListingViewEntity>>>
  fetchRfidScanningList({required List<String> rfIds}) async {
    List<ConsumptionRfidScanningViewModel> stockUpdateList =
        await consumptionTransactionLocalDataSource.fetchRfidScanningList(
          rfId: rfIds,
        );
    final List<ConsumptionRfidListingViewEntity> model =
        stockUpdateList.map((e) => e.toEntity()).toList();
    return right(model);
  }

  @override
  Future<Either<ConsumptionFailures, Unit>> singleInsertConsumptionTransaction({
    required ConsumptionTransactionEntityModel model,
  }) async {
    ConsumptionTransactionModel insertData =
        ConsumptionTransactionModel.fromEntity(entity: model);
    await consumptionTransactionLocalDataSource.singleInsertData(
      model: insertData,
    );
    return right(unit);
  }

  @override
  Future<Either<ConsumptionFailures, Unit>>
  multipleInsertConsumptionTransaction({
    required List<ConsumptionTransactionEntityModel> list,
  }) async {
    List<ConsumptionTransactionModel> mappedList =
        list
            .map((e) => ConsumptionTransactionModel.fromEntity(entity: e))
            .toList();
    await consumptionTransactionLocalDataSource.multipleInsertData(
      list: mappedList,
    );
    return right(unit);
  }

  //location

  @override
  Future<Either<ConsumptionFailures, Unit>>
  insertConsumptionLocationList() async {
    // try {
    await consumptionTransactionRemoteDataSource.getAllLocationListFromApi();
    return right(unit);
    /*  } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.consumptionDbWriteFail,
        message: e.toString(),
        exceptions: ConsumptionTransactionInsertDbException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: ConsumptionTransactionInsertDbException(),
      );
    }*/
  }

  @override
  Future<Either<ConsumptionFailures, List<ConsumptionLocationEntity>>>
  fetchAllConsumptionLocationList() async {
    try {
      final List<ConsumptionLocationModel> consumptionLocationModel =
          await consumptionTransactionLocalDataSource
              .fetchAllConsumptionLocationList();
      final List<ConsumptionLocationEntity> entityList =
          consumptionLocationModel.map((e) => e.toEntity()).toList();
      return right(entityList);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.bagTagItemDetailFail,
        message: e.toString(),
        exceptions: ConsumptionTransactionInsertDbException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.bagTagItemDetailFail,
        message: e.toString(),
        exceptions: ConsumptionTransactionInsertDbException(),
      );
    }
  }

  @override
  Future<Either<ConsumptionFailures, Unit>>
  saveConsumptionTransactionApiCall() async {
    try {
      //fetch vessel based data
      final vesselData =
          await commonLocalDataSource.getAllVesselSpecification();
      final adminStructure =
          await commonLocalDataSource.getAllAdminStructureDetailsDb();

      String? vesselCode = vesselData.first.code; //vesselCode
      int? referenceTypeId = vesselData.first.siteTypeID;
      int? referenceSubId = vesselData.first.id;
      int? referenceId = vesselData.first.vesselRegID;

      int? adminStructureId;
      if(adminStructure.isNotEmpty){
        try{
          adminStructureId = adminStructure.firstWhere((element)
          => element.code == "ISSUE" && element.isActive == true).id;
        }catch(e){
          adminStructureId = null;
        }
      }
      log("Admin Structure Id ----------->  $adminStructureId");


      //fetch un-synced data from db
      final List<Map<String, dynamic>> data =
          await consumptionTransactionDataProcessor
              .fetchUnSyncedConsumptionTransactionList();
      final List<ConsumptionTrnFetchApiModel> locationList =
          data.map(ConsumptionTrnFetchApiModel.fromMap).toList();

      if (locationList.isNotEmpty) {
        for (int i = 0; i < locationList.length; i++) {
          var qty = locationList[i].quantity;
          int newStock = qty.toInt();
          StockReqEntityModel saveModel = StockReqEntityModel(
            stockID: null,
            itemID: locationList[i].itemId,
            itemLinkID: 0,
            storageLocationID: locationList[i].storageLocationId,
            referenceTypeID: referenceTypeId ?? 1,
            referenceID: referenceId ?? 1,
            referenceSubID: /*referenceSubId ?? */ 13,
            //not needed in future
            expiryDate: null,
            unitPrice: 0.0,
            totalNewStockRob: locationList[i].totalNewStock,
            totalRecondStockRob: locationList[i].totalReconditionStock,
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
            newStock: locationList[i].newStock,
            reconditionStock: locationList[i].reconditionStock,
            damageStock: null,
            installationTypeID: locationList[i].equipmentId == 0 ? 1 : 2,
            installationRefID: locationList[i].equipmentId,
            itemTransactionDate: locationList[i].modifiedOn,
            stockGrnList: [],
            stockSerialList: [],
          );

          ConsumptionTransactionSaveRequestModel requestModel =
              ConsumptionTransactionSaveRequestModel(
                grnID: null,
                transactionType: "ISSUE",
                transactionTypeID: adminStructureId??358,
                frequencyID: null,
                remarks: locationList[i].remarks,
                fromLocationID: locationList[i].storageLocationId,
                toLocationID: null,
                vesselCode: vesselCode ?? "788",
                stockReqEntity: [saveModel],
              );
          log(
            "Save Consumption request ----------->  ${requestModel.toJson()}",
          );

          //api call
          ConsumptionTransactionSaveResponseModel? data =
              await consumptionTransactionRemoteDataSource
                  .saveConsumptionTransactionListFromApi(
                    savePayload: requestModel,
                  );
          //update table based on response
          if (data != null && data.status.isNotEmpty && data.status == "Y") {
            if (data.transactionHD.isNotEmpty) {
              await consumptionTransactionDataProcessor.updateSyncedDataFromApi(
                transactionHdId: locationList.first.transactionId,
                responseModel: data.transactionHD,
              );
            }
          }
        }
      }
      return right(unit);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.consumptionSaveFailed,
        message: e.toString(),
        exceptions: ConsumptionTransactionInsertDbException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.consumptionDbSaveError,
        message: e.toString(),
        exceptions: ConsumptionTransactionInsertDbException(),
      );
    }
  }

  //equipmentList
  @override
  Future<Either<ConsumptionFailures, Unit>> insertEquipmentList() async {
    try {
      await consumptionTransactionRemoteDataSource.getAllEquipmentListFromApi();
      return right(unit);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.consumptionSaveFailed,
        message: e.toString(),
        exceptions: ConsumptionTransactionInsertDbException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: ConsumptionTransactionInsertDbException(),
      );
    }
  }

  @override
  Future<Either<ConsumptionFailures, int>> fetchROBDetails({
    required int itemId,
  }) async {
    try {
      int quantity = await consumptionTransactionLocalDataSource
          .fetchRobConsumptionAdd(itemId: itemId);
      return right(quantity);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.consumptionSaveFailed,
        message: e.toString(),
        exceptions: ConsumptionTransactionInsertDbException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: ConsumptionTransactionInsertDbException(),
      );
    }
  }
}
