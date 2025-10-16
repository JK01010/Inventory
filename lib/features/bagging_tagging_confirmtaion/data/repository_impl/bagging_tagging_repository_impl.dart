import 'package:flutter/material.dart';
import 'package:fpdart/src/either.dart';
import 'package:fpdart/src/unit.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/error/error_codes.dart';
import '../../../../core/service/other_service/file_logger_service.dart';
import '../../../../core/utils/app_logger.dart';
import '../../domain/entities/bagging_confirmation_list_entity.dart';
import '../../domain/entities/bagging_item_details_entity.dart';
import '../../domain/entities/bagging_tagging_purchase_list_view_entity.dart';
import '../../domain/entities/pending_list_model.dart';
import '../../domain/failures/bagging_and_tagging_failures.dart';
import '../../domain/repository/bagging_tagging_repository.dart';
import '../../model/bagging_confirmation_list_model.dart';
import '../../model/bagging_item_details_model.dart';
import '../data_source/bagging_tagging_local_data_source.dart';
import '../exceptions/bagging_tagging_exceptions.dart';
import '../model/bagging_tagging_pending_res.dart';
import '../model/bagging_tagging_purchase_list_view_model.dart';

class BaggingTaggingRepositoryImpl implements BaggingTaggingRepository {
  BaggingTaggingRepositoryImpl({
    required this.baggingTaggingLocalDataSource,
    required this.appLogger,
    required this.fileLoggerService,
  });

  final BaggingTaggingLocalDataSource baggingTaggingLocalDataSource;
  final AppLogger appLogger;
  final FileLoggerService fileLoggerService;

