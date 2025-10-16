part of 'goods_receipt_attachment_bloc.dart';

class GoodsReceiptAttachmentState extends Equatable {
  GoodsReceiptAttachmentState({
    required this.goodsReceiptAttachmentEntityList,
    required this.isLoading,
    required this.goodsReceiptsFailure
  });

  factory GoodsReceiptAttachmentState.initial() => GoodsReceiptAttachmentState(
      goodsReceiptAttachmentEntityList: [],
      isLoading: false,
      goodsReceiptsFailure: none()
  );

  List<GoodsReceiptAttachmentEntity> goodsReceiptAttachmentEntityList;
  final bool isLoading;
  final Option<GoodsReceiptsFailures> goodsReceiptsFailure;

  @override
  List<Object?> get props => [
    goodsReceiptAttachmentEntityList,
    isLoading,
    goodsReceiptsFailure
  ];

  GoodsReceiptAttachmentState copyWith({
    List<GoodsReceiptAttachmentEntity>? goodsReceiptAttachmentEntityList,
    bool? isLoading,
    Option<GoodsReceiptsFailures>? goodsReceiptsFailure
  }){
      return GoodsReceiptAttachmentState(
          goodsReceiptAttachmentEntityList: goodsReceiptAttachmentEntityList??this.goodsReceiptAttachmentEntityList,
          isLoading: isLoading??this.isLoading,
          goodsReceiptsFailure: goodsReceiptsFailure??this.goodsReceiptsFailure);
  }
}
