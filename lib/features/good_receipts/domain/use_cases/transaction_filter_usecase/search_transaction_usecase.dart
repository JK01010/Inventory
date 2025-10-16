import 'package:fpdart/fpdart.dart';

import '../../entities/goods_receipt_transaction_entity.dart';
import '../../failures/goods_receipts_failures.dart';
import '../../repository/goods_receipts_repository.dart';

abstract interface class SearchTransactionUsecase {
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptsTransactionEntity>>>
  call({required String query});
}

class SearchTransactionUsecaseImpl implements SearchTransactionUsecase {
  SearchTransactionUsecaseImpl({required this.goodsReceiptsRepository});

  final GoodsReceiptsRepository goodsReceiptsRepository;
  @override
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptsTransactionEntity>>>
  call({required String query}) {
    return goodsReceiptsRepository.searchFromTransactionList(query: query);
  }
}
