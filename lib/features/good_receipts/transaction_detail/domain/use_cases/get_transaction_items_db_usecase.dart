import 'package:fpdart/fpdart.dart';
import '../../../../common_feature/domain/entities/item_entity.dart';
import '../failures/transaction_detail_failures.dart';
import '../repository/transaction_detail_repository.dart';

abstract interface class GetTransactionItemsDbUseCase {
  Future<Either<TransactionDetailFailures, List<ItemEntity>>> call({
    required GetTransactionItemsParams params,
  });
}

class GetTransactionItemsDbUseCaseImpl implements GetTransactionItemsDbUseCase {
  GetTransactionItemsDbUseCaseImpl({
    required TransactionDetailRepository transactionDetailRepository,
  }) : _transactionDetailRepository = transactionDetailRepository;

  final TransactionDetailRepository _transactionDetailRepository;

  @override
  Future<Either<TransactionDetailFailures, List<ItemEntity>>> call({
    required GetTransactionItemsParams params,
  }) async {
    return _transactionDetailRepository.getTransactionItemsFromDb(
      params: params,
    );
  }
}

class GetTransactionItemsParams {
  GetTransactionItemsParams({required this.grnId});

  final int grnId;
}
