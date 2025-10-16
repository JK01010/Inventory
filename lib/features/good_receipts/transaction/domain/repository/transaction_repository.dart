import 'package:fpdart/fpdart.dart';

import '../../../domain/entities/transaction_filter_entity.dart';
import '../entity/transaction_entity.dart';
import '../failure/transaction_failures.dart';

abstract interface class TransactionRepository {
  Future<Either<TransactionFailures, Unit>> getTransactionFromApi();
  Future<Either<TransactionFailures, List<TransactionEntity>>>
  getTransactionFromDb({
    TransactionFilterEntity? transactionFilterEntity,
  });
}
