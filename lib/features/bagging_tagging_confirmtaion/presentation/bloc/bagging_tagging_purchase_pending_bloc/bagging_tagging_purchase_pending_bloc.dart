import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/constants/app_enum.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../core/utils/app_logger.dart';
import '../../../../good_receipts/domain/entities/goods_receipt_purchase_item_detail_entity.dart';
import '../../../../good_receipts/domain/entities/goods_receipt_transaction_entity.dart';
import '../../../../good_receipts/domain/entities/transaction_filter_entity.dart';
import '../../../../good_receipts/domain/failures/goods_receipts_failures.dart';
import '../../../../good_receipts/domain/use_cases/transaction_usecase/filter_transaction_list_usecase.dart';
import '../../../../good_receipts/domain/use_cases/transaction_usecase/get_all_goods_receipt_transaction_use_case.dart';
import '../../../../good_receipts/domain/use_cases/transaction_usecase/get_all_grn_transaction_item_use_case.dart';
import '../../../../good_receipts/domain/use_cases/transaction_usecase/sync_transaction_list_usecase.dart';

part 'bagging_tagging_purchase_pending_event.dart';
part 'bagging_tagging_purchase_pending_state.dart';

class BaggingTaggingPurchasePendingBloc
    extends
        Bloc<
          BaggingTaggingPurchasePendingEvent,
          BaggingTaggingPurchasePendingState
        > {
  BaggingTaggingPurchasePendingBloc({
    required this.getAllGoodsReceiptTransactionUseCase,
    required this.syncTransactionListUseCase,
    required this.filterTransactionListUseCase,
    required this.getAllGrnTransactionItemUseCase,
  }) : super(BaggingTaggingPurchasePendingState.initial()) {
    on<BaggingTaggingPurchasePendingEvent>((event, emit) async {
      switch (event) {
        case FetchAllTransactionFromDb():
          await _fetchAllTransactionFromDb(event, emit);
        // case AddToSyncList():
        //   _addToSyncList(event, emit);
        // case ChangeSelectionMode():
        //   _changeSelectionMode(event, emit);
        // case ClearSyncList():
        //   _clearSyncList(event, emit);
        // case SelectAll():
        //   _selectAll(event, emit);
        // case SyncTransactionList():
        //   _syncTransactionList(event, emit);
        // case ChangeSyncFilter():
        //   _changeSyncFilter(event, emit);
        // case ClearFilter():
        //   _clearFilter(event, emit);
        // case ChangeStartDate():
        //   _changeStartDate(event, emit);
        // case ChangeEndDate():
        //   _changeEndDate(event, emit);
        // case ChangePoNumberEvent():
        //   _changePoNumber(event, emit);
        // case ChangeCategory():
        //   _changeCategory(event, emit);
        // case ChangeDeliveryPort():
        //   _changeDeliveryPort(event, emit);
        // case ChangeGrnNo():
        //   _changeGrnNo(event, emit);
        // case FilterApplyButtonClickEvent():
        //   await _filterApplyButtonClickEvent(event, emit);
      }
    });
  }

  final SyncTransactionListUseCase syncTransactionListUseCase;
  final GetAllGoodsReceiptTransactionUseCase
  getAllGoodsReceiptTransactionUseCase;
  final FilterTransactionListUseCase filterTransactionListUseCase;
  final GetAllGrnTransactionItemUseCase getAllGrnTransactionItemUseCase;

  Future<void> _fetchAllTransactionFromDb(
    FetchAllTransactionFromDb event,
    Emitter<BaggingTaggingPurchasePendingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final failureOrSuccess = await getAllGoodsReceiptTransactionUseCase(
      filter: event.transactionFilterEntity,
    );

    failureOrSuccess.fold(
      (failure) {
        emit(state.copyWith(failure: some(failure), isLoading: false));
      },
      (transactionList) {
        final List<GoodsReceiptsTransactionEntity> newList =
            transactionList.where((element) {
              return element.isBaggingCompleted == false &&
                  element.isBaggingTaggingApplicable == true;
            }).toList();

        // List<GoodsReceiptsTransactionEntity> grnTransactionList = [];
        // if (newList.isNotEmpty) {
        //   Map<String, List<GoodsReceiptsTransactionEntity>> groupedByPoID = {};

        //   for (var item in newList) {
        //     if (groupedByPoID.containsKey(item.poNo)) {
        //       groupedByPoID[item.grnId.toString()]!.add(item);
        //     } else {
        //       groupedByPoID[item.grnId.toString()] = [item];
        //       grnTransactionList.add(item);
        //     }
        //   }
        // }

        emit(state.copyWith(pendingEntity: newList, isLoading: true));
      },
    );

    //Event to fetch the GRNItemDetails api once got the Transaction list api.
    await fetchAllGRNTransactionItems(emit);
  }

  // bool isSyncListContains({required int poId}) {
  //   return state.syncList.any((element) => element.poId == poId);
  // }
  //
  // void _addToSyncList(
  //   AddToSyncList event,
  //   Emitter<BaggingTaggingPurchasePendingState> emit,
  // ) {
  //   if (event.transactionEntityItem.syncStatus) {
  //     return;
  //   }
  //   final Set<GoodsReceiptsTransactionEntity> newTransactionList = {
  //     ...state.syncList,
  //   };
  //   if (newTransactionList.contains(event.transactionEntityItem)) {
  //     newTransactionList.remove(event.transactionEntityItem);
  //   } else {
  //     newTransactionList.add(event.transactionEntityItem);
  //   }
  //
  //   emit(state.copyWith(syncList: newTransactionList));
  // }
  //
  // // void _changeSelectionMode(
  // //   ChangeSelectionMode event,
  // //   Emitter<BaggingTaggingPurchasePendingState> emit,
  // // ) {
  // //   emit(state.copyWith(isSelectionModeEnabled: event.value));
  // // }
  //
  // void _clearSyncList(
  //   ClearSyncList event,
  //   Emitter<BaggingTaggingPurchasePendingState> emit,
  // ) {
  //   emit(state.copyWith(syncList: {}));
  // }
  //
  // void _selectAll(
  //   SelectAll event,
  //   Emitter<BaggingTaggingPurchasePendingState> emit,
  // ) {
  //   final transactionList =
  //       state.pendingEntity.where((element) => !element.syncStatus).toSet();
  //   emit(state.copyWith(syncList: transactionList));
  // }
  //
  // bool isSelectAll() {
  //   if (state.syncList.isEmpty || state.pendingEntity.isEmpty) {
  //     return false;
  //   }
  //   final unSyncedList =
  //       state.pendingEntity
  //           .where((element) => !element.syncStatus)
  //           .toList();
  //
  //   return unSyncedList.length == state.syncList.length;
  // }
  //
  // Future<void> _syncTransactionList(
  //   SyncTransactionList event,
  //   Emitter<BaggingTaggingPurchasePendingState> emit,
  // ) async {
  //   emit(state.copyWith(syncStatus: TransactionSync.syncing));
  //   final failureOrSuccess = await syncTransactionListUseCase(
  //     transactionItemList: state.syncList.toList(),
  //   );
  //
  //   log(state.syncList.toString(), name: "SyncList");
  //   failureOrSuccess.fold(
  //     (failure) {
  //       emit(state.copyWith(failure: some(failure)));
  //     },
  //     (success) {
  //       emit(state.copyWith(syncStatus: TransactionSync.completed));
  //       emit(state.copyWith(syncStatus: TransactionSync.initial));
  //     },
  //   );
  // }
  //
  // void _changeSyncFilter(
  //   ChangeSyncFilter event,
  //   Emitter<BaggingTaggingPurchasePendingState> emit,
  // ) {
  //   emit(
  //     state.copyWith(
  //       transactionFilter: state.transactionFilter.copyWith(
  //         syncFilter: event.syncFilter,
  //       ),
  //     ),
  //   );
  // }
  //
  // void _clearFilter(
  //   ClearFilter event,
  //   Emitter<BaggingTaggingPurchasePendingState> emit,
  // ) {
  //   emit(state.copyWith(transactionFilter: TransactionFilterEntity()));
  // }
  //
  // void _changeStartDate(
  //   ChangeStartDate event,
  //   Emitter<BaggingTaggingPurchasePendingState> emit,
  // ) {
  //   emit(
  //     state.copyWith(
  //       transactionFilter: state.transactionFilter.copyWith(
  //         fromDate: event.dateTime,
  //       ),
  //     ),
  //   );
  // }
  //
  // void _changeEndDate(
  //   ChangeEndDate event,
  //   Emitter<BaggingTaggingPurchasePendingState> emit,
  // ) {
  //   emit(
  //     state.copyWith(
  //       transactionFilter: state.transactionFilter.copyWith(
  //         toDate: event.dateTime,
  //       ),
  //     ),
  //   );
  // }
  //
  // void _changePoNumber(
  //   ChangePoNumberEvent event,
  //   Emitter<BaggingTaggingPurchasePendingState> emit,
  // ) {
  //   emit(
  //     state.copyWith(
  //       transactionFilter: state.transactionFilter.copyWith(
  //         poNumberOrTitle: event.poNumber,
  //       ),
  //     ),
  //   );
  // }
  //
  // void _changeCategory(
  //   ChangeCategory event,
  //   Emitter<BaggingTaggingPurchasePendingState> emit,
  // ) {
  //   // emit(
  //   //   state.copyWith(
  //   //     transactionFilter: state.transactionFilter.copyWith(
  //   //       category: event.transactionCategory,
  //   //     ),
  //   //   ),
  //   // );
  // }
  //
  // void _changeDeliveryPort(
  //   ChangeDeliveryPort event,
  //   Emitter<BaggingTaggingPurchasePendingState> emit,
  // ) {
  //   emit(
  //     state.copyWith(
  //       transactionFilter: state.transactionFilter.copyWith(portId: 1),
  //     ),
  //   );
  // }
  //
  // void _changeGrnNo(
  //   ChangeGrnNo event,
  //   Emitter<BaggingTaggingPurchasePendingState> emit,
  // ) {
  //   emit(
  //     state.copyWith(
  //       transactionFilter: state.transactionFilter.copyWith(grnNo: event.grnNo),
  //     ),
  //   );
  // }
  //
  // Future<void> _filterApplyButtonClickEvent(
  //   FilterApplyButtonClickEvent event,
  //   Emitter<BaggingTaggingPurchasePendingState> emit,
  // ) async {
  //   final failureOrSuccess = await filterTransactionListUseCase(
  //     transactionFilterEntity: state.transactionFilter,
  //   );
  //
  //   failureOrSuccess.fold((failure) {}, (transactionEntity) {
  //     emit(state.copyWith(pendingEntity: transactionEntity));
  //   });
  // }
  //
  Future<void> fetchAllGRNTransactionItems(
    Emitter<BaggingTaggingPurchasePendingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final failureOrSuccess = await getAllGrnTransactionItemUseCase();

    failureOrSuccess.fold(
      (failure) {
        emit(state.copyWith(failure: some(failure), isLoading: false));
      },
      (grnTransactionItemList) {
        List<GoodsReceiptsTransactionEntity> transactionEntityList =
            state.pendingEntity;
        if (grnTransactionItemList.isNotEmpty) {
          Map<int, List<GoodsReceiptPurchaseItemDetailEntity>> groupedByPoID =
              {};

          for (var item in grnTransactionItemList) {
            if (groupedByPoID.containsKey(item.poId)) {
              groupedByPoID[item.poId]!.add(item);
            } else {
              groupedByPoID[item.poId] = [item];
            }
          }
          groupedByPoID.forEach((key, value) {
            double receivedQty = 0;
            double damagedQty = 0;
            double newStock = 0;
            for (var itemElement in value) {
              receivedQty += itemElement.receivedQty;
              damagedQty += itemElement.damagedOrWrongSupply;
              newStock += itemElement.newStock;
            }

            for (var transElement in transactionEntityList) {
              if (transElement.poId == key) {
                transElement
                  ..receivedQty = receivedQty
                  ..damagedQty = damagedQty
                  ..newStock = newStock;
              }
              break;
            }
          });
        }
        emit(
          state.copyWith(
            pendingEntity: transactionEntityList,
            goodsReceiptPurchaseItemDetailEntityList: grnTransactionItemList,
            isLoading: false,
          ),
        );
      },
    );
  }
}
