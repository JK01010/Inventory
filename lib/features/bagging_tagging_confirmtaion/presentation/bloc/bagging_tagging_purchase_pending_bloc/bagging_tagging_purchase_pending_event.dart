part of 'bagging_tagging_purchase_pending_bloc.dart';

sealed class BaggingTaggingPurchasePendingEvent extends Equatable {
  const BaggingTaggingPurchasePendingEvent();

  @override
  List<Object> get props => [];
}

class FetchAllTransactionFromDb extends BaggingTaggingPurchasePendingEvent {
  const FetchAllTransactionFromDb({this.transactionFilterEntity});

  final TransactionFilterEntity? transactionFilterEntity;
}

// class AddToSyncList extends BaggingTaggingPurchasePendingEvent {
//   const AddToSyncList({required this.transactionEntityItem});
//
//   final GoodsReceiptsTransactionEntity transactionEntityItem;
//
//   @override
//   List<Object> get props => [transactionEntityItem];
// }
//
// // class ChangeSelectionMode extends BaggingTaggingPurchasePendingEvent {
// //   const ChangeSelectionMode({required this.value});
// //
// //   final bool value;
// //
// //   @override
// //   List<Object> get props => [value];
// // }
//
// class ClearSyncList extends BaggingTaggingPurchasePendingEvent {
//   const ClearSyncList();
//
//   @override
//   List<Object> get props => [];
// }
//
// class SelectAll extends BaggingTaggingPurchasePendingEvent {
//   const SelectAll();
//
//   @override
//   List<Object> get props => [];
// }
//
// class SyncTransactionList extends BaggingTaggingPurchasePendingEvent {
//   const SyncTransactionList();
//
//   @override
//   List<Object> get props => [];
// }
//
// class ChangeSyncFilter extends BaggingTaggingPurchasePendingEvent {
//   const ChangeSyncFilter({required this.syncFilter});
//
//   final SyncFilter syncFilter;
//
//   @override
//   List<Object> get props => [syncFilter];
// }
//
// class ClearFilter extends BaggingTaggingPurchasePendingEvent {
//   const ClearFilter();
//
//   @override
//   List<Object> get props => [];
// }
//
// class ChangeStartDate extends BaggingTaggingPurchasePendingEvent {
//   const ChangeStartDate({required this.dateTime});
//
//   final DateTime dateTime;
//
//   @override
//   List<Object> get props => [dateTime];
// }
//
// class ChangeEndDate extends BaggingTaggingPurchasePendingEvent {
//   const ChangeEndDate({required this.dateTime});
//
//   final DateTime dateTime;
//
//   @override
//   List<Object> get props => [dateTime];
// }
//
// class ChangePoNumberEvent extends BaggingTaggingPurchasePendingEvent {
//   const ChangePoNumberEvent({required this.poNumber});
//
//   final String poNumber;
//
//   @override
//   List<Object> get props => [poNumber];
// }
//
// class ChangeCategory extends BaggingTaggingPurchasePendingEvent {
//   const ChangeCategory({required this.categoryId});
//
//   final String categoryId;
//
//   @override
//   List<Object> get props => [categoryId];
// }
//
// class ChangeDeliveryPort extends BaggingTaggingPurchasePendingEvent {
//   const ChangeDeliveryPort({required this.deliveryPort});
//
//   final String deliveryPort;
//
//   @override
//   List<Object> get props => [deliveryPort];
// }
//
// class ChangeGrnNo extends BaggingTaggingPurchasePendingEvent {
//   const ChangeGrnNo({required this.grnNo});
//
//   final String grnNo;
//
//   @override
//   List<Object> get props => [grnNo];
// }
//
// class FilterApplyButtonClickEvent extends BaggingTaggingPurchasePendingEvent {
//   const FilterApplyButtonClickEvent();
//
//   @override
//   List<Object> get props => [];
// }
