part of 'goods_receipt_label_ihm_attachment_bloc.dart';

class GoodsReceiptLabelIhmAttachmentState extends Equatable {
  GoodsReceiptLabelIhmAttachmentState({
    required this.goodsReceiptIhmAttachmentEntityList,
    required this.isLoading,
    required this.goodsReceiptsFailure
  });

  factory GoodsReceiptLabelIhmAttachmentState.initial() => GoodsReceiptLabelIhmAttachmentState(
    goodsReceiptIhmAttachmentEntityList: [],
    isLoading: false,
    goodsReceiptsFailure: none()
  );

  List<GoodsReceiptIhmAttachmentEntity> goodsReceiptIhmAttachmentEntityList;
  final bool isLoading;
  final Option<GoodsReceiptsFailures> goodsReceiptsFailure;

  @override
  List<Object?> get props => [
    goodsReceiptIhmAttachmentEntityList,
    isLoading,
    goodsReceiptsFailure
  ];

  GoodsReceiptLabelIhmAttachmentState copyWith({
    List<GoodsReceiptIhmAttachmentEntity>? goodsReceiptIhmAttachmentEntityList,
    bool? isLoading,
    Option<GoodsReceiptsFailures>? goodsReceiptFailure
  }){
    return GoodsReceiptLabelIhmAttachmentState(
        goodsReceiptIhmAttachmentEntityList: goodsReceiptIhmAttachmentEntityList??this.goodsReceiptIhmAttachmentEntityList,
        isLoading: isLoading??this.isLoading,
        goodsReceiptsFailure: goodsReceiptsFailure??this.goodsReceiptsFailure);
  }
}

