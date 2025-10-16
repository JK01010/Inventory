import 'package:fpdart/fpdart.dart';

import '../../entities/goods_receipt_purchase_item_detail_entity.dart';
import '../../failures/goods_receipts_failures.dart';
import '../../repository/goods_receipts_repository.dart';

abstract interface class GetAllGrnTransactionItemUseCase {
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseItemDetailEntity>>
  >
  call();
}

class GetAllGrnTransactionItemUseCaseImpl
    implements GetAllGrnTransactionItemUseCase {
  GetAllGrnTransactionItemUseCaseImpl({required this.goodsReceiptsRepository});

  final GoodsReceiptsRepository goodsReceiptsRepository;

  @override
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseItemDetailEntity>>
  >
  call() {
    return goodsReceiptsRepository.getAllGrnTransactionItems();
  }
}
