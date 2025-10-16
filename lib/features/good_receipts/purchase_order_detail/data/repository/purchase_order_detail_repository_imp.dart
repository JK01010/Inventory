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
import '../../../../common_feature/domain/entities/item_entity.dart';
import '../../../purchase_order/data/model/purchase_order_attachment_model.dart';
import '../../domain/failures/purchase_order_details_failures.dart';
import '../../domain/repository/purchase_order_detail_repository.dart';
import '../../domain/use_cases/draft_purchase_order_usecase.dart';
import '../../domain/use_cases/get_purchase_order_items_db_usecase.dart';
import '../data_source/purchase_order_detail_remote_data_source.dart';
import '../data_source/purchase_order_local_data_source.dart';
import '../exceptions/purchase_order_detail_exceptions.dart';

class PurchaseOrderDetailRepositoryImpl
    implements PurchaseOrderDetailRepository {
  PurchaseOrderDetailRepositoryImpl({
    required this.purchaseOrderDetailRemoteDataSource,
    required this.purchaseOrderDetailsLocalDataSource,
    required this.appLogger,
    required this.fileLoggerService,
    required this.appSecureStorageService,
  });

  final PurchaseOrderDetailRemoteDataSource purchaseOrderDetailRemoteDataSource;
  final PurchaseOrderDetailsLocalDataSource purchaseOrderDetailsLocalDataSource;
  final AppLogger appLogger;
  final FileLoggerService fileLoggerService;
  final AppSecureStorageService appSecureStorageService;

  @override
  Future<Either<PurchaseOrderDetailsFailures, List<ItemEntity>>>
  getPurchaseOrderItemsFromDb({
    required GetPurchaseOrderItemsDbParams params,
  }) async {
    try {
      debugPrint('getPurchaseOrderItemsFromDb poHdId : ${params.poHdId}');
      final purchaseOrderItemsList = await purchaseOrderDetailsLocalDataSource
          .getPurchaseOrderItems(poHdId: params.poHdId);
      return right(
        purchaseOrderItemsList.map((element) => element.toEntity()).toList(),
      );
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.purchaseOrderListFetchFailed,
        message: e.toString(),
        exceptions: PurchaseOrderItemDbException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: PurchaseOrderDetailUnknowException(),
      );
    }
  }

  @override
  Future<Either<PurchaseOrderDetailsFailures, Unit>>
  getPurchaseOrderItems() async {
    try {
      final String? lastModifiedDate = await appSecureStorageService.read(
        key:
            AppEncryptedStorageKeys.lastModifiedTimeStampPurchaseOrderItemsList,
      );
      final response = await purchaseOrderDetailRemoteDataSource
          .getPurchaseOrderItems(lastModifiedDate: lastModifiedDate);
      if (response != null &&
          response.reportData != null &&
          response.reportData!.isNotEmpty) {
        await purchaseOrderDetailsLocalDataSource.insertPurchaseOrderItems(
          purchaseOrderItems: response.reportData!,
        );
        await appSecureStorageService.write(
          key:
              AppEncryptedStorageKeys
                  .lastModifiedTimeStampPurchaseOrderItemsList,
          value: generateFormattedUTC(),
        );
      }
      return right(unit);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.purchaseOrderListFetchFailed,
        message: e.toString(),
        exceptions: PurchaseOrderItemDbException(),
      );
    } on DioException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: PurchaseOrderItemsServerException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: PurchaseOrderDetailUnknowException(),
      );
    }
  }

  Either<PurchaseOrderDetailsFailures, T> _errorFun<T>({
    required String errorCode,
    required String message,
    required PurchaseOrderDetailExceptions exceptions,
  }) {
    appLogger.error(errorCode, message);
    fileLoggerService.logToFile(logText: errorCode, pageType: message);

    switch (exceptions) {
      case PurchaseOrderItemsServerException():
        return left(
          PurchaseOrderDetailsNetworkFailure(code: errorCode, message: message),
        );
      case PurchaseOrderItemDbException():
        return left(
          PurchaseOrderDetailsDbExceptionFailure(
            code: errorCode,
            message: message,
          ),
        );
      case PurchaseOrderDetailUnknowException():
        return left(
          PurchaseOrderDetailsUnknownFailure(code: errorCode, message: message),
        );
    }
  }

  @override
  Future<Either<PurchaseOrderDetailsFailures, Unit>>
  getPurchaseOrderAttachmentFromApi() async {
    try {
      final PurchaseOrderAttachmentModelResponseModel? response =
          await purchaseOrderDetailRemoteDataSource
              .getPurchaseOrderAttachments();
      if (response != null &&
          response.reportData != null &&
          response.reportData!.isNotEmpty) {
        final List<String> uniqueIdList =
            response.reportData
                ?.map((e) => e.documentUniqueID)
                .whereType<String>()
                .toList() ??
            [];
        final List<PurchaseOrderAttachmentModel> metaDataResponse =
            await purchaseOrderDetailRemoteDataSource
                .getPurchaseOrderAttachmentsMetaData(
                  uniqueIdList: uniqueIdList,
                );
        final List<PurchaseOrderAttachmentModel> mergedList =
            metaDataResponse.map((attachment) {
              final meta = response.reportData?.firstWhere(
                (element) =>
                    element.documentUniqueID == attachment.documentUniqueID,
                orElse: () => attachment,
              );

              return attachment.copyWith(poHdId: meta?.poHdId);
            }).toList();

        await purchaseOrderDetailsLocalDataSource
            .insertPurchaseOrderAttachments(
              purchaseOrderAttachmentModel: metaDataResponse,
            );
      }
      return right(unit);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.purchaseOrderListFetchFailed,
        message: e.toString(),
        exceptions: PurchaseOrderItemDbException(),
      );
    } on DioException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: PurchaseOrderItemsServerException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: PurchaseOrderDetailUnknowException(),
      );
    }
  }

  @override
  Future<Either<PurchaseOrderDetailsFailures, Unit>> draftPurchaseOrder({
    required DraftPurchaseOrderParams params,
  }) async {
    try {

      return right(unit);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.purchaseOrderListFetchFailed,
        message: e.toString(),
        exceptions: PurchaseOrderItemDbException(),
      );
    } on DioException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: PurchaseOrderItemsServerException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: PurchaseOrderDetailUnknowException(),
      );
    }
  }
}
