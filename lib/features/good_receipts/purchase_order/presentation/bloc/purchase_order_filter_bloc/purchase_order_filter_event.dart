part of 'purchase_order_filter_bloc.dart';

sealed class PurchaseOrderFilterEvent extends Equatable {
  const PurchaseOrderFilterEvent();

  @override
  List<Object> get props => [];
}

class ChangeSyncFilter extends PurchaseOrderFilterEvent {
  const ChangeSyncFilter({required this.syncFilter});

  final SyncFilter syncFilter;
  @override
  List<Object> get props => [syncFilter];
}

class ClearFilter extends PurchaseOrderFilterEvent {
  const ClearFilter();

  @override
  List<Object> get props => [];
}

class ChangeStartDate extends PurchaseOrderFilterEvent {
  const ChangeStartDate({required this.dateTime});
  final DateTime dateTime;

  @override
  List<Object> get props => [dateTime];
}

class ChangeEndDate extends PurchaseOrderFilterEvent {
  const ChangeEndDate({required this.dateTime});
  final DateTime dateTime;

  @override
  List<Object> get props => [dateTime];
}

class ChangePoNumberEvent extends PurchaseOrderFilterEvent {
  const ChangePoNumberEvent({required this.poNumber});
  final String poNumber;

  @override
  List<Object> get props => [poNumber];
}

class ChangeCategory extends PurchaseOrderFilterEvent {
  const ChangeCategory({required this.categoryEntity});
  final ItemCategoryEntity categoryEntity;

  @override
  List<Object> get props => [categoryEntity];
}

class ChangeDeliveryPort extends PurchaseOrderFilterEvent {
  const ChangeDeliveryPort({required this.deliveryPortName});
  final String deliveryPortName;

  @override
  List<Object> get props => [deliveryPortName];
}

class ChangeGrnNo extends PurchaseOrderFilterEvent {
  const ChangeGrnNo({required this.purchaseOrderHDEntity});
  final PurchaseOrderEntity purchaseOrderHDEntity;

  @override
  List<Object> get props => [purchaseOrderHDEntity];
}

class FilterApplyButtonClickEvent extends PurchaseOrderFilterEvent {
  const FilterApplyButtonClickEvent();

  @override
  List<Object> get props => [];
}

class SearchPoNumber extends PurchaseOrderFilterEvent {
  const SearchPoNumber({required this.poNumber});
  final String poNumber;

  @override
  List<Object> get props => [poNumber];
}

class FetchAllCategory extends PurchaseOrderFilterEvent {
  const FetchAllCategory();

  @override
  List<Object> get props => [];
}

class ClearCategoryTempFilter extends PurchaseOrderFilterEvent {
  const ClearCategoryTempFilter();

  @override
  List<Object> get props => [];
}

class CategoryApplyButtonClick extends PurchaseOrderFilterEvent {
  const CategoryApplyButtonClick();

  @override
  List<Object> get props => [];
}

class AddCategoryListToTempList extends PurchaseOrderFilterEvent {
  const AddCategoryListToTempList();

  @override
  List<Object> get props => [];
}

class SearchGrnNo extends PurchaseOrderFilterEvent {
  const SearchGrnNo({required this.grnNo});
  final String grnNo;

  @override
  List<Object> get props => [];
}

class FetchAllPortListFromDb extends PurchaseOrderFilterEvent {
  const FetchAllPortListFromDb({required this.query});
  final String query;

  @override
  List<Object> get props => [query];
}
