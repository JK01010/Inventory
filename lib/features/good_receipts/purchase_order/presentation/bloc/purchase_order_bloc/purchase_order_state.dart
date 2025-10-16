// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'purchase_order_bloc.dart';

class PurchaseOrderState extends Equatable {
  const PurchaseOrderState({
    required this.isLoading,
    required this.purchaseOrderEntityList,
  });

  factory PurchaseOrderState.initial() =>
      PurchaseOrderState(isLoading: false, purchaseOrderEntityList: []);
  final bool isLoading;
  final List<PurchaseOrderEntity> purchaseOrderEntityList;

  @override
  List<Object> get props => [isLoading, purchaseOrderEntityList];

  PurchaseOrderState copyWith({
    bool? isLoading,
    List<PurchaseOrderEntity>? purchaseOrderEntityList,
  }) {
    return PurchaseOrderState(
      isLoading: isLoading ?? this.isLoading,
      purchaseOrderEntityList:
          purchaseOrderEntityList ?? this.purchaseOrderEntityList,
    );
  }
}
