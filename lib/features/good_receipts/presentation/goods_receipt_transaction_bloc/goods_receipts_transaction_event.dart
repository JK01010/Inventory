// part of 'goods_receipts_transaction_bloc.dart';

// sealed class GoodsReceiptsTransactionEvent extends Equatable {
//   const GoodsReceiptsTransactionEvent();

//   @override
//   List<Object> get props => [];
// }

// class FetchAllTransactionFromDb extends GoodsReceiptsTransactionEvent {
//   const FetchAllTransactionFromDb({this.transactionFilterEntity});

//   final TransactionFilterEntity? transactionFilterEntity;
// }

// class AddToSyncList extends GoodsReceiptsTransactionEvent {
//   const AddToSyncList({required this.transactionEntityItem});

//   final GoodsReceiptsTransactionEntity transactionEntityItem;

//   @override
//   List<Object> get props => [transactionEntityItem];
// }

// class ChangeSelectionMode extends GoodsReceiptsTransactionEvent {
//   const ChangeSelectionMode({required this.value});

//   final bool value;

//   @override
//   List<Object> get props => [value];
// }

// class ClearSyncList extends GoodsReceiptsTransactionEvent {
//   const ClearSyncList();

//   @override
//   List<Object> get props => [];
// }

// class SelectAll extends GoodsReceiptsTransactionEvent {
//   const SelectAll();

//   @override
//   List<Object> get props => [];
// }

// class SyncTransactionList extends GoodsReceiptsTransactionEvent {
//   const SyncTransactionList();

//   @override
//   List<Object> get props => [];
// }

// class ChangeSyncFilter extends GoodsReceiptsTransactionEvent {
//   const ChangeSyncFilter({required this.syncFilter});

//   final SyncFilter syncFilter;

//   @override
//   List<Object> get props => [syncFilter];
// }

// class ClearFilter extends GoodsReceiptsTransactionEvent {
//   const ClearFilter();

//   @override
//   List<Object> get props => [];
// }

// class ChangeStartDate extends GoodsReceiptsTransactionEvent {
//   const ChangeStartDate({required this.dateTime});

//   final DateTime dateTime;

//   @override
//   List<Object> get props => [dateTime];
// }

// class ChangeEndDate extends GoodsReceiptsTransactionEvent {
//   const ChangeEndDate({required this.dateTime});

//   final DateTime dateTime;

//   @override
//   List<Object> get props => [dateTime];
// }

// class ChangePoNumberEvent extends GoodsReceiptsTransactionEvent {
//   const ChangePoNumberEvent({required this.poNumber});

//   final String poNumber;

//   @override
//   List<Object> get props => [poNumber];
// }

// class ChangeCategory extends GoodsReceiptsTransactionEvent {
//   const ChangeCategory({required this.categoryId});

//   final String categoryId;

//   @override
//   List<Object> get props => [categoryId];
// }

// class ChangeDeliveryPort extends GoodsReceiptsTransactionEvent {
//   const ChangeDeliveryPort({required this.deliveryPort});

//   final String deliveryPort;

//   @override
//   List<Object> get props => [deliveryPort];
// }

// class ChangeGrnNo extends GoodsReceiptsTransactionEvent {
//   const ChangeGrnNo({required this.grnNo});

//   final String grnNo;

//   @override
//   List<Object> get props => [grnNo];
// }

// class FilterApplyButtonClickEvent extends GoodsReceiptsTransactionEvent {
//   const FilterApplyButtonClickEvent();

//   @override
//   List<Object> get props => [];
// }
