part of 'goods_receipt_label_attachment_item_bloc.dart';

sealed class GoodsReceiptLabelAttachmentItemEvent extends Equatable {
  const GoodsReceiptLabelAttachmentItemEvent();

  @override
  List<Object> get props => [];
}

class GetGoodsReceiptLabelAttachmentItemEvent
    extends GoodsReceiptLabelAttachmentItemEvent {
  const GetGoodsReceiptLabelAttachmentItemEvent(
    this.goodsReceiptPurchaseOrderLineItemEntity,
  );

  final GoodsReceiptPurchaseOrderLineItemEntity
  goodsReceiptPurchaseOrderLineItemEntity;
}

class InsertCapturedOrSelectedLabelAttachmentEvent
    extends GoodsReceiptLabelAttachmentItemEvent {
  InsertCapturedOrSelectedLabelAttachmentEvent(
    this.goodsReceiptLabelAttachmentEntityList,
  );

  List<GoodsReceiptLabelAttachmentEntity> goodsReceiptLabelAttachmentEntityList;
}
