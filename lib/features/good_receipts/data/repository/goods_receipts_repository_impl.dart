import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/error/error_codes.dart';
import '../../../../core/service/network/connectivity_manager.dart';
import '../../../../core/service/other_service/file_logger_service.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../common_feature/data/data_source/common_local_data_source.dart';
import '../../../common_feature/data/data_source/common_network_data_source.dart';
import '../../../common_feature/data/model/fetch_imdg_class_model.dart';
import '../../../common_feature/data/model/storage_location_model.dart';
import '../../../common_feature/domain/entities/fetch_imdg_class_entity.dart';
import '../../../common_feature/domain/entities/storage_location_entity.dart';
import '../../domain/entities/goods_receipt_attachment_entity.dart';
import '../../domain/entities/goods_receipt_ihm_attachment_entity.dart';
import '../../domain/entities/goods_receipt_label_attachment_entity.dart';
import '../../domain/entities/goods_receipt_purchase_item_detail_entity.dart';
import '../../domain/entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../../domain/entities/goods_receipt_transaction_entity.dart';
import '../../domain/entities/grn_create_label_entity.dart';
import '../../domain/entities/grn_location_mapping_entity.dart';
import '../../domain/entities/grn_location_serial_mapping_entity.dart';
import '../../domain/entities/item_category_config_entity.dart';
import '../../domain/entities/item_rob_details_entity.dart';
import '../../domain/entities/packet_details_entity.dart';
import '../../domain/entities/purchase_order_hd_entity.dart';
import '../../domain/entities/split_location_entity.dart';
import '../../domain/entities/transaction_filter_entity.dart';
import '../../domain/failures/goods_receipts_failures.dart';
import '../../domain/repository/goods_receipts_repository.dart';
import '../../domain/use_cases/get_pending_po_split_location_data_use_case.dart';
import '../../domain/use_cases/get_po_item_details_usecase.dart';
import '../../domain/use_cases/goods_receipts_po_usecase/save_goods_receipts_usecase.dart';
import '../../transaction_item_detail/data/models/split_location_model.dart';
import '../data_source/goods_receipts_local_data_source.dart';
import '../data_source/goods_receipts_remote_data_source.dart';
import '../exceptions/goods_receipts_exceptions.dart';
import '../models/goods_receipt_detail_attachment_response_model.dart';
import '../models/goods_receipt_ihm_attachment_model.dart';
import '../models/goods_receipt_label_attachment_model.dart';
import '../models/goods_receipt_purchase_item_detail_model.dart';
import '../models/goods_receipt_transaction_item_detail_model.dart';
import '../models/grn_create_label_model.dart';
import '../models/grn_location_mapping_model.dart';
import '../models/grn_location_serial_mapping_model.dart';
import '../models/grn_packet_details_fetch_api_response_model.dart';
import '../models/item_category_config_model.dart';
import '../models/item_rob_details_model.dart';
import '../models/packet_details_model.dart';
import '../models/pending_po_split_location_model.dart';
import '../models/purcase_order_hd_model.dart';

class GoodsReceiptsRepositoryImpl implements GoodsReceiptsRepository {
  GoodsReceiptsRepositoryImpl({
    required this.goodsReceiptsLocalDataSource,
    required this.appLogger,
    required this.fileLoggerService,
    required this.connectivityManager,
    required this.goodsReceiptsRemoteDataSource,
    required this.commonLocalDataSource,
    required this.commonNetworkDataSource,
  });

  final GoodsReceiptsLocalDataSource goodsReceiptsLocalDataSource;
  final AppLogger appLogger;
  final FileLoggerService fileLoggerService;
  final ConnectivityManager connectivityManager;
  final GoodsReceiptsRemoteDataSource goodsReceiptsRemoteDataSource;
  final CommonLocalDataSource commonLocalDataSource;
  final CommonNetworkDataSource commonNetworkDataSource;

