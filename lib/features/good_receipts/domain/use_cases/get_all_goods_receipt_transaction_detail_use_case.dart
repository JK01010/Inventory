import 'package:fpdart/fpdart.dart';

import '../entities/goods_receipt_purchase_item_detail_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class GetAllGoodsReceiptTransactionDetailUseCase {
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseItemDetailEntity>>
  >
  call(int poId);
}

class GetAllGoodsReceiptTransactionDetailUseCaseImpl
    implements GetAllGoodsReceiptTransactionDetailUseCase {
  GetAllGoodsReceiptTransactionDetailUseCaseImpl({
    required this.goodsReceiptsRepository,
  });

  final GoodsReceiptsRepository goodsReceiptsRepository;

  @override
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseItemDetailEntity>>
  >
  call(int poId) {
    return goodsReceiptsRepository.getPOItemListForSelectedGRNTransaction(poId);
  }
}
