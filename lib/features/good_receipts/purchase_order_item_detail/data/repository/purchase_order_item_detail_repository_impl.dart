import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../../core/error/error_codes.dart';
import '../../../../../core/service/db_service/tables/purchase_order_items_table.dart';
import '../../../../../core/service/other_service/file_logger_service.dart';
import '../../../../../core/utils/app_logger.dart';
import '../../../../common_feature/data/data_source/common_local_data_source.dart';
import '../../../../common_feature/domain/entities/fetch_imdg_class_entity.dart';
import '../../../../common_feature/domain/entities/item_entity.dart';
import '../../../../common_feature/domain/entities/quality_entity.dart';
import '../../../data/models/pending_po_split_location_model.dart';
import '../../../domain/entities/split_location_entity.dart';
import '../../../purchase_order/domain/entity/purchase_order_entity.dart';
import '../../domain/entity/serial_number_entity.dart';
import '../../domain/failures/purchase_order_item_details_failures.dart';
import '../../domain/repository/purchase_order_item_detail_repository.dart';
import '../../domain/use_cases/generate_serial_numbers_usecase.dart';
import '../../domain/use_cases/get_purchase_order_item_serial_number_usecase.dart';
import '../../domain/use_cases/get_purchase_order_item_split_location_data.dart';
import '../../domain/use_cases/update_purchase_order_item_usecase.dart';
import '../data_source/purchase_order_item_detail_local_data_source.dart';
import '../data_source/purchase_order_item_detail_remote_data_source.dart';
import '../exceptions/purchase_order_item_detail_exceptions.dart';
import '../models/serial_number_data.dart';