  @override
  Future<Either<BaggingAndTaggingFailures, Unit>>
  insertBaggingAndTaggingItemDetails() async {
    try {
      await baggingTaggingLocalDataSource.insertItemDetailsData();
      return right(unit);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.bagTagnDbWriteFail,
        message: e.toString(),
        exceptions: BaggingTaggingInsertDetailsException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.bagTagnDbWriteFail,
        message: e.toString(),
        exceptions: BaggingTaggingInsertDetailsException(),
      );
    }
  }

  @override
  Future<Either<BaggingAndTaggingFailures, Unit>> insertPendingList() async {
    try {
      await baggingTaggingLocalDataSource.insertPendingItems();
      return right(unit);
    } catch (e) {
      return _errorFun(
        errorCode: '',
        message: e.toString(),
        exceptions: BaggingTaggingInsertPendingListException(),
      );
    }
  }

  @override
  Future<Either<BaggingAndTaggingFailures, Unit>>
  insertBaggingConfirmationList() async {
    try {
      await baggingTaggingLocalDataSource.insertConfirmationList();
      return right(unit);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.bagTagConfirmListDbWriteFail,
        message: e.toString(),
        exceptions: BaggingTaggingInsertConfirmationListException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.bagTagConfirmListDbWriteFail,
        message: e.toString(),
        exceptions: BaggingTaggingInsertConfirmationListException(),
      );
    }
  }

  //get all

  @override
  Future<Either<BaggingAndTaggingFailures, List<BaggingItemDetailsEntity>>>
  getAllBaggingItemDetails() async {
    try {
      final List<BaggingItemDetailModel> baggingItemDetailsModel =
          await baggingTaggingLocalDataSource.getAllBaggingItemDetails();
      return right(baggingItemDetailsModel);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.bagTagItemDetailFail,
        message: e.toString(),
        exceptions: BaggingTaggingGetAllItemDetailsException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.bagTagItemDetailFail,
        message: e.toString(),
        exceptions: BaggingTaggingGetAllItemDetailsException(),
      );
    }
  }

  @override
  Future<Either<BaggingAndTaggingFailures, List<BaggingTaggingPendingEntity>>>
  getAllPendingList() async {
    try {
      final result = await baggingTaggingLocalDataSource.getAllPendingList();
      return right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return _errorFun(
        errorCode: '',
        message: e.toString(),
        exceptions: BaggingTaggingGetAllDbException(),
      );
    }
  }

  @override
  Future<Either<BaggingAndTaggingFailures, Unit>> updateSyncStatus(
    int poId,
  ) async {
    try {
      final success = await baggingTaggingLocalDataSource.changeSyncStatus(
        poId: poId,
      );
      if (success) {
        return right(unit);
      } else {
        return left(
          BaggingTaggingSyncStatusUpdateFailure(
            code: 'SYNC_FAILED',
            message: 'Could not update sync status',
          ),
        );
      }
    } catch (e) {
      return _errorFun(
        errorCode: '',
        message: e.toString(),
        exceptions: SyncStatusUpdateException(),
      );
    }
  }

  @override
  Future<Either<BaggingAndTaggingFailures, List<BaggingConfirmationListEntity>>>
  getAllConfirmationList() async {
    try {
      final List<BaggingConfirmationListModel> baggingConfirmationListModel =
          await baggingTaggingLocalDataSource.getAllConfirmationList();

      final List<BaggingConfirmationListEntity> baggingConfirmationListEntity =
          baggingConfirmationListModel.map((e) => e.toEntity()).toList();
      return right(baggingConfirmationListEntity);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.bagTagConfirmListDetailFail,
        message: e.toString(),
        exceptions: BaggingTaggingGetAllConfirmationListException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.bagTagConfirmListDetailFail,
        message: e.toString(),
        exceptions: BaggingTaggingGetAllConfirmationListException(),
      );
    }
  }

  @override
  Future<Either<BaggingAndTaggingFailures, String>> getAllStorageLocationData({
    required int storageLocationId,
  }) async {
    String storageLocation = await baggingTaggingLocalDataSource
        .getAllStorageLocationData(storageLocationId: storageLocationId);
    return right(storageLocation);
  }

  ///RFIF listing

  Future<Either<BaggingAndTaggingFailures, List<String>>>
  fetchRFIDListViewData({required int itemId}) async {
    final rfidIdData = await baggingTaggingLocalDataSource
        .fetchRFIDListViewData(itemId: itemId);
    return right(rfidIdData);
  }

  //Purchase DT

  @override
  Future<Either<BaggingAndTaggingFailures, Unit>>
  insertBaggingPurchaseList() async {
    // try {
    await baggingTaggingLocalDataSource.insertBaggingPurchaseList();
    return right(unit);
    /* } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.bagTagnPurchaseItemDetailsDbWriteFail,
        message: e.toString(),
        exceptions: BaggingTaggingGetAllConfirmationListException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.bagTagnPurchaseItemDetailsDbWriteFail,
        message: e.toString(),
        exceptions: BaggingTaggingGetAllConfirmationListException(),
      );
    }*/
  }

  @override
  Future<
    Either<
      BaggingAndTaggingFailures,
      List<BaggingTaggingPurchaseListViewEntity>
    >
  >
  getAllBaggingPurchaseList({required String poHDId}) async {
    // try {
    final List<BaggingTaggingPurchaseListViewModel>
    baggingTaggingPurchaseListViewModel = await baggingTaggingLocalDataSource
        .getAllBaggingPurchaseList(poHDId: poHDId);
    final List<BaggingTaggingPurchaseListViewEntity> list =
        baggingTaggingPurchaseListViewModel.map((e) => e.toEntity()).toList();

    return right(list);
    // } on DatabaseException catch (e) {
    //   return _errorFun(
    //     errorCode: AppErrorCodes.bagTagPurchaseItemDetailFail,
    //     message: e.toString(),
    //     exceptions: BaggingTaggingGetAllConfirmationListException(),
    //   );
    // } catch (e) {
    //   return _errorFun(
    //     errorCode: AppErrorCodes.bagTagPurchaseItemDetailFail,
    //     message: e.toString(),
    //     exceptions: BaggingTaggingGetAllConfirmationListException(),
    //   );
    // }
  }

  ///Error Function
  Either<BaggingAndTaggingFailures, T> _errorFun<T>({
    required String errorCode,
    required String message,
    required BaggingTaggingExceptions exceptions,
  }) {
    appLogger.error(errorCode);
    fileLoggerService.logToFile(logText: errorCode, pageType: message);

    switch (exceptions) {
      case BaggingTaggingServerException():
        return left(
          BaggingAndTaggingServerFailure(code: errorCode, message: message),
        );
      case BaggingTaggingGetAllItemDetailsException():
        return left(
          BaggingTaggingGetAllItemDetailsFailure(
            code: errorCode,
            message: message,
          ),
        );
      case BaggingTaggingGetAllDbException():
        return left(
          BaggingTaggingGetAllDbExceptionFailure(
            code: errorCode,
            message: message,
          ),
        );
      case BaggingTaggingInsertDetailsException():
        return left(
          BaggingTaggingInsertDetailsExceptionFailure(
            code: errorCode,
            message: message,
          ),
        );
      case BaggingInsertPurchaseDetailsException():
        return left(
          BaggingTaggingInsertDetailsExceptionFailure(
            code: errorCode,
            message: message,
          ),
        );
      case BaggingTaggingGetAllItemListException():
        return left(
          BaggingTaggingGetAllPurchaseItemListFailure(
            code: errorCode,
            message: message,
          ),
        );
      case BaggingTaggingInsertPendingListException():
        return left(
          BaggingTaggingInsertFailure(code: errorCode, message: message),
        );
      case SyncStatusUpdateException():
        return left(
          BaggingTaggingSyncStatusUpdateFailure(
            code: errorCode,
            message: message,
          ),
        );
      case UnknownException():
        return left(
          BaggingAndTaggingUnknownFailure(code: errorCode, message: message),
        );
      case BaggingTaggingInsertConfirmationListException():
        return left(
          BaggingTaggingInsertConfirmationListFailure(
            code: errorCode,
            message: message,
          ),
        );
      case BaggingTaggingGetAllConfirmationListException():
        return left(
          BaggingTaggingGetConfirmationListFailure(
            code: errorCode,
            message: message,
          ),
        );
      case BaggingTaggingPendingPoSearchException():
        return left(
          BaggingTaggingPoSearchExceptionFailure(
            code: errorCode,
            message: message,
          ),
        );
    }
  }

  ///search
  @override
  Future<Either<BaggingAndTaggingFailures, List<BaggingTaggingPendingEntity>>>
  searchFromBaggingPendingList({required String query}) async {
    // try {
    final List<BaggingTaggingPendingModel> baggingTaggingPendingModel =
        await baggingTaggingLocalDataSource.searchFromBaggingPendingList(
          query: query,
        );
    final List<BaggingTaggingPendingEntity> baggingTaggingEntityList =
        baggingTaggingPendingModel.map((e) => e.toEntity()).toList();
    return right(baggingTaggingEntityList);
    // } on DatabaseException catch (e) {
    //   return _errorFun(
    //     errorCode: AppErrorCodes.grnFetchFailed,
    //     message: e.toString(),
    //     exceptions: BaggingTaggingPendingPoSearchException(),
    //   );
    // } catch (e) {
    //   return _errorFun(
    //     errorCode: AppErrorCodes.grnFetchFailed,
    //     message: e.toString(),
    //     exceptions: BaggingTaggingPendingPoSearchException(),
    //   );
    // }
  }

  @override
  Future<Either<BaggingAndTaggingFailures, List<BaggingConfirmationListEntity>>>
  searchFromBaggingConfirmationList({required String query}) async {
    // try {
    final List<BaggingConfirmationListModel> baggingConfirmationListModel =
        await baggingTaggingLocalDataSource.searchFromBaggingConfirmationList(
          query: query,
        );
    final List<BaggingConfirmationListEntity>
    baggingTaggingConfirmationEntityList =
        baggingConfirmationListModel.map((e) => e.toEntity()).toList();
    return right(baggingTaggingConfirmationEntityList);
    // } on DatabaseException catch (e) {
    //   return _errorFun(
    //     errorCode: AppErrorCodes.grnFetchFailed,
    //     message: e.toString(),
    //     exceptions: BaggingTaggingPendingPoSearchException(),
    //   );
    // } catch (e) {
    //   return _errorFun(
    //     errorCode: AppErrorCodes.grnFetchFailed,
    //     message: e.toString(),
    //     exceptions: BaggingTaggingPendingPoSearchException(),
    //   );
    // }
  }

  @override
  Future<Either<BaggingAndTaggingFailures, List<Map<String, dynamic>>>>
  fetchAllLocationBasedOnScannedRfidItems({
    required List<String> rfid,
    required int itemId,
    required int grnId,
  }) async {
    final List<Map<String, dynamic>> data = await baggingTaggingLocalDataSource
        .fetchAllLocationOnScanning(itemId: itemId, grnId: grnId, rfid: rfid);

    return right(data);
  }

  @override
  Future<Either<BaggingAndTaggingFailures, List<Map<String, dynamic>>>>
  fetchConfirmationListByItemIds({required List<int> itemIds,required int storageLocationId,required int grnId}) async {
    final List<Map<String, dynamic>> data = await baggingTaggingLocalDataSource
        .fetchConfirmationListByItemIds(itemIds: itemIds,storageLocationId: storageLocationId,grnId: grnId);

    return right(data);
  }

  @override
  Future<Either<BaggingAndTaggingFailures, List<Map<String, dynamic>>>>
  fetchConfirmationListByGRNId({required String grnId}) async {
    final List<Map<String, dynamic>> data = await baggingTaggingLocalDataSource
        .fetchConfirmationListByGRNId(grnId: grnId);
    return right(data);
  }

  @override
  Future<Either<BaggingAndTaggingFailures, List<int>>> fetchItemIdsBasedOnRfid({required List<String> rfid}) async {
    final List<int> data = await baggingTaggingLocalDataSource.fetchItemIdsBasedOnRfid(rfid: rfid);
    return right(data);
  }

  @override
  Future<Either<BaggingAndTaggingFailures, Unit>> saveConfirmation({required int grnId,required List<int> itemIds}) async {
    try {
      await baggingTaggingLocalDataSource.saveConfirmation(grnId: grnId, items: itemIds);

      // return Right(Unit)
      return right(unit);
    } catch (e) {
      // failure → wrap inside Left
      return left(BaggingTaggingSaveConfirmationFailure(code: '', message: 'Save confirmation failed'));
    }
  }
}
