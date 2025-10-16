part of 'goods_receipt_label_attachment_item_bloc.dart';

class GoodsReceiptLabelAttachmentItemState extends Equatable {
  GoodsReceiptLabelAttachmentItemState({
    required this.goodsReceiptLabelAttachmentEntityList,
    required this.isLoading,
    required this.goodsReceiptsFailure
  });

  factory GoodsReceiptLabelAttachmentItemState.initial() => GoodsReceiptLabelAttachmentItemState(
      goodsReceiptLabelAttachmentEntityList: [],
      isLoading: false,
      goodsReceiptsFailure: none()
  );

  List<GoodsReceiptLabelAttachmentEntity> goodsReceiptLabelAttachmentEntityList;
  final bool isLoading;
  final Option<GoodsReceiptsFailures> goodsReceiptsFailure;

  @override
  List<Object?> get props => [
    goodsReceiptLabelAttachmentEntityList,
    isLoading,
    goodsReceiptsFailure
  ];

  GoodsReceiptLabelAttachmentItemState copyWith({
    List<GoodsReceiptLabelAttachmentEntity>? goodsReceiptLabelAttachmentEntityList,
    bool? isLoading,
    Option<GoodsReceiptsFailures>? goodsReceiptsFailure
  }){
    return GoodsReceiptLabelAttachmentItemState(
        goodsReceiptLabelAttachmentEntityList: goodsReceiptLabelAttachmentEntityList??this.goodsReceiptLabelAttachmentEntityList,
        isLoading: isLoading??this.isLoading,
        goodsReceiptsFailure: goodsReceiptsFailure??this.goodsReceiptsFailure);
  }
}
