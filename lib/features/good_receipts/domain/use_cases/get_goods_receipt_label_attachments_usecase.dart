import 'package:fpdart/fpdart.dart';

import '../entities/goods_receipt_label_attachment_entity.dart';
import '../entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class GetGoodsReceiptLabelAttachmentsUseCase {
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptLabelAttachmentEntity>>>
  getGoodsReceiptLabelAttachmentList(
    GoodsReceiptPurchaseOrderLineItemEntity
    goodsReceiptPurchaseOrderLineItemEntity,
  );
}

class GetGoodsReceiptLabelAttachmentsUseCaseImpl
    implements GetGoodsReceiptLabelAttachmentsUseCase {
  GetGoodsReceiptLabelAttachmentsUseCaseImpl({
    required this.goodsReceiptsRepository,
  });

  final GoodsReceiptsRepository goodsReceiptsRepository;

  @override
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptLabelAttachmentEntity>>>
  getGoodsReceiptLabelAttachmentList(
    GoodsReceiptPurchaseOrderLineItemEntity
    goodsReceiptPurchaseOrderLineItemEntity,
  ) {
    return goodsReceiptsRepository.getGoodsReceiptLabelAttachmentList(
      goodsReceiptPurchaseOrderLineItemEntity,
    );
  }
}
