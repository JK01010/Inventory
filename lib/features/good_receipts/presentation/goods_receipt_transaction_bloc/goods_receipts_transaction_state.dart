// // ignore_for_file: public_member_api_docs, sort_constructors_first
// part of 'goods_receipts_transaction_bloc.dart';

// class GoodsReceiptsTransactionState extends Equatable {
//   const GoodsReceiptsTransactionState({
//     required this.isLoading,
//     required this.transactionEntity,
//     required this.failure,
//     required this.isSelectionModeEnabled,
//     required this.syncList,
//     required this.syncStatus,
//     required this.transactionFilter,
//     required this.goodsReceiptPurchaseItemDetailEntityList,
//   });

//   factory GoodsReceiptsTransactionState.initial() =>
//       GoodsReceiptsTransactionState(
//         isLoading: false,
//         transactionEntity: [],
//         failure: none(),
//         isSelectionModeEnabled: false,
//         syncList: {},
//         syncStatus: TransactionSync.initial,
//         transactionFilter: TransactionFilterEntity(),
//         goodsReceiptPurchaseItemDetailEntityList: [],
//       );

//   final bool isLoading;
//   final bool isSelectionModeEnabled;
//   final List<GoodsReceiptsTransactionEntity> transactionEntity;
//   final Set<GoodsReceiptsTransactionEntity> syncList;
//   final Option<GoodsReceiptsFailures> failure;
//   final TransactionSync syncStatus;
//   final TransactionFilterEntity transactionFilter;
//   final List<GoodsReceiptPurchaseItemDetailEntity>
//   goodsReceiptPurchaseItemDetailEntityList;

//   GoodsReceiptsTransactionState copyWith({
//     bool? isLoading,
//     bool? isSelectionModeEnabled,
//     List<GoodsReceiptsTransactionEntity>? transactionEntity,
//     Set<GoodsReceiptsTransactionEntity>? syncList,
//     Option<GoodsReceiptsFailures>? failure,
//     TransactionSync? syncStatus,
//     TransactionFilterEntity? transactionFilter,
//     List<GoodsReceiptPurchaseItemDetailEntity>?
//     goodsReceiptPurchaseItemDetailEntityList,
//   }) {
//     return GoodsReceiptsTransactionState(
//       isLoading: isLoading ?? this.isLoading,
//       isSelectionModeEnabled:
//           isSelectionModeEnabled ?? this.isSelectionModeEnabled,
//       transactionEntity: transactionEntity ?? this.transactionEntity,
//       syncList: syncList ?? this.syncList,
//       failure: failure ?? this.failure,
//       syncStatus: syncStatus ?? this.syncStatus,
//       transactionFilter: transactionFilter ?? this.transactionFilter,
//       goodsReceiptPurchaseItemDetailEntityList:
//           goodsReceiptPurchaseItemDetailEntityList ??
//           this.goodsReceiptPurchaseItemDetailEntityList,
//     );
//   }

//   @override
//   List<Object> get props => [
//     isLoading,
//     transactionEntity,
//     failure,
//     isSelectionModeEnabled,
//     syncList,
//     syncStatus,
//     transactionFilter,
//   ];
// }
