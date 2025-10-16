import 'package:fpdart/fpdart.dart';

import '../failures/transaction_item_detail_failure.dart';
import '../repository/transaction_item_detail_repository.dart';

abstract interface class GetAllTransactionItemDetailUsecase {
  Future<Either<TransactionItemDetailFailure, Unit>> call();
}

class GetAllTransactionItemDetailUsecaseImpl
    implements GetAllTransactionItemDetailUsecase {
  GetAllTransactionItemDetailUsecaseImpl({
    required this.transactionItemDetailRepository,
  });

  final TransactionItemDetailRepository transactionItemDetailRepository;
  @override
  Future<Either<TransactionItemDetailFailure, Unit>> call() async {
    return transactionItemDetailRepository.getAllTransactionItemDetailFromApi();
  }
}
