part of 'purchase_order_search_bloc.dart';

sealed class PurchaseOrderSearchState extends Equatable {
  const PurchaseOrderSearchState();

  @override
  List<Object> get props => [];
}

final class PurchaseOrderSearchInitial extends PurchaseOrderSearchState {}

final class PurchaseOrderSearchLoading extends PurchaseOrderSearchState {}

final class PurchaseOrderSearchLoaded extends PurchaseOrderSearchState {
  const PurchaseOrderSearchLoaded({required this.purchaseOrderEntityList});

  final List<PurchaseOrderEntity> purchaseOrderEntityList;
  @override
  List<Object> get props => [purchaseOrderEntityList];
}

final class PurchaseOrderSearchError extends PurchaseOrderSearchState {
  const PurchaseOrderSearchError({required this.goodsReceiptsFailures});

  final GoodsReceiptsFailures goodsReceiptsFailures;
  @override
  List<Object> get props => [goodsReceiptsFailures];
}