class PurchaseOrderItemDetailRepositoryImpl
    implements PurchaseOrderItemDetailRepository {
  PurchaseOrderItemDetailRepositoryImpl({
    required this.purchaseOrderItemDetailLocalDataSource,
    required this.purchaseOrderItemDetailRemoteDataSource,
    required this.appLogger,
    required this.fileLoggerService,
    required this.commonLocalDataSource,
  });

  final PurchaseOrderItemDetailLocalDataSource
  purchaseOrderItemDetailLocalDataSource;
  final PurchaseOrderItemDetailRemoteDataSource
  purchaseOrderItemDetailRemoteDataSource;
  final AppLogger appLogger;
  final FileLoggerService fileLoggerService;
  final CommonLocalDataSource commonLocalDataSource;

  Either<PurchaseOrderItemDetailsFailures, T> _errorFun<T>({
    required String errorCode,
    required String message,
    required PurchaseOrderItemDetailExceptions exceptions,
  }) {
    appLogger.error(errorCode, message);
    fileLoggerService.logToFile(logText: errorCode, pageType: message);

    switch (exceptions) {
      case PurchaseOrderItemDetailServerException():
        return left(
          PurchaseOrderItemDetailsNetworkFailure(
            code: errorCode,
            message: message,
          ),
        );
      case PurchaseOrderItemDetailDbException():
        return left(
          PurchaseOrderItemDetailsDbExceptionFailure(
            code: errorCode,
            message: message,
          ),
        );
      case PurchaseOrderItemDetailUnknowException():
        return left(
          PurchaseOrderItemDetailsUnknownFailure(
            code: errorCode,
            message: message,
          ),
        );
    }
  }

  @override
  Future<Either<PurchaseOrderItemDetailsFailures, Unit>>
  getQualityList() async {
    try {
      final response =
          await purchaseOrderItemDetailRemoteDataSource.getQualityList();
      if (response != null &&
          response.reportData != null &&
          response.reportData!.isNotEmpty) {
        await purchaseOrderItemDetailLocalDataSource.insertQualityList(
          qualityList: response.reportData!,
        );
      }
      return right(unit);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.purchaseOrderListFetchFailed,
        message: e.toString(),
        exceptions: PurchaseOrderItemDetailDbException(),
      );
    } on DioException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: PurchaseOrderItemDetailServerException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: PurchaseOrderItemDetailUnknowException(),
      );
    }
  }

  @override
  Future<Either<PurchaseOrderItemDetailsFailures, List<QualityEntity>>>
  getQualityListDb() async {
    try {
      final result =
          await purchaseOrderItemDetailLocalDataSource.getQualityList();
      return right(result.map((element) => element.toEntity()).toList());
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.purchaseOrderListFetchFailed,
        message: e.toString(),
        exceptions: PurchaseOrderItemDetailDbException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: PurchaseOrderItemDetailUnknowException(),
      );
    }
  }

  @override
  Future<Either<PurchaseOrderItemDetailsFailures, Unit>> getImdgClass() async {
    try {
      final response =
          await purchaseOrderItemDetailRemoteDataSource.getImdgClass();
      debugPrint(
        "response of getImdgClass : ${response?.reportData?.length.toString()}",
      );
      if (response != null &&
          response.reportData != null &&
          response.reportData!.isNotEmpty) {
        await purchaseOrderItemDetailLocalDataSource.insertImdgClassList(
          imdgClassList: response.reportData!,
        );
      }
      return right(unit);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.purchaseOrderListFetchFailed,
        message: e.toString(),
        exceptions: PurchaseOrderItemDetailDbException(),
      );
    } on DioException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.purchaseOrderListFetchFailed,
        message: e.toString(),
        exceptions: PurchaseOrderItemDetailServerException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.purchaseOrderListFetchFailed,
        message: e.toString(),
        exceptions: PurchaseOrderItemDetailUnknowException(),
      );
    }
  }

  @override
  Future<Either<PurchaseOrderItemDetailsFailures, List<ImdgClassEntity>>>
  getImdgClassListDb() async {
    try {
      final result =
          await purchaseOrderItemDetailLocalDataSource.getImdgClassList();
      return right(result.map((element) => element.toEntity()).toList());
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.purchaseOrderListFetchFailed,
        message: e.toString(),
        exceptions: PurchaseOrderItemDetailDbException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: PurchaseOrderItemDetailUnknowException(),
      );
    }
  }

  @override
  Future<Either<PurchaseOrderItemDetailsFailures, Unit>>
  updatePurchaseOrderItemData({
    required UpdatePurchaseOrderItemDataParams
    updatePurchaseOrderItemDataParams,
  }) async {
    try {
      final PurchaseOrderEntity purchaseOrderEntity =
          updatePurchaseOrderItemDataParams.purchaseOrderEntity;
      final ItemEntity itemEntity =
          updatePurchaseOrderItemDataParams.itemEntity;
      final List<SplitLocationEntity> splitLocationEntity = List.from(
        updatePurchaseOrderItemDataParams.splitLocationData,
      );
      debugPrint("purchaseOrderEntity.poHdId : ${purchaseOrderEntity.poHdId}");
      debugPrint("itemEntity.poDtId : ${itemEntity.poDtId}");

      Map<String, dynamic> dataToUpdate = {};
      dataToUpdate[PurchaseOrderItemsTable.isSync] = 0;
      dataToUpdate[PurchaseOrderItemsTable.receivedQty] =
          itemEntity.receivedQuantity;
      dataToUpdate[PurchaseOrderItemsTable.damagedQty] =
          itemEntity.damagedQuantity;
      dataToUpdate[PurchaseOrderItemsTable.newStockQty] =
          itemEntity.newStockQuantity;
      dataToUpdate[PurchaseOrderItemsTable.reconditionedStockQty] =
          itemEntity.reconditionedStock;
      dataToUpdate[PurchaseOrderItemsTable.qualityId] = itemEntity.qualityId;
      dataToUpdate[PurchaseOrderItemsTable.expiryDate] = itemEntity.expiryDate;
      dataToUpdate[PurchaseOrderItemsTable.imdgCode] = itemEntity.imdgClass;
      dataToUpdate[PurchaseOrderItemsTable.remarks] = itemEntity.remarks;
      debugPrint("dataToUpdate : $dataToUpdate");
      await purchaseOrderItemDetailLocalDataSource.updatePurchaseOrderItemData(
        poHdId: purchaseOrderEntity.poHdId,
        poDtId: itemEntity.poDtId,
        data: dataToUpdate,
      );

      List<PendingPoSplitLocationModel> pendingPoSplitLocationModelList =
          splitLocationEntity
              .map(PendingPoSplitLocationModel.fromEntity)
              .toList();
      debugPrint(
        "pendingPoSplitLocationModelList : ${pendingPoSplitLocationModelList.map((element) => element.toJson())}",
      );
      await purchaseOrderItemDetailLocalDataSource
          .insertPurchaseOrderSplitLocationList(
            pendingPoSplitLocationModelList: pendingPoSplitLocationModelList,
          );

      List<SerialNumberEntity> pendingPoSerialNumbers = [];
      for (var element in splitLocationEntity) {
        pendingPoSerialNumbers.addAll(
          element.serialNumbers.where((serial) => serial.splitLocationId != -1),
        );
      }
      List<SerialNumberData> pendingPoSerialNumbersData =
          pendingPoSerialNumbers.map(SerialNumberData.fromEntity).toList();
      await purchaseOrderItemDetailLocalDataSource
          .insertPurchaseOrderItemsSerialNumbers(
            serialNumberData: pendingPoSerialNumbersData,
          );

      return right(unit);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.purchaseOrderListFetchFailed,
        message: e.toString(),
        exceptions: PurchaseOrderItemDetailDbException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: PurchaseOrderItemDetailUnknowException(),
      );
    }
  }

  @override
  Future<Either<PurchaseOrderItemDetailsFailures, List<SplitLocationEntity>>>
  getPurchaseOrderItemSplitLocationData({
    required GetPurchaseOrderItemSplitLocationDataParams
    getPendingPoSplitLocationDataParams,
  }) async {
    try {
      final result = await purchaseOrderItemDetailLocalDataSource
          .getPurchaseOrderItemSplitLocationData(
            getPendingPoSplitLocationDataParams:
                getPendingPoSplitLocationDataParams,
          );
      return right(result.map((element) => element.toEntity()).toList());
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.purchaseOrderListFetchFailed,
        message: e.toString(),
        exceptions: PurchaseOrderItemDetailDbException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: PurchaseOrderItemDetailUnknowException(),
      );
    }
  }

  @override
  Future<Either<PurchaseOrderItemDetailsFailures, List<SerialNumberEntity>>>
  generateSerialNumbers({
    required GenerateSerialNumberParams generateSerialNumberParams,
  }) async {
    try {
      final vesselData =
          await commonLocalDataSource.getAllVesselSpecification();
      if (vesselData.isNotEmpty) {
        final serialNumbersFromApi =
            await purchaseOrderItemDetailRemoteDataSource.generateSerialNumbers(
              quantity: generateSerialNumberParams.quantity,
              vesselCode: vesselData.first.code ?? '',
              referenceId: vesselData.first.vesselRegID ?? -1,
              referenceSubId: vesselData.first.id ?? -1,
              referenceTypeId: vesselData.first.siteTypeID ?? -1,
            );
        debugPrint("serialNumbersFromApi : ${serialNumbersFromApi?.length}");
        if (serialNumbersFromApi != null && serialNumbersFromApi.isNotEmpty) {
          List<SerialNumberData> updatedSerialNumbers =
              serialNumbersFromApi
                  .map(
                    (element) => SerialNumberData(
                      id: element.id,
                      serialNumber: element.serialNumber,
                      poHdId: generateSerialNumberParams.id,
                      poDtId: generateSerialNumberParams.itemId,
                      typeId: generateSerialNumberParams.typeId,
                      splitLocationId: generateSerialNumberParams.id,
                    ),
                  )
                  .toList();

          return right(
            updatedSerialNumbers.map((element) => element.toEntity()).toList(),
          );
        } else {
          return left(
            PurchaseOrderItemDetailsSerialNoGenerationFailure(
              code: 'SRL-FAIL',
              message: "Vessel Specification not found",
            ),
          );
        }
      } else {
        return left(
          PurchaseOrderItemDetailsSerialNoGenerationFailure(
            code: 'SRL-FAIL',
            message: "Vessel Specification not found",
          ),
        );
      }
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.purchaseOrderListFetchFailed,
        message: e.toString(),
        exceptions: PurchaseOrderItemDetailDbException(),
      );
    } on DioException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.purchaseOrderListFetchFailed,
        message: e.toString(),
        exceptions: PurchaseOrderItemDetailServerException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.purchaseOrderListFetchFailed,
        message: e.toString(),
        exceptions: PurchaseOrderItemDetailUnknowException(),
      );
    }
  }

  @override
  Future<Either<PurchaseOrderItemDetailsFailures, List<SerialNumberEntity>>>
  getPurchaseOrderItemSerialNumberUseCase({
    required GetPurchaseOrderItemSerialNumberParams
    getPurchaseOrderItemSerialNumberParams,
  }) async {
    try {
      final listFromDb = await purchaseOrderItemDetailLocalDataSource
          .getPurchaseOrderItemsSerialNumbers(
            poHdId: getPurchaseOrderItemSerialNumberParams.poHdId,
            poDtId: getPurchaseOrderItemSerialNumberParams.poDtId,
          );
      return right(listFromDb.map((element) => element.toEntity()).toList());
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.purchaseOrderListFetchFailed,
        message: e.toString(),
        exceptions: PurchaseOrderItemDetailDbException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.purchaseOrderListFetchFailed,
        message: e.toString(),
        exceptions: PurchaseOrderItemDetailUnknowException(),
      );
    }
  }
}