  @override
  Future<Either<GoodsReceiptsFailures, Unit>> insertGoodsReceiptsPo() async {
    try {
      // await goodsReceiptsLocalDataSource.insertPacketDetailsData();
      ///GRNPacketDetails Api
      if (await connectivityManager.isConnected) {
        final List<GRNPacketDetailsModel> packetDetailsList =
            await goodsReceiptsRemoteDataSource.insertPacketDetailsData();
        await goodsReceiptsLocalDataSource.insertPacketDetailsData(
          grnPacketDetailsModelList: packetDetailsList,
        );
      }

      await goodsReceiptsLocalDataSource.insertData();
      await goodsReceiptsLocalDataSource.insertStockLocationData();
      // await goodsReceiptsLocalDataSource.insertSplitLocationData(); //ToDo
      return right(unit);
    } on DatabaseException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: GoodsReceiptsInsertPoException(),
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: GoodsReceiptsInsertPoException(),
        stackTrace: stackTrace,
      );
    }
  }

  Either<GoodsReceiptsFailures, T> _errorFun<T>({
    required String errorCode,
    required String message,
    required GoodsReceiptsExceptions exceptions,
    StackTrace? stackTrace,
  }) {
    appLogger.error(errorCode, message, stackTrace);
    fileLoggerService.logToFile(
      logText: errorCode,
      pageType: '$message\nStackTrace: $stackTrace',
    );

    switch (exceptions) {
      case GoodsReceiptsServerException():
        return left(
          GoodsReceiptsServerFailure(code: errorCode, message: message),
        );
      case LockStatusUpdateException():
        return left(
          GoodsReceiptsLockStatusUpdateFailure(
            code: errorCode,
            message: message,
          ),
        );
      case UnknownException():
        return left(
          GoodsReceiptsUnknownFailure(code: errorCode, message: message),
        );
      case GoodsReceiptsGetAllDbException():
        return left(
          GoodsReceiptsGetAllDbFailure(code: errorCode, message: message),
        );
      case GoodsReceiptsInsertPoException():
        return left(
          GoodsReceiptsInsertPoFailure(code: errorCode, message: message),
        );
      case GoodsReceiptsInsertPoDetailException():
        return left(
          GoodsReceiptsDetailInsertPoFailure(code: errorCode, message: message),
        );
      case GoodsReceiptsGetPoDetailByIDException():
        return left(
          GetGoodsReceiptsDetailByIdFailure(code: errorCode, message: message),
        );
      case GoodsReceiptsInsertAttachmentException():
        return left(
          GoodsReceiptsDetailInsertAttachmentFailure(
            code: errorCode,
            message: message,
          ),
        );
      case GoodsReceiptsInsertDetailLabelException():
        return left(
          GoodsReceiptsInsertLabelDetailFailure(
            code: errorCode,
            message: message,
          ),
        );
      case GoodsReceiptsGetLabelItemsException():
        return left(
          GetGoodsReceiptsLabelDetailFailure(code: errorCode, message: message),
        );
      case TransactionItemSyncException():
        return left(
          TransactionItemSyncFailure(code: errorCode, message: message),
        );
      case GoodsReceiptsUpdatePoDetailException():
        return left(
          UpdateGoodsReceiptsPoDetailFailure(code: errorCode, message: message),
        );
      case AttachmentFileUpdateException():
        return left(
          GoodsReceiptsUploadFileFailure(code: errorCode, message: message),
        );
      case GoodsReceiptsDetailUpdateLabelListException():
        return left(
          GoodsReceiptDetailUpdateLabelListFailure(
            code: errorCode,
            message: message,
          ),
        );
      case GoodsReceiptsDetailUpdateLabelException():
        return left(
          GoodsReceiptDetailUpdateLabelFailure(
            code: errorCode,
            message: message,
          ),
        );
      case GoodsReceiptsCreateLabelSaveException():
        return left(
          GoodsReceiptCreateLabelSaveDetailFailure(
            code: errorCode,
            message: message,
          ),
        );
      case GoodsReceiptsPendingPoSearchException():
        return left(
          GoodsReceiptsPendingPoSearchFailure(
            code: errorCode,
            message: message,
          ),
        );
      case GoodsReceiptsGetAttachmentException():
        return left(
          GoodsReceiptsDetailGetAttachmentFailure(
            code: errorCode,
            message: message,
          ),
        );
      case GoodsReceiptsGetLabelAttachmentsException():
        return left(
          GoodsReceiptsGetLabelAttachmentFailure(
            code: errorCode,
            message: message,
          ),
        );
      case GoodsReceiptsInsertLabelAttachmentException():
        return left(
          GoodsReceiptsInsertLabelAttachmentFailure(
            code: errorCode,
            message: message,
          ),
        );
      case GoodsReceiptsGetIhmAttachmentsException():
        return left(
          GoodsReceiptsGetIhmAttachmentFailure(
            code: errorCode,
            message: message,
          ),
        );
      case GoodsReceiptsInsertTransactionException():
        return left(
          GoodsReceiptsInsertTransactionFailure(
            code: errorCode,
            message: message,
          ),
        );
      case GoodsReceiptsInsertTransactionDetailException():
        return left(
          GoodsReceiptsInsertTransactionDetailFailure(
            code: errorCode,
            message: message,
          ),
        );
      case GoodsReceiptsGetAllTransactionDetailException():
        return left(
          GoodsReceiptsGetAllTransactionDetailFailure(
            code: errorCode,
            message: message,
          ),
        );
      case GoodsReceiptsGetTransactionDetailByIdException():
        return left(
          GoodsReceiptsGetTransactionDetailByIdFailure(
            code: errorCode,
            message: message,
          ),
        );
      case StockLocationUpdateException():
        return left(
          UpdateGoodsReceiptsPoDetailFailure(code: errorCode, message: message),
        );
      case GetSplitLocationException():
        return left(
          SplitLocationGetLocationsByIdFailure(
            code: errorCode,
            message: message,
          ),
        );
      case InsertOrUpdateSplitLocationException():
        return left(
          InsertOrUpdateSplitLocationFailure(code: errorCode, message: message),
        );
      case DeleteGoodsReceiptLabelItemException():
        return left(
          DeleteGoodsReceiptLabelItemFailure(code: errorCode, message: message),
        );
      case GetStorageLocationException():
        return left(
          StorageLocationGetLocationsByIdFailure(
            code: errorCode,
            message: message,
          ),
        );
      case DeleteSplitLocationItemException():
        return left(
          DeleteSplitLocationItemFailure(code: errorCode, message: message),
        );
      case GetAllStorageLocationException():
        return left(
          GetAllStorageLocationsFailure(code: errorCode, message: message),
        );
      case GetAllImdgClassException():
        return left(
          GetAllImdgClassesFailure(code: errorCode, message: message),
        );
      case GoodsReceiptsSavePacketDetailsException():
        return left(
          SavePacketDetailsListFailure(code: errorCode, message: message),
        );
      case GoodsReceiptsGetAllPoLineItemsException():
        return left(
          GetGoodsReceiptPoLineItemsListFailure(
            code: errorCode,
            message: message,
          ),
        );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, PurchaseOrderHDEntity>>
  getGoodsReceiptDetailsById(int poId) async {
    try {
      if (await connectivityManager.isConnected) {
        try {
          final List<PurchaseOrderHDModel> goodsReceiptsModel = [];

          final List<PurchaseOrderHDEntity> goodsReceiptsEntityList =
              goodsReceiptsModel.map((e) => e.toEntity()).toList();
          final PurchaseOrderHDEntity goodsReceiptsEntity =
              goodsReceiptsEntityList.first;
          return right(goodsReceiptsEntity);
        } catch (e) {
          return left(
            GoodsReceiptsServerFailure(code: "", message: e.toString()),
          );
        }
      } else {
        final PurchaseOrderHDModel purchaseOrderHDModel =
            await goodsReceiptsLocalDataSource.goodsReceiptDetailEntity(poId);
        return right(purchaseOrderHDModel.toEntity());
      }
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetPoDetailByIDException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetPoDetailByIDException(),
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, Unit>>
  insertGoodsReceiptsAttachments() async {
    try {
      await goodsReceiptsLocalDataSource.insertGoodsReceiptAttachmentData();
      return right(unit);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: GoodsReceiptsInsertAttachmentException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: GoodsReceiptsInsertAttachmentException(),
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptAttachmentEntity>>>
  getGoodsReceiptAttachmentList(int poId) async {
    try {
      List<GoodsReceiptDetailAttachmentModel> goodsReceiptDetailAttachmentList =
          await goodsReceiptsLocalDataSource.getGoodsReceiptDetailAttachment(
            poId,
          );

      return right(goodsReceiptDetailAttachmentList);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetAttachmentException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetAttachmentException(),
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptsTransactionEntity>>>
  getAllTransactions({TransactionFilterEntity? filter}) async {
    try {
      if (await connectivityManager.isConnected) {
        // final List<TransactionModel> transactionModel =
        //     await goodsReceiptsRemoteDataSource.getAllTransaction();

        // await goodsReceiptsLocalDataSource.insertTransactionData(
        //   transactionModelItem: transactionModel,
        // );
      }

      // Prepare filter model if provided
      // final TransactionFilterModel? model =
      //     filter != null ? TransactionFilterModel.fromEntity(filter) : null;
      // Fetch from local (with or without filter)
      // final transactionList = await goodsReceiptsLocalDataSource
      //     .getAllTransaction(filter: model);

      // final transactionEntityList =
      //     transactionList.map((e) => e.toEntity()).toList();

      return right([]);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnTransactionFetchFailed,
        message: e.toString(),
        exceptions: GoodsReceiptsGetAllDbException(),
      );
    } catch (e) {
      log(e.toString());
      return _errorFun(
        errorCode: AppErrorCodes.grnTransactionFetchFailed,
        message: e.toString(),
        exceptions: GoodsReceiptsGetAllDbException(),
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, Unit>>
  insertGoodsReceiptsDetailLabel() async {
    try {
      await goodsReceiptsLocalDataSource.insertGoodsReceiptsDetailLabel();
      return right(unit);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: GoodsReceiptsInsertDetailLabelException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: GoodsReceiptsInsertDetailLabelException(),
      );
    }
  }

  @override
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  getGoodsReceiptDetailLabelItems(String poId) async {
    try {
      debugPrint(
        "getGoodsReceiptDetailLabelItems in getGoodsReceiptDetailLabelItems: $poId",
      );
      // if (await connectivityManager.isConnected) {
      //   try {
      //     final List<GoodsReceiptPurchaseItemDetailModel>
      //     goodsReceiptPurchaseItemDetailModelList =
      //         await goodsReceiptsRemoteDataSource
      //             .getGoodsReceiptDetailLabelItems(poId);
      //     final List<GoodsReceiptPurchaseOrderLineItemEntity>
      //     goodsReceiptPurchaseOrderLineItemEntityList =
      //         goodsReceiptPurchaseItemDetailModelList
      //             .map((e) => e.toEntity())
      //             .toList();
      //     return right(goodsReceiptPurchaseOrderLineItemEntityList);
      //   } catch (e) {
      //     return left(
      //       GoodsReceiptsServerFailure(code: "", message: e.toString()),
      //     );
      //   }
      // } else {
      List<GoodsReceiptPurchaseItemDetailModel> goodReceiptDetailLabelList =
          await goodsReceiptsLocalDataSource.getGoodsReceiptDetailLabelItems(
            poId,
          );

      final List<GoodsReceiptPurchaseOrderLineItemEntity>
      goodsReceiptsDetailLabelEntityList =
          goodReceiptDetailLabelList.map((e) => e.toEntity()).toList();
      return right(goodsReceiptsDetailLabelEntityList);
      // }
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetLabelItemsException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetLabelItemsException(),
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, Unit>> syncTransactionList({
    required List<GoodsReceiptsTransactionEntity> transactionEntityItem,
  }) async {
    try {
      // final poIds = transactionEntityItem.map((e) => e.poId).toList();
      // goodsReceiptsLocalDataSource.updateSyncList(transactionListId: poIds);
      return right(unit);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbUpdateError,
        message: e.toString(),
        exceptions: TransactionItemSyncException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbUpdateError,
        message: e.toString(),
        exceptions: TransactionItemSyncException(),
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, PurchaseOrderHDEntity>>
  updateGoodsReceiptsPoDetail(
    PurchaseOrderHDEntity purchaseOrderHDEntity,
  ) async {
    // try {
    PurchaseOrderHDModel purchaseOrderHDModel =
        await goodsReceiptsLocalDataSource.updateGoodsReceiptsPoDetail(
          PurchaseOrderHDModel.fromEntity(purchaseOrderHDEntity),
        );

    return right(purchaseOrderHDModel.toEntity());
    // } on DatabaseException catch (e) {
    //   return _errorFun(
    //     errorCode: AppErrorCodes.grnDbUpdateError,
    //     message: e.toString(),
    //     exceptions: GoodsReceiptsUpdatePoDetailException(),
    //   );
    // } catch (e) {
    //   return _errorFun(
    //     errorCode: AppErrorCodes.grnDbUpdateError,
    //     message: e.toString(),
    //     exceptions: GoodsReceiptsUpdatePoDetailException(),
    //   );
    // }
  }

  @override
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptAttachmentEntity>>>
  insertCapturedOrSelectedMediaAttachments(
    List<GoodsReceiptAttachmentEntity> goodsReceiptAttachmentEntityList,
  ) async {
    try {
      List<GoodsReceiptDetailAttachmentModel> goodsReceiptDetailAttachmentList =
          await goodsReceiptsLocalDataSource
              .insertCapturedOrSelectedMediaAttachments(
                GoodsReceiptDetailAttachmentModel.fromEntityList(
                  goodsReceiptAttachmentEntityList,
                ),
              );
      return right(goodsReceiptDetailAttachmentList);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsInsertAttachmentException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsInsertAttachmentException(),
      );
    }
  }

  @override
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  updateGoodsReceiptsDetailLabelList(
    List<GoodsReceiptPurchaseOrderLineItemEntity>
    goodsReceiptPurchaseOrderLineItemEntity,
  ) async {
    try {
      List<GoodsReceiptPurchaseItemDetailModel>
      goodsReceiptPurchaseItemModelList = await goodsReceiptsLocalDataSource
          .updateGoodsReceiptsDetailLabelList(
            GoodsReceiptPurchaseItemDetailModel.fromEntityList(
              goodsReceiptPurchaseOrderLineItemEntity,
            ),
          );

      final List<GoodsReceiptPurchaseOrderLineItemEntity>
      goodsReceiptPurchaseOrderLineItemEntityList =
          goodsReceiptPurchaseItemModelList.map((e) => e.toEntity()).toList();
      return right(goodsReceiptPurchaseOrderLineItemEntityList);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbUpdateError,
        message: e.toString(),
        exceptions: GoodsReceiptsDetailUpdateLabelListException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbUpdateError,
        message: e.toString(),
        exceptions: GoodsReceiptsDetailUpdateLabelListException(),
      );
    }
  }

  @override
  Future<
    Either<GoodsReceiptsFailures, GoodsReceiptPurchaseOrderLineItemEntity?>
  >
  goodsReceiptGetLabelDetailById(int dtId, int hdId, int itemId) async {
    try {
      // if (await connectivityManager.isConnected) {
      //   try {
      //     GoodsReceiptPurchaseItemDetailModel?
      //     goodsReceiptPurchaseItemDetailModel =
      //         await goodsReceiptsRemoteDataSource
      //             .goodsReceiptGetLabelDetailById(dtId, hdId, itemId);
      //     return right(goodsReceiptPurchaseItemDetailModel?.toEntity());
      //   } catch (e) {
      //     return left(
      //       GoodsReceiptsServerFailure(code: "", message: e.toString()),
      //     );
      //   }
      // } else {
      GoodsReceiptPurchaseItemDetailModel? goodsReceiptPurchaseItemDetailModel =
          await goodsReceiptsLocalDataSource.goodsReceiptGetLabelDetailById(
            dtId,
            hdId,
            itemId,
          );
      return right(goodsReceiptPurchaseItemDetailModel?.toEntity());
      // }
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsDetailUpdateLabelException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsDetailUpdateLabelException(),
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, GoodsReceiptPurchaseOrderLineItemEntity>>
  goodsReceiptCreateLabelSaveDetail(
    GoodsReceiptPurchaseOrderLineItemEntity
    goodsReceiptPurchaseOrderLineItemEntity,
  ) async {
    // try {
    GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailModel =
        await goodsReceiptsLocalDataSource.goodsReceiptCreateLabelSaveDetail(
          GoodsReceiptPurchaseItemDetailModel.fromEntity(
            goodsReceiptPurchaseOrderLineItemEntity,
          ),
        );
    return right(goodsReceiptPurchaseItemDetailModel.toEntity());
    // } on DatabaseException catch (e) {
    //   return _errorFun(
    //     errorCode: AppErrorCodes.grnDbSaveError,
    //     message: e.toString(),
    //     exceptions: GoodsReceiptsCreateLabelSaveException(),
    //   );
    // } catch (e) {
    //   return _errorFun(
    //     errorCode: AppErrorCodes.grnDbSaveError,
    //     message: e.toString(),
    //     exceptions: GoodsReceiptsCreateLabelSaveException(),
    //   );
    // }
  }

  @override
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptsTransactionEntity>>>
  filterTransactionList({
    required TransactionFilterEntity transactionFilterEntity,
  }) async {
    try {
      // final List<GoodsReceiptsTransactionModel> transactionModel =
      //     await goodsReceiptsLocalDataSource.filterTransactionList(
      //       transactionFilterModel: TransactionFilterModel.fromEntity(
      //         transactionFilterEntity,
      //       ),
      //     );
      // final List<GoodsReceiptsTransactionEntity> transactionEntityList =
      //     transactionModel.map((e) => e.toEntity()).toList();
      return right([]);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnTransactionFetchFailed,
        message: e.toString(),
        exceptions: GoodsReceiptsGetAllDbException(),
      );
    } catch (e) {
      log(e.toString());
      return _errorFun(
        errorCode: AppErrorCodes.grnTransactionFetchFailed,
        message: e.toString(),
        exceptions: GoodsReceiptsGetAllDbException(),
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptLabelAttachmentEntity>>>
  getGoodsReceiptLabelAttachmentList(
    GoodsReceiptPurchaseOrderLineItemEntity
    goodsReceiptPurchaseOrderLineItemEntity,
  ) async {
    try {
      List<GoodsReceiptLabelAttachmentModel> goodsReceiptLabelAttachmentList =
          await goodsReceiptsLocalDataSource.getGoodsReceiptLabelAttachments(
            GoodsReceiptPurchaseItemDetailModel.fromEntity(
              goodsReceiptPurchaseOrderLineItemEntity,
            ),
          );

      return right(goodsReceiptLabelAttachmentList);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetLabelAttachmentsException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsInsertLabelAttachmentException(),
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptLabelAttachmentEntity>>>
  insertCapturedOrSelectedMediaLabelAttachments(
    List<GoodsReceiptLabelAttachmentEntity>
    goodsReceiptLabelAttachmentEntityList,
  ) async {
    try {
      List<GoodsReceiptLabelAttachmentModel> goodsReceiptLabelAttachmentList =
          await goodsReceiptsLocalDataSource
              .insertCapturedOrSelectedMediaLabelAttachments(
                GoodsReceiptLabelAttachmentModel.fromEntityList(
                  goodsReceiptLabelAttachmentEntityList,
                ),
              );
      return right(goodsReceiptLabelAttachmentList);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsInsertLabelAttachmentException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsInsertLabelAttachmentException(),
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptIhmAttachmentEntity>>>
  getGoodsReceiptIhmAttachmentList(String itemId) async {
    try {
      List<GoodsReceiptIhmAttachmentModel> goodsReceiptIhmAttachmentList =
          await goodsReceiptsLocalDataSource.getGoodsReceiptIhmAttachments(
            itemId,
          );

      return right(goodsReceiptIhmAttachmentList);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetIhmAttachmentsException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetIhmAttachmentsException(),
      );
    }
  }

  @override
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseItemDetailEntity>>
  >
  getPOItemListForSelectedGRNTransaction(int poId) async {
    try {
      // if (await connectivityManager.isConnected) {
      //   try {
      //     final List<GoodsReceiptTransactionItemDetailModel>
      //     goodsReceiptTransactionItemDetailModelList =
      //         await goodsReceiptsRemoteDataSource.getAllGrnTransactionItems(
      //           poId,
      //         );
      //     final List<GoodsReceiptPurchaseItemDetailEntity>
      //     goodsReceiptPurchaseItemDetailEntityList =
      //         goodsReceiptTransactionItemDetailModelList
      //             .map((e) => e.toEntity())
      //             .toList();
      //     return right(goodsReceiptPurchaseItemDetailEntityList);
      //   } catch (e) {
      //     return left(
      //       GoodsReceiptsServerFailure(code: "", message: e.toString()),
      //     );
      //   }
      // }
      // else {
      // List<GoodsReceiptTransactionItemDetailModel>
      // goodsReceiptTransactionItemDetailModelList =
      //     await goodsReceiptsLocalDataSource
      //         .getPOItemListForSelectedGRNTransaction(poId);

      // final List<GoodsReceiptPurchaseItemDetailEntity>
      // goodsReceiptPurchaseItemDetailEntityList =
      //     goodsReceiptTransactionItemDetailModelList
      //         .map((e) => e.toEntity())
      //         .toList();
      return right([]);
      // }
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetAllTransactionDetailException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetAllTransactionDetailException(),
      );
    }
  }

  //Stock Location

  //Storage Location
  //Split Location

  @override
  Future<Either<GoodsReceiptsFailures, Unit>> updateStockLocationByItemId(
    int itemId,
  ) async {
    try {
      await goodsReceiptsLocalDataSource.updateStockLocationByItemId(itemId);
      await goodsReceiptsLocalDataSource.getPacketDetailsData();
      return right(unit);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: StockLocationUpdateException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: StockLocationUpdateException(),
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, List<SplitLocationEntity>>>
  getSplitLocationByPurchaseItemDetail(
    GoodsReceiptPurchaseOrderLineItemEntity
    goodsReceiptPurchaseOrderLineItemEntity,
  ) async {
    try {
      // List<SplitLocationData> splitLocationModelList =
      //     await goodsReceiptsLocalDataSource
      //         .getSplitLocationByPurchaseItemDetail(
      //           GoodsReceiptPurchaseItemDetailModel.fromEntity(
      //             goodsReceiptPurchaseOrderLineItemEntity,
      //           ),
      //         );
      //
      // List<SplitLocationEntity> splitLocationEntityList =
      //     splitLocationModelList.map((e) => e.toEntity()).toList();
      // return right(splitLocationEntityList);
      return right([]);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GetSplitLocationException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GetSplitLocationException(),
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, Unit>> insertOrUpdateSplitLocationEntity(
    List<SplitLocationEntity> splitLocationEntityList,
  ) async {
    try {
      await goodsReceiptsLocalDataSource.insertOrUpdateSplitLocationList(
        SplitLocationData.fromEntityList(splitLocationEntityList),
      );
      return right(unit);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: InsertOrUpdateSplitLocationException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: InsertOrUpdateSplitLocationException(),
      );
    }
  }

  @override
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  deleteGoodsReceiptsLabelItemById(
    GoodsReceiptPurchaseOrderLineItemEntity
    goodsReceiptPurchaseOrderLineItemEntity,
  ) async {
    try {
      List<GoodsReceiptPurchaseItemDetailModel>
      goodsReceiptPurchaseItemDetailModelList =
          await goodsReceiptsLocalDataSource.deleteGoodsReceiptsLabelItemById(
            GoodsReceiptPurchaseItemDetailModel.fromEntity(
              goodsReceiptPurchaseOrderLineItemEntity,
            ),
          );
      List<GoodsReceiptPurchaseOrderLineItemEntity>
      goodsReceiptPurchaseOrderLineItemEntityList =
          goodsReceiptPurchaseItemDetailModelList
              .map((e) => e.toEntity())
              .toList();
      return right(goodsReceiptPurchaseOrderLineItemEntityList);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: DeleteGoodsReceiptLabelItemException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: DeleteGoodsReceiptLabelItemException(),
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, List<SplitLocationEntity>>>
  deleteSplitStorageLocationItemById(
    SplitLocationEntity splitLocationEntity,
    GoodsReceiptPurchaseOrderLineItemEntity
    goodsReceiptPurchaseOrderLineItemEntity,
  ) async {
    try {
      List<SplitLocationData> splitLocationModelList =
          await goodsReceiptsLocalDataSource.deleteSplitStorageLocationItemById(
            SplitLocationData.fromEntity(splitLocationEntity),
            GoodsReceiptPurchaseItemDetailModel.fromEntity(
              goodsReceiptPurchaseOrderLineItemEntity,
            ),
          );
      List<SplitLocationEntity> splitLocationEntityList =
          splitLocationModelList.map((e) => e.toEntity()).toList();
      return right(splitLocationEntityList);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: DeleteSplitLocationItemException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: DeleteSplitLocationItemException(),
      );
    }
  }

  //Packet Details
  //BaggingTagging BT packet

  @override
  Future<Either<GoodsReceiptsFailures, List<PacketDetailsEntity>>>
  getPacketDetailsByPoId({required String grnId}) async {
    // try {
    List<PacketDetailsModel> packetDetailsList =
        await goodsReceiptsLocalDataSource.getPacketDetailsByPoId(grnId: grnId);
    final List<PacketDetailsEntity> list =
        packetDetailsList.map((e) => e.toEntity()).toList();

    return right(list);
    // return right(packetDetailsList);
    // } on DatabaseException catch (e) {
    //   return _errorFun(
    //     errorCode: AppErrorCodes.grnDbFetchError,
    //     message: e.toString(),
    //     exceptions: GoodsReceiptsInsertLabelAttachmentException(),
    //   );
    // } catch (e) {
    //   return _errorFun(
    //     errorCode: AppErrorCodes.grnDbFetchError,
    //     message: e.toString(),
    //     exceptions: GoodsReceiptsInsertLabelAttachmentException(),
    //   );
    // }
  }

  @override
  Future<Either<GoodsReceiptsFailures, List<StorageLocationEntity>>>
  getAllStorageLocations() async {
    try {
      List<StorageLocationModel> storageLocationModelList =
          await goodsReceiptsLocalDataSource.getAllStorageLocations();
      List<StorageLocationEntity> storageLocationEntityList =
          storageLocationModelList.map((e) => e.toEntity()).toList();
      return right(storageLocationEntityList);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.storageLocationListLoadFail,
        message: e.toString(),
        exceptions: GetAllStorageLocationException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.storageLocationListLoadFail,
        message: e.toString(),
        exceptions: GetAllStorageLocationException(),
      );
    }
  }

  @override
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseItemDetailEntity>>
  >
  getAllGrnTransactionItems() async {
    try {
      // if (await connectivityManager.isConnected) {
      // try {
      //   final List<GoodsReceiptTransactionItemDetailModel>
      //   goodsReceiptTransactionItemDetailModelList =
      //       await goodsReceiptsRemoteDataSource.getAllGrnTransactionItems(0);
      //   final List<GoodsReceiptPurchaseItemDetailEntity>
      //   goodsReceiptPurchaseItemDetailEntityList =
      //       goodsReceiptTransactionItemDetailModelList
      //           .map((e) => e.toEntity())
      //           .toList();
      //   return right(goodsReceiptPurchaseItemDetailEntityList);
      // } catch (e) {
      //   return left(
      //     GoodsReceiptsServerFailure(code: "", message: e.toString()),
      //   );
      // }
      // } else {
      // List<GoodsReceiptTransactionItemDetailModel>
      // goodsReceiptTransactionItemDetailModelList =
      //     await goodsReceiptsLocalDataSource.getAllGrnTransactionItems();

      // final List<GoodsReceiptPurchaseItemDetailEntity>
      // goodsReceiptPurchaseItemDetailEntityList =
      //     goodsReceiptTransactionItemDetailModelList
      //         .map((e) => e.toEntity())
      //         .toList();
      return right([]);
    } catch (e) {
      log("Eeeeeeee ----> $e");
      return left(GoodsReceiptsServerFailure(code: '12', message: 'aweq'));
    }

    // }
    /* } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetAllTransactionDetailException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetAllTransactionDetailException(),
      );
    }*/
  }

  @override
  Future<Either<GoodsReceiptsFailures, List<PacketDetailsEntity>>>
  goodsReceiptSavePacketDetailList({
    required List<PacketDetailsEntity> packetDetailEntityList,
  }) async {
    try {
      List<PacketDetailsModel> packetDetailsModelList =
          await goodsReceiptsLocalDataSource.goodsReceiptSavePacketDetailList(
            PacketDetailsModel.fromEntityList(packetDetailEntityList),
          );
      final List<PacketDetailsEntity> list =
          packetDetailsModelList.map((e) => e.toEntity()).toList();

      return right(list);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: GoodsReceiptsSavePacketDetailsException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: GoodsReceiptsSavePacketDetailsException(),
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptsTransactionEntity>>>
  searchFromTransactionList({required String query}) async {
    try {
      // final List<GoodsReceiptsTransactionModel> transactionModel =
      //     await goodsReceiptsLocalDataSource.searchFromTransactionList(
      //       query: query,
      //     );
      // final List<GoodsReceiptsTransactionEntity> goodsReceiptsEntityList =
      //     transactionModel.map((e) => e.toEntity()).toList();
      return right([]);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnFetchFailed,
        message: e.toString(),
        exceptions: GoodsReceiptsPendingPoSearchException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnFetchFailed,
        message: e.toString(),
        exceptions: GoodsReceiptsPendingPoSearchException(),
      );
    }
  }

  @override
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  getAllGRLabelItemsToCreateNewLabel({required int poId}) async {
    try {
      if (await connectivityManager.isConnected) {
        try {
          final List<GoodsReceiptPurchaseItemDetailModel>
          goodsReceiptPurchaseItemDetailModelList =
              await goodsReceiptsRemoteDataSource
                  .getAllGRLabelItemsToCreateNewLabel();
          final List<GoodsReceiptPurchaseOrderLineItemEntity>
          goodsReceiptPurchaseOrderLineItemEntityList =
              goodsReceiptPurchaseItemDetailModelList
                  .map((e) => e.toEntity())
                  .toList();
          return right(goodsReceiptPurchaseOrderLineItemEntityList);
        } catch (e) {
          return left(
            GoodsReceiptsServerFailure(code: "", message: e.toString()),
          );
        }
      } else {
        List<GoodsReceiptPurchaseItemDetailModel> goodReceiptDetailLabelList =
            await goodsReceiptsLocalDataSource
                .getAllGRLabelItemsToCreateNewLabel(poId);

        final List<GoodsReceiptPurchaseOrderLineItemEntity>
        goodsReceiptPurchaseOrderLineItemEntityList =
            goodReceiptDetailLabelList.map((e) => e.toEntity()).toList();
        return right(goodsReceiptPurchaseOrderLineItemEntityList);
      }
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetLabelItemsException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetLabelItemsException(),
      );
    }
  }

  @override
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  createNewLabelListToUpdateGRLabelLisWithPoId({
    required List<GoodsReceiptPurchaseOrderLineItemEntity> createNewLabelList,
    required int poId,
  }) async {
    try {
      //TODO need to implement the Api to update newly created Create Label list
      List<GoodsReceiptPurchaseItemDetailModel> goodReceiptDetailLabelList =
          await goodsReceiptsLocalDataSource.getGoodsReceiptDetailLabelItems(
            '$poId',
          );

      final List<GoodsReceiptPurchaseOrderLineItemEntity>
      goodsReceiptsDetailLabelEntityList =
          goodReceiptDetailLabelList.map((e) => e.toEntity()).toList();
      goodsReceiptsDetailLabelEntityList.addAll(createNewLabelList);
      return right(goodsReceiptsDetailLabelEntityList);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetLabelItemsException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetLabelItemsException(),
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptsTransactionEntity>>>
  searchTransactionGrn({required String grnNo}) async {
    try {
      // final List<GoodsReceiptsTransactionModel> transactionModel =
      //     await goodsReceiptsLocalDataSource.searchTransactionGrn(grnNo: grnNo);
      // final List<GoodsReceiptsTransactionEntity> transactionEntityList =
      //     transactionModel.map((e) => e.toEntity()).toList();
      return right([]);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnFetchFailed,
        message: e.toString(),
        exceptions: GoodsReceiptsPendingPoSearchException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnFetchFailed,
        message: e.toString(),
        exceptions: GoodsReceiptsPendingPoSearchException(),
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, List<GRNLocationMappingEntity>>>
  fetchGRNLocationMappingList() async {
    try {
      /// Step 1: Fetch from API
      final List<GRNLocationMappingModel> grnLocationMappingModel =
          await goodsReceiptsRemoteDataSource.fetchGRNLocationMappingList();

      /// Step 2: Convert models to entities
      final List<GRNLocationMappingEntity> grnLocationMappingList =
          grnLocationMappingModel.map((e) => e.toEntity()).toList();

      return right(grnLocationMappingList);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnFetchFailed,
        message: e.toString(),
        exceptions: GoodsReceiptsPendingPoSearchException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnFetchFailed,
        message: e.toString(),
        exceptions: GoodsReceiptsPendingPoSearchException(),
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, List<GRNLocationSerialMappingEntity>>>
  fetchGRNLocationSerialMappingList() async {
    try {
      /// Step 1: Fetch from API
      final List<GRNLocationSerialMappingModel> grnLocationSerialMappingModel =
          await goodsReceiptsRemoteDataSource
              .fetchGRNLocationSerialMappingList();

      /// Step 2: Store API response into DB
      await goodsReceiptsLocalDataSource.insertGRNLocationSerialMappingData(
        grnLocationSerialMappingModel,
      );

      /// Step 3: Fetch back from DB
      final List<GRNLocationSerialMappingModel> dbModels =
          await goodsReceiptsLocalDataSource.getGRNLocationSerialMappingList();

      /// Step 4: Convert DB models to entities
      final List<GRNLocationSerialMappingEntity> grnLocationSerialMappingList =
          dbModels.map((e) => e.toEntity()).toList();

      return right(grnLocationSerialMappingList);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnFetchFailed,
        message: e.toString(),
        exceptions: GoodsReceiptsPendingPoSearchException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnFetchFailed,
        message: e.toString(),
        exceptions: GoodsReceiptsPendingPoSearchException(),
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, List<ItemCategoryConfigEntity>>>
  getItemCategoryConfig() async {
    final List<ItemCategoryConfigModelData> modelList =
        await goodsReceiptsRemoteDataSource.getItemCategoryConfig();
    try {
      final List<ItemCategoryConfigEntity> entityList =
          modelList
              .map(
                (model) => ItemCategoryConfigEntity(
                  itemCategoryId: model.itemCategoryId,
                  propertyId: model.propertyId,
                  propertyCode: model.propertyCode,
                  propertyValue: model.propertyValue,
                ),
              )
              .toList();
      return right(entityList);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetLabelItemsException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetLabelItemsException(),
      );
    }
  }

  @override
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  goodsReceiptGetAllPoLineItemsData() async {
    try {
      // if (await connectivityManager.isConnected) {
      //   await goodsReceiptsRemoteDataSource.getGoodsReceiptDetailLabelItems(
      //     "0",
      //   );
      // }

      final List<GoodsReceiptPurchaseItemDetailModel>
      goodsReceiptsPoLineItemListModelList =
          await goodsReceiptsLocalDataSource
              .goodsReceiptGetAllPoLineItemsData();

      final List<GoodsReceiptPurchaseOrderLineItemEntity>
      goodsReceiptPurchaseOrderLineItemEntityList =
          goodsReceiptsPoLineItemListModelList
              .map((e) => e.toEntity())
              .toList();
      return right(goodsReceiptPurchaseOrderLineItemEntityList);
    } on DatabaseException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.grnPoLineItemsFetchFailed,
        message: e.toString(),
        exceptions: GoodsReceiptsGetAllPoLineItemsException(),
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.grnPoLineItemsFetchFailed,
        message: e.toString(),
        exceptions: GoodsReceiptsGetAllPoLineItemsException(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, List<GRNCreateLabelEntity>>>
  grnCreateLabel(int grnId, List<int> itemIds) async {
    try {
      final List<GRNCreateLabelReportData> grnCreateLabelReportDataList =
          await goodsReceiptsRemoteDataSource.saveGrnCreateLabel(
            grnId,
            itemIds,
          );

      final List<GRNCreateLabelEntity> grnCreateLabelEntityList =
          grnCreateLabelReportDataList.map((e) => e.toEntity()).toList();

      return right(grnCreateLabelEntityList);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetLabelItemsException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetLabelItemsException(),
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, List<ItemRobDetailsEntity>>>
  getItemRobDetails({required int itemID}) async {
    try {
      if (await connectivityManager.isConnected) {
        // fetch remote
        final resultFromRemoteDataSource = await goodsReceiptsRemoteDataSource
            .fetchItemRobDetails(itemID: itemID);

        // insert remote data into local
        await goodsReceiptsLocalDataSource.insertItemRobDetails(
          itemRobDetailsModelData: resultFromRemoteDataSource,
        );

        // read back from local
        final models = await goodsReceiptsLocalDataSource.getItemRobDetails();
        final entities = models.map((m) => m.toEntity()).toList();

        return right(entities);
      } else {
        // offline: read directly from local
        final models = await goodsReceiptsLocalDataSource.getItemRobDetails();
        final entities = models.map((m) => m.toEntity()).toList();

        return right(entities);
      }
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetLabelItemsException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbFetchError,
        message: e.toString(),
        exceptions: GoodsReceiptsGetLabelItemsException(),
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, bool>> saveGoodReceiptsApi(
    SaveGoodsReceiptsParams saveGoodsReceiptsParams,
  ) async {
    try {
      final vesselData =
          await commonLocalDataSource.getAllVesselSpecification();
      Map<String, dynamic> saveApiPayload = {};
      saveApiPayload["StatusCode"] = saveGoodsReceiptsParams.statusType;
      PurchaseOrderHDModel? purchaseOrderHDModel =
          await goodsReceiptsLocalDataSource.goodsReceiptDetailEntity(
            saveGoodsReceiptsParams.purchaseOrderHDEntity.poHdId ?? -1,
          );
      saveApiPayload["GoodsReceiptHD"] =
          purchaseOrderHDModel.toJsonForSaveApi();

      List<GoodsReceiptPurchaseItemDetailModel>
      goodsReceiptPurchaseItemDetailModelList =
          await goodsReceiptsLocalDataSource.getGoodsReceiptDetailLabelItems(
            saveGoodsReceiptsParams.purchaseOrderHDEntity.poHdId.toString(),
          );

      saveApiPayload['GoodsReceiptDT'] =
          goodsReceiptPurchaseItemDetailModelList
              .map((element) => element.toJsonForSaveApi())
              .toList();

      if (purchaseOrderHDModel.poHdId != null) {
        /// poDtId need to be passed as -2 to fetch all the split data by poHdId
        List<PendingPoSplitLocationModel> allSplitLocationData =
            await goodsReceiptsLocalDataSource.getPendingPoSplitLocationData(
              getPendingPoSplitLocationDataParams:
                  GetPendingPoSplitLocationDataParams(
                    poHdId: purchaseOrderHDModel.poHdId!,
                    poDtId: -2,
                  ),
            );
        saveApiPayload['GRNItemLocationMapping'] =
            allSplitLocationData
                .map((element) => element.toJsonForSaveApi())
                .toList();
      }
      // if (goodsReceiptPurchaseItemDetailModelList.isNotEmpty) {
      //   List<SplitLocationModel> allSplitLocationData = [];
      //   Future.forEach(goodsReceiptPurchaseItemDetailModelList, (
      //     element,
      //   ) async {
      //     List<SplitLocationModel> splitLocationModelList =
      //         await goodsReceiptsLocalDataSource
      //             .getSplitLocationByPurchaseItemDetail(element);
      //     allSplitLocationData.addAll(splitLocationModelList);
      //   }).then((_) {
      // saveApiPayload['GRNItemLocationMapping'] =
      //     allSplitLocationData
      //         .map((element) => element.toJsonForSaveApi())
      //         .toList();
      //   });
      // }
      // List<PacketDetailsModel> packetDetailsModelList =
      //     await goodsReceiptsLocalDataSource.getPacketDetailsByPoId(
      //       poId: purchaseOrderHDModel.poId.toString(),
      //     );
      //
      // saveApiPayload["GRNPacketDetail"] =
      //     packetDetailsModelList
      //         .map((element) => element.toJsonForSaveApi())
      //         .toList();
      saveApiPayload["VesselOrOffice"] = "V";
      if (vesselData.isNotEmpty) {
        saveApiPayload["VesselCode"] = vesselData.first.vesselRegID.toString();
      } else {
        saveApiPayload["VesselCode"] = "788";
      }

      saveApiPayload["OrderType"] = "PO";
      saveApiPayload["IsUpdateStock"] = "N";
      saveApiPayload["isBaggingTaggingPendingTab"] = false;
      saveApiPayload["isBagTagCompleted"] = false;
      saveApiPayload["grnhdOtherMapping"] = [];
      saveApiPayload["GRNItemUnitConversionFactorConfigMappers"] = [];
      final apiResponse = await goodsReceiptsRemoteDataSource
          .saveGoodsReceiptApi(payload: saveApiPayload);
      // final result = await commonNetworkDataSource.getSplitLocationData();
      // if (result != null &&
      //     result.reportData != null &&
      //     result.reportData!.isNotEmpty) {
      //   await commonLocalDataSource.insertSplitLocationData(
      //     splitLocationData: result.reportData!,
      //   );
      // }
      final transactionItems = await commonNetworkDataSource.getAllItems();
      if (transactionItems != null &&
          transactionItems.reportData != null &&
          transactionItems.reportData!.isNotEmpty) {}
      return right(false);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnFetchFailed,
        message: e.toString(),
        exceptions: GoodsReceiptsPendingPoSearchException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnFetchFailed,
        message: e.toString(),
        exceptions: GoodsReceiptsPendingPoSearchException(),
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, bool>> saveBaggingAndTagging(
    BaggingAndTaggingParams saveGoodsReceiptsParams,
  ) async {
    try {
      // List<TransactionModel> purchaseOrderHDModel =
      //     await goodsReceiptsLocalDataSource.getAllTransaction();

      // final TransactionModel data = purchaseOrderHDModel.firstWhere(
      //   (element) => element.grnId == saveGoodsReceiptsParams.id,
      //   orElse: TransactionModel.new,
      // );
      // if (data.grnId == null) {
      //   return right(false);
      // }
      // List<GoodsReceiptTransactionItemDetailModel> transactionItemModelList =
      //     await goodsReceiptsLocalDataSource.getAllGrnTransactionItems();

      // List<GoodsReceiptTransactionItemDetailModel> transactionItem =
      //     transactionItemModelList
      //         .where((element) => element.grnId == data.grnId)
      //         .toList();

      // final json = data.toJsonForSaveApi(
      //   hdModel: data,
      //   transactionModelList: transactionItem,
      // );

      // final apiResponse = await goodsReceiptsRemoteDataSource
      //     .saveGoodsReceiptApi(payload: json);
      return right(false);
    } on DatabaseException catch (e, stackTrace) {
      log(stackTrace.toString());
      return _errorFun(
        errorCode: AppErrorCodes.grnFetchFailed,
        message: e.toString(),
        exceptions: GoodsReceiptsPendingPoSearchException(),
      );
    } catch (e, stackTrace) {
      log(stackTrace.toString());
      return _errorFun(
        errorCode: AppErrorCodes.grnFetchFailed,
        message: e.toString(),
        exceptions: GoodsReceiptsPendingPoSearchException(),
      );
    }
  }

  @override
  Future<
    Either<GoodsReceiptsFailures, GoodsReceiptPurchaseOrderLineItemEntity?>
  >
  getPoItemDetails({
    required GetPoItemDetailsParams getPoItemDetailsParams,
  }) async {
    try {
      return right(null);
      // GoodsReceiptPurchaseItemDetailModel poItemDetailModel =
      //     await goodsReceiptsLocalDataSource.getPoItemDetails(getPoItemDetailsParams: getPoItemDetailsParams);
    } on DatabaseException catch (e, stackTrace) {
      log(stackTrace.toString());
      return _errorFun(
        errorCode: AppErrorCodes.grnFetchFailed,
        message: e.toString(),
        exceptions: GoodsReceiptsPendingPoSearchException(),
      );
    } catch (e, stackTrace) {
      log(stackTrace.toString());
      return _errorFun(
        errorCode: AppErrorCodes.grnFetchFailed,
        message: e.toString(),
        exceptions: GoodsReceiptsPendingPoSearchException(),
      );
    }
  }

  @override
  Future<Either<GoodsReceiptsFailures, List<SplitLocationEntity>>>
  getPendingPoSplitLocationData({
    required GetPendingPoSplitLocationDataParams
    getPendingPoSplitLocationDataParams,
  }) async {
    try {
      List<PendingPoSplitLocationModel> pendingPoSplitLocationData =
          await goodsReceiptsLocalDataSource.getPendingPoSplitLocationData(
            getPendingPoSplitLocationDataParams:
                getPendingPoSplitLocationDataParams,
          );
      return right(
        pendingPoSplitLocationData.map((e) => e.toEntity()).toList(),
      );
    } on DatabaseException catch (e, stackTrace) {
      log(stackTrace.toString());
      return _errorFun(
        errorCode: AppErrorCodes.grnFetchFailed,
        message: e.toString(),
        exceptions: GoodsReceiptsPendingPoSearchException(),
      );
    } catch (e, stackTrace) {
      log(stackTrace.toString());
      return _errorFun(
        errorCode: AppErrorCodes.grnFetchFailed,
        message: e.toString(),
        exceptions: GoodsReceiptsPendingPoSearchException(),
      );
    }
  }
}
