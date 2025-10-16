import 'package:fpdart/fpdart.dart';

import '../entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class UpdateGoodsReceiptDetailLabelListUseCase {
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  call(
    List<GoodsReceiptPurchaseOrderLineItemEntity>
    goodsReceiptPurchaseOrderLineItemEntityList,
  );
}

class UpdateGoodsReceiptDetailLabelListUseCaseImpl
    implements UpdateGoodsReceiptDetailLabelListUseCase {
  UpdateGoodsReceiptDetailLabelListUseCaseImpl({
    required this.goodsReceiptsRepository,
  });

  final GoodsReceiptsRepository goodsReceiptsRepository;

  @override
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  call(
    List<GoodsReceiptPurchaseOrderLineItemEntity>
    goodsReceiptPurchaseOrderLineItemEntityList,
  ) {
    return goodsReceiptsRepository.updateGoodsReceiptsDetailLabelList(
      goodsReceiptPurchaseOrderLineItemEntityList,
    );
  }
}
