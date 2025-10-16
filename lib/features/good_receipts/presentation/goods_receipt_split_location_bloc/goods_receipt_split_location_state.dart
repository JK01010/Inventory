part of 'goods_receipt_split_location_bloc.dart';

class GoodsReceiptSplitLocationState extends Equatable {
  const GoodsReceiptSplitLocationState({
    required this.splitLocationEntityList,
    required this.splitLocationEntity,
    required this.isLoading,
    required this.goodsReceiptsFailure,
  });

  factory GoodsReceiptSplitLocationState.initial() =>
      GoodsReceiptSplitLocationState(
        isLoading: false,
        splitLocationEntity: SplitLocationEntity(
          id: DateTime.now().millisecondsSinceEpoch,
          itemId: 0,
          locationId: 0,
          poId: -1,
          robQty: 0,
          poDtId: -1,
          quantityType: "",
          transactionId: "",
          locationName: "",
          cursorPosition: 0,
          code: "",
          description: "",
          parentItemId: 0,
          typeId: 0,
          quantity: 0,
          parentId: 0,
          isActive: false,
          locationHierarchy: "",
          grnHdId: 0,
          grnDtId: 0,
            serialNumbers: []

        ),
        splitLocationEntityList: [],
        goodsReceiptsFailure: none(),
      );

  final List<SplitLocationEntity> splitLocationEntityList;
  final SplitLocationEntity splitLocationEntity;
  final bool isLoading;
  final Option<GoodsReceiptsFailures> goodsReceiptsFailure;

  @override
  List<Object?> get props => [
    isLoading,
    splitLocationEntity,
    splitLocationEntityList,
    goodsReceiptsFailure,
  ];

  GoodsReceiptSplitLocationState copyWith({
    bool? isLoading,
    GoodsReceiptSplitLocationState? splitLocationState,
    List<SplitLocationEntity>? splitLocationEntityList,
    Option<GoodsReceiptsFailures>? goodsReceiptsFailure,
  }) {
    return GoodsReceiptSplitLocationState(
      splitLocationEntityList:
          splitLocationEntityList ?? this.splitLocationEntityList,
      splitLocationEntity: splitLocationEntity ?? this.splitLocationEntity,
      isLoading: isLoading ?? this.isLoading,
      goodsReceiptsFailure: goodsReceiptsFailure ?? this.goodsReceiptsFailure,
    );
  }
}
