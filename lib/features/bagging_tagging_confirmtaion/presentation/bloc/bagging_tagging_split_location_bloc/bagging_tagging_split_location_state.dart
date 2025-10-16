part of 'bagging_tagging_split_location_bloc.dart';

class BaggingTaggingSplitLocationState extends Equatable {
  const BaggingTaggingSplitLocationState({
    required this.splitLocationEntityList,
    required this.splitLocationEntity,
    required this.isLoading,
    required this.goodsReceiptsFailure,
  });

  factory BaggingTaggingSplitLocationState.initial() =>
      BaggingTaggingSplitLocationState(
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
          grnHdId: -1,
          grnDtId: -1,
          code: '',
          description: '',
          parentItemId: -1,
          typeId: -1,
          quantity: -1,
          parentId: -1,
          isActive: false,
          locationHierarchy: '',
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

  BaggingTaggingSplitLocationState copyWith({
    bool? isLoading,
    BaggingTaggingSplitLocationState? splitLocationState,
    List<SplitLocationEntity>? splitLocationEntityList,
    Option<GoodsReceiptsFailures>? goodsReceiptsFailure,
  }) {
    return BaggingTaggingSplitLocationState(
      splitLocationEntityList:
          splitLocationEntityList ?? this.splitLocationEntityList,
      splitLocationEntity: splitLocationEntity ?? this.splitLocationEntity,
      isLoading: isLoading ?? this.isLoading,
      goodsReceiptsFailure: goodsReceiptsFailure ?? this.goodsReceiptsFailure,
    );
  }
}
