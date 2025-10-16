import 'package:fpdart/fpdart.dart';

import '../../entities/goods_receipt_transaction_entity.dart';
import '../../failures/goods_receipts_failures.dart';
import '../../repository/goods_receipts_repository.dart';

abstract interface class SyncTransactionListUseCase {
  Future<Either<GoodsReceiptsFailures, Unit>> call({
    required List<GoodsReceiptsTransactionEntity> transactionItemList,
  });
}

class SyncTransactionListUseCaseImpl implements SyncTransactionListUseCase {
  SyncTransactionListUseCaseImpl({required this.goodsReceiptsRepository});

  final GoodsReceiptsRepository goodsReceiptsRepository;
  @override
  Future<Either<GoodsReceiptsFailures, Unit>> call({
    required List<GoodsReceiptsTransactionEntity> transactionItemList,
  }) {
    return goodsReceiptsRepository.syncTransactionList(
      transactionEntityItem: transactionItemList,
    );
  }
}
