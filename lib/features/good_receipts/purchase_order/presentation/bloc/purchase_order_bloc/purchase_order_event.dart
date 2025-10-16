part of 'purchase_order_bloc.dart';

sealed class PurchaseOrderEvent extends Equatable {
  const PurchaseOrderEvent();

  @override
  List<Object> get props => [];
}

class GetPurchaseOrderFromDb extends PurchaseOrderEvent {
  const GetPurchaseOrderFromDb({this.purchaseOrderFilterEntity});

  final PurchaseOrderFilterEntity? purchaseOrderFilterEntity;
}
