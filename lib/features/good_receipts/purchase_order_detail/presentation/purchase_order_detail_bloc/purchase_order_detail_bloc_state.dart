import 'package:equatable/equatable.dart';
import '../../../../common_feature/domain/entities/item_entity.dart';
import '../../../purchase_order/domain/entity/purchase_order_entity.dart';

class PurchaseOrderDetailBlocState extends Equatable {
  const PurchaseOrderDetailBlocState({
    required this.isLoading,
    required this.purchaseOrderData,
    required this.purchaseOrderItems,
    required this.isFinalizeDone,
    required this.isSaveLoading,
  });

  factory PurchaseOrderDetailBlocState.initial() {
    return PurchaseOrderDetailBlocState(
      isLoading: true,
      purchaseOrderData: PurchaseOrderEntity.initial(),
      purchaseOrderItems: [],
      isFinalizeDone: false,
      isSaveLoading: false,
    );
  }

  final bool isLoading;
  final List<ItemEntity> purchaseOrderItems;
  final PurchaseOrderEntity purchaseOrderData;
  final bool isFinalizeDone;
  final bool isSaveLoading;

  @override
  List<Object?> get props => [
    isLoading,
    purchaseOrderData,
    purchaseOrderItems,
    isFinalizeDone,
    isSaveLoading,
  ];

  PurchaseOrderDetailBlocState copyWith({
    bool? isLoading,
    List<ItemEntity>? purchaseOrderItems,
    PurchaseOrderEntity? purchaseOrderData,
    bool? isFinalizeDone,
    bool? isSaveLoading,
  }) {
    return PurchaseOrderDetailBlocState(
      isLoading: isLoading ?? this.isLoading,
      purchaseOrderItems: purchaseOrderItems ?? this.purchaseOrderItems,
      purchaseOrderData: purchaseOrderData ?? this.purchaseOrderData,
      isFinalizeDone: isFinalizeDone ?? this.isFinalizeDone,
      isSaveLoading: isSaveLoading ?? this.isSaveLoading,
    );
  }
}
