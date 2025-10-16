import 'package:fpdart/fpdart.dart';

import '../../entities/goods_receipt_transaction_entity.dart';
import '../../entities/transaction_filter_entity.dart';
import '../../failures/goods_receipts_failures.dart';
import '../../repository/goods_receipts_repository.dart';

abstract interface class FilterTransactionListUseCase {
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptsTransactionEntity>>>
  call({required TransactionFilterEntity transactionFilterEntity});
}

class FilterTransactionListUseCaseImpl implements FilterTransactionListUseCase {
  FilterTransactionListUseCaseImpl({required this.goodsReceiptsRepository});

  final GoodsReceiptsRepository goodsReceiptsRepository;
  @override
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptsTransactionEntity>>>
  call({required TransactionFilterEntity transactionFilterEntity}) {
    return goodsReceiptsRepository.filterTransactionList(
      transactionFilterEntity: transactionFilterEntity,
    );
  }
}
