part of 'stock_location_bloc.dart';

class StockLocationState extends Equatable {
  const StockLocationState({
    required this.isLoading,
    required this.stockLocationEntity,
    required this.stockLocationEntityList,
    required this.goodsReceiptsFailures,
  });

  factory StockLocationState.initial() => StockLocationState(
    isLoading: false,
    stockLocationEntity: StockLocationEntity(
      id: -1,
      itemId: -1,
      storageLocationId: -1,
      quantity: 0,
      tags: '',
    ),
    stockLocationEntityList: [],
    goodsReceiptsFailures: none(),
  );

  final bool isLoading;
  final StockLocationEntity stockLocationEntity;
  final List<StockLocationEntity> stockLocationEntityList;
  final Option<GoodsReceiptsFailures> goodsReceiptsFailures;

  @override
  List<Object?> get props => [
    isLoading,
    stockLocationEntity,
    stockLocationEntityList,
  ];

  StockLocationState copyWith({
    bool? isLoading,
    StockLocationEntity? stockLocationEntity,
    List<StockLocationEntity>? stockLocationEntityList,
    Option<GoodsReceiptsFailures>? goodsReceiptsFailures,
  }) {
    return StockLocationState(
      isLoading: isLoading ?? this.isLoading,
      stockLocationEntity: stockLocationEntity ?? this.stockLocationEntity,
      stockLocationEntityList:
          stockLocationEntityList ?? this.stockLocationEntityList,
      goodsReceiptsFailures:
          goodsReceiptsFailures ?? this.goodsReceiptsFailures,
    );
  }
}
