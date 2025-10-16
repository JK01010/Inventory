import 'package:fpdart/fpdart.dart';

import '../entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class GoodsReceiptCreateLabelGetLabelDetailUseCase {
  Future<
    Either<GoodsReceiptsFailures, GoodsReceiptPurchaseOrderLineItemEntity?>
  >
  getGoodsReceiptLabelDetail(int dtId, int hdId, int itemId);
}

class GoodsReceiptCreateLabelGetLabelDetailUseCaseImpl
    implements GoodsReceiptCreateLabelGetLabelDetailUseCase {
  GoodsReceiptCreateLabelGetLabelDetailUseCaseImpl({
    required this.goodsReceiptsRepository,
  });

  final GoodsReceiptsRepository goodsReceiptsRepository;

  @override
  Future<
    Either<GoodsReceiptsFailures, GoodsReceiptPurchaseOrderLineItemEntity?>
  >
  getGoodsReceiptLabelDetail(int dtId, int hdId, int itemId) {
    return goodsReceiptsRepository.goodsReceiptGetLabelDetailById(
      dtId,
      hdId,
      itemId,
    );
  }
}
