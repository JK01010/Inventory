// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'purchase_order_filter_bloc.dart';

class PurchaseOrderFilterState extends Equatable {
  const PurchaseOrderFilterState({
    required this.purchaseOrderFilterEntity,
    required this.purchaseOrderList,
    required this.itemCategoryList,
    required this.tempCategoryList,
    required this.grnFilteredList,
    required this.portEntityList,
  });
  final PurchaseOrderFilterEntity purchaseOrderFilterEntity;
  final List<PurchaseOrderEntity> purchaseOrderList;
  final List<ItemCategoryEntity> itemCategoryList;
  final List<ItemCategoryEntity> tempCategoryList;
  final List<PurchaseOrderEntity> grnFilteredList;
  final List<PortEntity> portEntityList;

  factory PurchaseOrderFilterState.initial() {
    return PurchaseOrderFilterState(
      purchaseOrderFilterEntity: PurchaseOrderFilterEntity(),
      purchaseOrderList: [],
      itemCategoryList: [],
      tempCategoryList: [],
      grnFilteredList: [],
      portEntityList: [],
    );
  }

  @override
  List<Object?> get props => [
    purchaseOrderFilterEntity,
    purchaseOrderList,
    itemCategoryList,
    tempCategoryList,
    grnFilteredList,
    portEntityList,
  ];

  PurchaseOrderFilterState copyWith({
    PurchaseOrderFilterEntity? purchaseOrderFilterEntity,
    List<PurchaseOrderEntity>? purchaseOrderList,
    List<ItemCategoryEntity>? itemCategoryList,
    List<ItemCategoryEntity>? tempCategoryList,
    List<PurchaseOrderEntity>? grnFilteredList,
    List<PortEntity>? portEntityList,
  }) {
    return PurchaseOrderFilterState(
      purchaseOrderFilterEntity:
          purchaseOrderFilterEntity ?? this.purchaseOrderFilterEntity,
      purchaseOrderList: purchaseOrderList ?? this.purchaseOrderList,
      itemCategoryList: itemCategoryList ?? this.itemCategoryList,
      tempCategoryList: tempCategoryList ?? this.tempCategoryList,
      grnFilteredList: grnFilteredList ?? this.grnFilteredList,
      portEntityList: portEntityList ?? this.portEntityList,
    );
  }
}
