part of 'transaction_filter_bloc.dart';

sealed class TransactionFilterEvent extends Equatable {
  const TransactionFilterEvent();

  @override
  List<Object> get props => [];
}

class ChangeSyncFilter extends TransactionFilterEvent {
  const ChangeSyncFilter({required this.syncFilter});

  final SyncFilter syncFilter;
  @override
  List<Object> get props => [syncFilter];
}

class ClearFilter extends TransactionFilterEvent {
  const ClearFilter();

  @override
  List<Object> get props => [];
}

class ChangeStartDate extends TransactionFilterEvent {
  const ChangeStartDate({required this.dateTime});
  final DateTime dateTime;

  @override
  List<Object> get props => [dateTime];
}

class ChangeEndDate extends TransactionFilterEvent {
  const ChangeEndDate({required this.dateTime});
  final DateTime dateTime;

  @override
  List<Object> get props => [dateTime];
}

class ChangePoNumberEvent extends TransactionFilterEvent {
  const ChangePoNumberEvent({required this.poNumber});
  final String poNumber;

  @override
  List<Object> get props => [poNumber];
}

class ChangeCategory extends TransactionFilterEvent {
  const ChangeCategory({required this.categoryEntity});
  final ItemCategoryEntity categoryEntity;

  @override
  List<Object> get props => [categoryEntity];
}

class ChangeDeliveryPort extends TransactionFilterEvent {
  const ChangeDeliveryPort({required this.portId});
  final int portId;

  @override
  List<Object> get props => [portId];
}

class ChangeGrnNo extends TransactionFilterEvent {
  const ChangeGrnNo({required this.query});
  final int query;

  @override
  List<Object> get props => [query];
}

class FilterApplyButtonClickEvent extends TransactionFilterEvent {
  const FilterApplyButtonClickEvent();

  @override
  List<Object> get props => [];
}

class SearchPoNumber extends TransactionFilterEvent {
  const SearchPoNumber({required this.poNumber});
  final String poNumber;

  @override
  List<Object> get props => [poNumber];
}

class FetchAllCategory extends TransactionFilterEvent {
  const FetchAllCategory();

  @override
  List<Object> get props => [];
}

class ClearCategoryTempFilter extends TransactionFilterEvent {
  const ClearCategoryTempFilter();

  @override
  List<Object> get props => [];
}

class CategoryApplyButtonClick extends TransactionFilterEvent {
  const CategoryApplyButtonClick();

  @override
  List<Object> get props => [];
}

class AddCategoryListToTempList extends TransactionFilterEvent {
  const AddCategoryListToTempList();

  @override
  List<Object> get props => [];
}

class SearchGrnNo extends TransactionFilterEvent {
  const SearchGrnNo({required this.grnNo});
  final String grnNo;

  @override
  List<Object> get props => [];
}

class FetchAllPortListFromDb extends TransactionFilterEvent {
  const FetchAllPortListFromDb({required this.query});
  final String query;

  @override
  List<Object> get props => [query];
}
