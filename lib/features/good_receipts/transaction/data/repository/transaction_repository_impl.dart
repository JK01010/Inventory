import 'dart:developer';

import 'package:fpdart/fpdart.dart';

import '../../../data/models/transaction_filter_model.dart';
import '../../../domain/entities/transaction_filter_entity.dart';
import '../../domain/entity/transaction_entity.dart';
import '../../domain/failure/transaction_failures.dart';
import '../../domain/repository/transaction_repository.dart';
import '../data_source/transaction_local_data_source.dart';
import '../data_source/transaction_remote_data_source.dart';
import '../model/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  TransactionRepositoryImpl({
    required this.transactionRemoteDataSource,
    required this.transactionLocalDataSource,
  });

  final TransactionRemoteDataSource transactionRemoteDataSource;
  final TransactionLocalDataSource transactionLocalDataSource;
  @override
  Future<Either<TransactionFailures, Unit>> getTransactionFromApi() async {
    try {
      final List<TransactionModel> transactionData =
          await transactionRemoteDataSource.getAllTransactions();

      await transactionLocalDataSource.insertTransaction(
        transactionModelList: transactionData,
      );

      return right(unit);
    } catch (e) {
      return left(TransactionServerFailure());
    }
  }

  @override
  Future<Either<TransactionFailures, List<TransactionEntity>>>
  getTransactionFromDb({
    TransactionFilterEntity? transactionFilterEntity,
  }) async {
    try {
      TransactionFilterModel? transactionFilterModel;
      if (transactionFilterEntity != null) {
        transactionFilterModel = TransactionFilterModel.fromEntity(
          transactionFilterEntity,
        );
      }
      final List<TransactionModel> transactionModelList =
          await transactionLocalDataSource.getAllTransaction(
            filter: transactionFilterModel,
          );
      final List<TransactionEntity> transactionEntityList =
          transactionModelList.map((e) => e.toEntity()).toList();
      return right(transactionEntityList);
    } catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());
      return left(TransactionServerFailure());
    }
  }
}
