part of 'goods_receipt_attachment_bloc.dart';

sealed class GoodsReceiptAttachmentEvent extends Equatable {
  const GoodsReceiptAttachmentEvent();

  @override
  List<Object> get props => [];
}

class InsertGoodsReceiptsAttachmentEvent extends GoodsReceiptAttachmentEvent{}

class GetGoodsReceiptsAttachmentEvent extends GoodsReceiptAttachmentEvent{
  final int poId;
  GetGoodsReceiptsAttachmentEvent(this.poId);
}

class InsertCapturedOrSelectedAttachmentEvent extends GoodsReceiptAttachmentEvent{
  InsertCapturedOrSelectedAttachmentEvent(this.goodsReceiptAttachmentEntityList);

  List<GoodsReceiptAttachmentEntity> goodsReceiptAttachmentEntityList;
}



