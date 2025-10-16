import 'package:fpdart/fpdart.dart';

import '../../entities/goods_receipt_transaction_entity.dart';
import '../../entities/transaction_filter_entity.dart';
import '../../failures/goods_receipts_failures.dart';
import '../../repository/goods_receipts_repository.dart';

abstract interface class GetAllGoodsReceiptTransactionUseCase {
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptsTransactionEntity>>>
  call({TransactionFilterEntity? filter});
}

class GetAllGoodsReceiptTransactionUseCaseImpl
    implements GetAllGoodsReceiptTransactionUseCase {
  GetAllGoodsReceiptTransactionUseCaseImpl({
    required this.goodsReceiptsRepository,
  });

  final GoodsReceiptsRepository goodsReceiptsRepository;
  @override
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptsTransactionEntity>>>
  call({TransactionFilterEntity? filter}) {
    return goodsReceiptsRepository.getAllTransactions(filter: filter);
  }
}
