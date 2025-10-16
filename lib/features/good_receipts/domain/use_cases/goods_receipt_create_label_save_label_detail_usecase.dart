import 'package:fpdart/fpdart.dart';

import '../entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class GoodsReceiptCreateLabelSaveLabelDetailUseCase {
  Future<Either<GoodsReceiptsFailures, GoodsReceiptPurchaseOrderLineItemEntity>>
  goodsReceiptCreateLabelSaveDetail(
    GoodsReceiptPurchaseOrderLineItemEntity
    goodsReceiptPurchaseOrderLineItemEntity,
  );
}

class GoodsReceiptCreateLabelSaveLabelDetailUseCaseImpl
    implements GoodsReceiptCreateLabelSaveLabelDetailUseCase {
  GoodsReceiptCreateLabelSaveLabelDetailUseCaseImpl({
    required this.goodsReceiptsRepository,
  });

  final GoodsReceiptsRepository goodsReceiptsRepository;

  @override
  Future<Either<GoodsReceiptsFailures, GoodsReceiptPurchaseOrderLineItemEntity>>
  goodsReceiptCreateLabelSaveDetail(
    GoodsReceiptPurchaseOrderLineItemEntity
    goodsReceiptPurchaseOrderLineItemEntity,
  ) {
    return goodsReceiptsRepository.goodsReceiptCreateLabelSaveDetail(
      goodsReceiptPurchaseOrderLineItemEntity,
    );
  }
}
