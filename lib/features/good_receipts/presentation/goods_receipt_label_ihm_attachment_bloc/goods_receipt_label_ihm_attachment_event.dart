part of 'goods_receipt_label_ihm_attachment_bloc.dart';

sealed class GoodsReceiptLabelIhmAttachmentEvent extends Equatable {
  const GoodsReceiptLabelIhmAttachmentEvent();

  @override
  List<Object?> get props => [];
}

class GetGoodsReceiptLabelIhmAttachmentEvent extends GoodsReceiptLabelIhmAttachmentEvent{

  const GetGoodsReceiptLabelIhmAttachmentEvent({required this.itemId});
  final String itemId;
}
