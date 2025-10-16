import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../../core/error/error_codes.dart';
import '../../../../../core/service/other_service/file_logger_service.dart';
import '../../../../../core/utils/app_logger.dart';
import '../../../../common_feature/domain/entities/item_entity.dart';
import '../../domain/failures/transaction_detail_failures.dart';
import '../../domain/repository/transaction_detail_repository.dart';
import '../../domain/use_cases/get_transaction_items_db_usecase.dart';
import '../data_source/transaction_detail_local_data_source.dart';
import '../exceptions/transaction_detail_exceptions.dart';

class TransactionDetailRepositoryImpl implements TransactionDetailRepository {
  TransactionDetailRepositoryImpl({
    required this.transactionDetailLocalDataSource,
    required this.appLogger,
    required this.fileLoggerService,
  });

  final TransactionDetailLocalDataSource transactionDetailLocalDataSource;
  final AppLogger appLogger;
  final FileLoggerService fileLoggerService;

  Either<TransactionDetailFailures, T> _errorFun<T>({
    required String errorCode,
    required String message,
    required TransactionDetailExceptions exceptions,
  }) {
    appLogger.error(errorCode, message);
    fileLoggerService.logToFile(logText: errorCode, pageType: message);

    switch (exceptions) {
      case TransactionDetailServerException():
        return left(
          TransactionDetailNetworkFailure(code: errorCode, message: message),
        );
      case TransactionDetailDbException():
        return left(
          TransactionDetailDbExceptionFailure(
            code: errorCode,
            message: message,
          ),
        );
      case TransactionDetailUnknowException():
        return left(
          TransactionDetailUnknownFailure(code: errorCode, message: message),
        );
    }
  }

  @override
  Future<Either<TransactionDetailFailures, List<ItemEntity>>>
  getTransactionItemsFromDb({required GetTransactionItemsParams params}) async {
    try {
      debugPrint('getTransactionItemsFromDb grnId : ${params.grnId}');
      final transactionOrderItems = await transactionDetailLocalDataSource
          .getTransactionItems(grnId: params.grnId);
      return right(
        transactionOrderItems.map((element) {
          return element.toEntity();
        }).toList(),
      );
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.purchaseOrderListFetchFailed,
        message: e.toString(),
        exceptions: TransactionDetailDbException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: TransactionDetailUnknowException(),
      );
    }
  }
}
