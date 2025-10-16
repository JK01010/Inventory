part of 'purchase_order_search_bloc.dart';

sealed class PurchaseOrderSearchEvent extends Equatable {
  const PurchaseOrderSearchEvent();

  @override
  List<Object> get props => [];
}

class PurchaseOrderItemSearchEvent extends PurchaseOrderSearchEvent {
  const PurchaseOrderItemSearchEvent({required this.query});
  final String query;

  @override
  List<Object> get props => [query];
}
