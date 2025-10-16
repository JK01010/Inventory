import 'package:fpdart/fpdart.dart';

import '../failure/transaction_failures.dart';
import '../repository/transaction_repository.dart';

abstract interface class GetAllTransactionFromApiUseCase {
  Future<Either<TransactionFailures, Unit>> call();
}

class GetAllTransactionFromApiUseCaseImpl
    implements GetAllTransactionFromApiUseCase {
  GetAllTransactionFromApiUseCaseImpl({required this.transactionRepository});

  final TransactionRepository transactionRepository;
  @override
  Future<Either<TransactionFailures, Unit>> call() {
    return transactionRepository.getTransactionFromApi();
  }
}
