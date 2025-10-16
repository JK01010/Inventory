import 'package:fpdart/fpdart.dart';

import '../../entities/goods_receipt_transaction_entity.dart';
import '../../failures/goods_receipts_failures.dart';
import '../../repository/goods_receipts_repository.dart';

abstract interface class SearchTransactionGrnUsecase {
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptsTransactionEntity>>>
  call({required String query});
}

class SearchTransactionGrnUsecaseImpl implements SearchTransactionGrnUsecase {
  SearchTransactionGrnUsecaseImpl({required this.goodsReceiptsRepository});

  final GoodsReceiptsRepository goodsReceiptsRepository;
  @override
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptsTransactionEntity>>>
  call({required String query}) {
    return goodsReceiptsRepository.searchTransactionGrn(grnNo: query);
  }
}
