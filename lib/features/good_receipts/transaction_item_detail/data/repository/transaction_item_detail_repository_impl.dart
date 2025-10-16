import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../core/constants/app_encrypted_storage_keys.dart';
import '../../../../../core/error/error_codes.dart';
import '../../../../../core/service/other_service/app_secure_storage_service.dart';
import '../../../../../core/service/other_service/file_logger_service.dart';
import '../../../../../core/utils/app_logger.dart';
import '../../../../../core/utils/helper.dart';
import '../../../../common_feature/domain/failures/common_failures.dart';
import '../../../domain/entities/split_location_entity.dart';
import '../../domain/entity/transaction_item_detail_entity.dart';
import '../../domain/failures/transaction_item_detail_failure.dart';
import '../../domain/repository/transaction_item_detail_repository.dart';
import '../../domain/usecase/get_split_location_data_transaction_item_usecase.dart';
import '../data_source/transaction_item_detail_local_data_source.dart';
import '../data_source/transaction_item_detail_remote_data_source.dart';
import '../exceptions/transaction_item_detail_exception.dart';
import '../models/split_location_model.dart';
import '../models/transaction_item_detail_model.dart';

class TransactionItemDetailRepositoryImpl
    implements TransactionItemDetailRepository {
  TransactionItemDetailRepositoryImpl({
    required this.transactionItemDetailRemoteDataSource,
    required this.appLogger,
    required this.fileLoggerService,
    required this.transactionItemDetailLocalDataSource,
    required this.appSecureStorageService,
  });

  final TransactionItemDetailRemoteDataSource
  transactionItemDetailRemoteDataSource;
  final TransactionItemDetailLocalDataSource
  transactionItemDetailLocalDataSource;
  final AppLogger appLogger;
  final FileLoggerService fileLoggerService;
  final AppSecureStorageService appSecureStorageService;

  @override
  Future<Either<TransactionItemDetailFailure, Unit>>
  getAllTransactionItemDetailFromApi() async {
    try {
      final String? lastModifiedDate = await appSecureStorageService.read(
        key: AppEncryptedStorageKeys.lastModifiedTimeStampTransactionItemsList,
      );
      debugPrint(
        "lastModifiedDate of transaction item detail: $lastModifiedDate",
      );
      final TransactionItemDetailResponseModel? response =
          await transactionItemDetailRemoteDataSource
              .getAllTransactionItemDetail(lastModifiedDate: lastModifiedDate);
      if (response != null &&
          response.entityValidation != null &&
          response.entityValidation!.status == true &&
          response.reportData != null &&
          response.reportData!.isNotEmpty) {
        await transactionItemDetailLocalDataSource
            .insertTransactionItemDetailData(
              transactionItemDetailModelList: response.reportData ?? [],
            );
        await appSecureStorageService.write(
          key:
              AppEncryptedStorageKeys.lastModifiedTimeStampTransactionItemsList,
          value: generateFormattedUTC(),
        );
      }

      return right(unit);
    } on DioException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: TransactionItemDetailServerException(),
      );
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.purchaseOrderListFetchFailed,
        message: e.toString(),
        exceptions: TransactionItemDetailDbException(),
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: "",
        exceptions: TransactionItemDetailUnknownException(),
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<Either<CommonFailures, Unit>> getSplitLocationData() async {
    try {
      final SplitLocationModel? splitLocationModel =
          await transactionItemDetailRemoteDataSource.getSplitLocationData();

      if (splitLocationModel != null && splitLocationModel.reportData != null) {
        debugPrint("inside the splitLocationModel **************");
        await transactionItemDetailLocalDataSource.insertSplitLocationData(
          splitLocationData: splitLocationModel.reportData!,
        );
      }
      return right(unit);
    } catch (e) {
      return left(ServerFailure(code: '', message: ''));
    }
  }

  @override
  Future<Either<TransactionItemDetailFailure, List<SplitLocationEntity>>>
  getSplitLocationDataForTransactionItem({
    required GetSplitLocationDataTransactionItemParams
    getSplitLocationDataTransactionItemParams,
  }) async {
    try {
      debugPrint(
        "GetSplitLocationDataTransactionItemParams grnId: ${getSplitLocationDataTransactionItemParams.grnId}, grnDtId: ${getSplitLocationDataTransactionItemParams.grnDtId}",
      );
      final splitLocationResult = await transactionItemDetailLocalDataSource
          .getSplitStorageLocationForTransactionItem(
            grnId: getSplitLocationDataTransactionItemParams.grnId,
            grnDtId: getSplitLocationDataTransactionItemParams.grnDtId,
          );

      return right(splitLocationResult.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.purchaseOrderListFetchFailed,
        message: e.toString(),
        exceptions: TransactionItemDetailDbException(),
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: "",
        exceptions: TransactionItemDetailUnknownException(),
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }

  Either<TransactionItemDetailFailure, T> _errorFun<T>({
    required String errorCode,
    required String message,
    required TransactionItemDetailException exceptions,
    StackTrace? stackTrace,
  }) {
    appLogger.error(errorCode, message, stackTrace);
    fileLoggerService.logToFile(
      logText: errorCode,
      pageType: '$message\nStackTrace: $stackTrace',
    );
    switch (exceptions) {
      case TransactionItemDetailUnknownException():
        return left(TransactionItemDetailUnknownFailure());
      case TransactionItemDetailDbException():
        return left(TransactionItemDetailDbFailure());
      case TransactionItemDetailServerException():
        return left(TransactionItemDetailServerFailure());
    }
  }
}
