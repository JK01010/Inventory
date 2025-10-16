// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bagging_tagging_purchase_pending_bloc.dart';

class BaggingTaggingPurchasePendingState extends Equatable {
  const BaggingTaggingPurchasePendingState({
    required this.isLoading,
    required this.pendingEntity,
    required this.failure,
    required this.isSelectionModeEnabled,
    required this.syncList,
    required this.syncStatus,
    required this.transactionFilter,
    required this.goodsReceiptPurchaseItemDetailEntityList,
  });

  factory BaggingTaggingPurchasePendingState.initial() =>
      BaggingTaggingPurchasePendingState(
        isLoading: false,
        pendingEntity: [],
        failure: none(),
        isSelectionModeEnabled: false,
        syncList: {},
        syncStatus: TransactionSync.initial,
        transactionFilter: TransactionFilterEntity(),
        goodsReceiptPurchaseItemDetailEntityList: [],
      );

  final bool isLoading;
  final bool isSelectionModeEnabled;
  final List<GoodsReceiptsTransactionEntity> pendingEntity;

  final Set<GoodsReceiptsTransactionEntity> syncList;
  final Option<GoodsReceiptsFailures> failure;
  final TransactionSync syncStatus;
  final TransactionFilterEntity transactionFilter;
  final List<GoodsReceiptPurchaseItemDetailEntity>
  goodsReceiptPurchaseItemDetailEntityList;

  BaggingTaggingPurchasePendingState copyWith({
    bool? isLoading,
    bool? isSelectionModeEnabled,
    List<GoodsReceiptsTransactionEntity>? pendingEntity,
    Set<GoodsReceiptsTransactionEntity>? syncList,
    Option<GoodsReceiptsFailures>? failure,
    TransactionSync? syncStatus,
    TransactionFilterEntity? transactionFilter,
    List<GoodsReceiptPurchaseItemDetailEntity>?
    goodsReceiptPurchaseItemDetailEntityList,
  }) {
    return BaggingTaggingPurchasePendingState(
      isLoading: isLoading ?? this.isLoading,
      isSelectionModeEnabled:
          isSelectionModeEnabled ?? this.isSelectionModeEnabled,
      pendingEntity: pendingEntity ?? this.pendingEntity,
      syncList: syncList ?? this.syncList,
      failure: failure ?? this.failure,
      syncStatus: syncStatus ?? this.syncStatus,
      transactionFilter: transactionFilter ?? this.transactionFilter,
      goodsReceiptPurchaseItemDetailEntityList:
          goodsReceiptPurchaseItemDetailEntityList ??
          this.goodsReceiptPurchaseItemDetailEntityList,
    );
  }

  @override
  List<Object> get props => [
    isLoading,
    pendingEntity,
    failure,
    isSelectionModeEnabled,
    syncList,
    syncStatus,
    transactionFilter,
  ];
}
