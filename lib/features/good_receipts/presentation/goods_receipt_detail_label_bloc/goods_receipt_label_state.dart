part of 'goods_receipt_label_bloc.dart';

class GoodsReceiptLabelState extends Equatable {
  GoodsReceiptLabelState({
    required this.goodsReceiptPurchaseOrderLineItemEntityList,
    required this.purchaseItemToCreateNewLabelEntityList,
    required this.grnCreateLabelList,
    required this.isLoading,
    required this.getGoodsReceiptsLabelDetailFailure,
  });

  factory GoodsReceiptLabelState.initial() => GoodsReceiptLabelState(
    goodsReceiptPurchaseOrderLineItemEntityList: [],
    purchaseItemToCreateNewLabelEntityList: [],
    grnCreateLabelList: [],
    isLoading: false,
    getGoodsReceiptsLabelDetailFailure: none(),
  );

  final List<GoodsReceiptPurchaseOrderLineItemEntity>
  goodsReceiptPurchaseOrderLineItemEntityList;

  final List<GoodsReceiptPurchaseOrderLineItemEntity>
  purchaseItemToCreateNewLabelEntityList;

  /// ✅ Newly added field for storing created GRN labels
  final List<GRNCreateLabelEntity> grnCreateLabelList;

  final bool isLoading;
  final Option<GoodsReceiptsFailures> getGoodsReceiptsLabelDetailFailure;

  bool isInitialLoad = true;

  @override
  List<Object?> get props => [
    goodsReceiptPurchaseOrderLineItemEntityList,
    purchaseItemToCreateNewLabelEntityList,
    grnCreateLabelList,
    isLoading,
    getGoodsReceiptsLabelDetailFailure,
  ];

  GoodsReceiptLabelState copyWith({
    List<GoodsReceiptPurchaseOrderLineItemEntity>?
    goodsReceiptPurchaseOrderLineItemEntityList,
    List<GoodsReceiptPurchaseOrderLineItemEntity>?
    purchaseItemToCreateNewLabelEntityList,
    List<GRNCreateLabelEntity>? grnCreateLabelList,
    bool? isLoading,
    Option<GoodsReceiptsFailures>? getGoodsReceiptsLabelDetailFailure,
  }) {
    return GoodsReceiptLabelState(
      goodsReceiptPurchaseOrderLineItemEntityList:
          goodsReceiptPurchaseOrderLineItemEntityList ??
          this.goodsReceiptPurchaseOrderLineItemEntityList,
      purchaseItemToCreateNewLabelEntityList:
          purchaseItemToCreateNewLabelEntityList ??
          this.purchaseItemToCreateNewLabelEntityList,
      grnCreateLabelList: grnCreateLabelList ?? this.grnCreateLabelList,
      isLoading: isLoading ?? this.isLoading,
      getGoodsReceiptsLabelDetailFailure:
          getGoodsReceiptsLabelDetailFailure ??
          this.getGoodsReceiptsLabelDetailFailure,
    );
  }
}
