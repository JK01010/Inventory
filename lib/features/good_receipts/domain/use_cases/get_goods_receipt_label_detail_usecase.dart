import 'package:fpdart/fpdart.dart';

import '../entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class GetGoodsReceiptLabelDetailUseCase {
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  getGoodsReceiptDetailLabelItems(String poId);
}

class GetGoodsReceiptLabelDetailUseCaseImpl
    implements GetGoodsReceiptLabelDetailUseCase {
  GetGoodsReceiptLabelDetailUseCaseImpl({
    required this.goodsReceiptsRepository,
  });

  final GoodsReceiptsRepository goodsReceiptsRepository;

  @override
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  getGoodsReceiptDetailLabelItems(String poId) {
    return goodsReceiptsRepository.getGoodsReceiptDetailLabelItems(poId);
  }
}
