import 'package:fpdart/fpdart.dart';

import '../entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class DeleteGoodsReceiptsLabelItemByIdUseCase {
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  call(
    GoodsReceiptPurchaseOrderLineItemEntity
    goodsReceiptPurchaseOrderLineItemEntity,
  );
}

class DeleteGoodsReceiptsLabelItemByIdUseCaseImpl
    implements DeleteGoodsReceiptsLabelItemByIdUseCase {
  DeleteGoodsReceiptsLabelItemByIdUseCaseImpl({
    required this.goodsReceiptsRepository,
  });

  final GoodsReceiptsRepository goodsReceiptsRepository;

  @override
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  call(
    GoodsReceiptPurchaseOrderLineItemEntity
    goodsReceiptPurchaseOrderLineItemEntity,
  ) {
    return goodsReceiptsRepository.deleteGoodsReceiptsLabelItemById(
      goodsReceiptPurchaseOrderLineItemEntity,
    );
  }
}
