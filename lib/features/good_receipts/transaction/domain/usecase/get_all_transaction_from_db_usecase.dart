import 'package:fpdart/fpdart.dart';

import '../../../domain/entities/transaction_filter_entity.dart';
import '../entity/transaction_entity.dart';
import '../failure/transaction_failures.dart';
import '../repository/transaction_repository.dart';

abstract interface class GetAllTransactionFromDbUsecase {
  Future<Either<TransactionFailures, List<TransactionEntity>>> call({
    TransactionFilterEntity? transactionFilterEntity,
  });
}

class GetAllTransactionFromDbUsecaseImpl
    implements GetAllTransactionFromDbUsecase {
  GetAllTransactionFromDbUsecaseImpl({required this.transactionRepository});

  final TransactionRepository transactionRepository;
  @override
  Future<Either<TransactionFailures, List<TransactionEntity>>> call({
    TransactionFilterEntity? transactionFilterEntity,
  }) {
    return transactionRepository.getTransactionFromDb(
      transactionFilterEntity: transactionFilterEntity,
    );
  }
}
