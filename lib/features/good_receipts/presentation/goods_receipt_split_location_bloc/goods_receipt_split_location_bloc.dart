import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../bagging_tagging_confirmtaion/domain/usecase/get_all_bagging_item_details_usecase.dart';
import '../../../common_feature/domain/usecase/insert_pending_po_split_location_data_usecase.dart';
import '../../domain/entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../../domain/entities/split_location_entity.dart';
import '../../domain/failures/goods_receipts_failures.dart';
import '../../domain/use_cases/delete_split_storage_location_item_by_id_use_case.dart';
import '../../domain/use_cases/get_pending_po_split_location_data_use_case.dart';
import '../../domain/use_cases/get_split_location_by_purchase_item_detail_usecase.dart';
import '../../domain/use_cases/insert_or_update_split_storage_location_usecase.dart';

part 'goods_receipt_split_location_event.dart';

part 'goods_receipt_split_location_state.dart';

class GoodsReceiptSplitLocationBloc
    extends
        Bloc<GoodsReceiptSplitLocationEvent, GoodsReceiptSplitLocationState> {
  GoodsReceiptSplitLocationBloc({
    required this.getSplitLocationByPurchaseItemDetailUseCase,
    required this.insertOrUpdateSplitStorageLocationUseCase,
    required this.deleteSplitStorageLocationItemByIdUseCase,
    required this.insertPendingPoSplitLocationDataUseCase,
    required this.getPendingPoSplitLocationDataUseCase,
    required this.getItemSplitLocationDataUseCase,
  }) : super(GoodsReceiptSplitLocationState.initial()) {
    on<GoodsReceiptSplitLocationEvent>((event, emit) async {
      switch (event) {
        case FetchSplitStorageLocationByPurchaseItemDetailEntity():
          await fetchSplitStorageLocationByPurchaseItemDetailEntity(
            event,
            emit,
          );
          break;
        case AddEmptySplitStorageLocationWidgetEvent():
          await addEmptyStorageLocationWidget(event, emit);
        case UpdateSplitLocationEntityWithSelectedLocationEvent():
          await updateSplitLocationWithSelectedStorageLocation(event, emit);
        case UpdateSplitLocationInTableOnLabelDetailEvent():
          await updateSplitLocationInTableOnLabelDetailEvent(event, emit);
        case OnChangeSplitLocationQuantityEvent():
          await onChangeSplitLocationQuantityEvent(event, emit);
        case DeleteSplitStorageLocationItemByIdEvent():
          await onDeleteSplitStorageLocationItemByIdEvent(event, emit);
        case PendingPoSplitLocationUpdateToDbEvent():
          await onPendingPoSplitLocationUpdateToDbEvent(event, emit);
        case FetchPendingPoSplitLocationDataEvent():
          await onFetchPendingPoSplitLocationDataEvent(event, emit);
        case TransactionItemSplitLocationEvent():
          await onTransactionItemSplitLocationEvent(event, emit);
      }
    });
  }

  GetSplitLocationByPurchaseItemDetailUseCase
  getSplitLocationByPurchaseItemDetailUseCase;
  InsertOrUpdateSplitStorageLocationUseCase
  insertOrUpdateSplitStorageLocationUseCase;
  DeleteSplitStorageLocationItemByIdUseCase
  deleteSplitStorageLocationItemByIdUseCase;
  InsertPendingPoSplitLocationDataUseCase
  insertPendingPoSplitLocationDataUseCase;
  GetPendingPoSplitLocationDataUseCase getPendingPoSplitLocationDataUseCase;
  final GetItemSplitLocationDataUseCase getItemSplitLocationDataUseCase;

  Future<void> fetchSplitStorageLocationByPurchaseItemDetailEntity(
    FetchSplitStorageLocationByPurchaseItemDetailEntity event,
    Emitter<GoodsReceiptSplitLocationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, splitLocationEntityList: []));
    final failureOrSuccess = await getSplitLocationByPurchaseItemDetailUseCase
        .getSplitLocationByPurchaseItemDetail(
          event.goodsReceiptPurchaseOrderLineItemEntity,
        );
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(isLoading: false, goodsReceiptsFailure: some(failure)),
        );
      },
      (success) {
        emit(
          state.copyWith(isLoading: false, splitLocationEntityList: success),
        );
      },
    );
  }

  Future<void> addEmptyStorageLocationWidget(
    AddEmptySplitStorageLocationWidgetEvent event,
    Emitter emit,
  ) async {
    debugPrint('event.poId : ${event.poId}');
    SplitLocationEntity splitLocationEntity = SplitLocationEntity(
      id: DateTime.now().millisecondsSinceEpoch,
      itemId: event.itemId,
      locationId: 0,
      poId: event.poId,
      robQty: 0,
      poDtId: event.poDtId,
      quantityType: '',
      transactionId: '',
      locationName: '',
      cursorPosition: 0,
      code: '',
      description: '',
      parentItemId: 0,
      typeId: event.typeId,
      quantity: 0,
      parentId: 0,
      isActive: true,
      locationHierarchy: '',
      grnHdId: 0,
      grnDtId: 0,
        serialNumbers: []
    );
    List<SplitLocationEntity> tempList = List<SplitLocationEntity>.from(
      state.splitLocationEntityList,
    )..add(splitLocationEntity);
    debugPrint("tempList : $tempList");
    emit(state.copyWith(isLoading: false, splitLocationEntityList: tempList));
  }

  Future<void> updateSplitLocationWithSelectedStorageLocation(
    UpdateSplitLocationEntityWithSelectedLocationEvent event,
    Emitter emit,
  ) async {
    final List<SplitLocationEntity> splitLocationList = List.from(
      state.splitLocationEntityList,
    );
    final int index = splitLocationList.lastIndexWhere(
      (element) => element.id == event.splitLocationEntity.id,
    );
    if (index != -1) {
      splitLocationList.removeAt(index);
      splitLocationList.insert(index, event.splitLocationEntity);
      emit(state.copyWith(splitLocationEntityList: splitLocationList));
    }
  }

  Future<void> updateSplitLocationInTableOnLabelDetailEvent(
    UpdateSplitLocationInTableOnLabelDetailEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final failureOrSuccess = await insertOrUpdateSplitStorageLocationUseCase
        .insertOrUpdateSplitLocationEntity(event.splitLocationEntityList);
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(isLoading: false, goodsReceiptsFailure: some(failure)),
        );
      },
      (success) {
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  Future<void> onChangeSplitLocationQuantityEvent(
    OnChangeSplitLocationQuantityEvent event,
    Emitter emit,
  ) async {
    debugPrint('event.quantity : ${event.quantity}');
    final List<SplitLocationEntity> tempLocationList = List.from(
      state.splitLocationEntityList,
    );
    final int index = tempLocationList.indexWhere(
      (element) => element.id == event.splitLocationEntity.id,
    );
    if (index != -1) {
      final updateLocationEntity = tempLocationList[index].copyWith(
        robQty: event.quantity.toInt(),
        cursorPosition: event.cursorPosition,
        quantity: event.quantity.toDouble(),
      );
      tempLocationList[index] = updateLocationEntity;
      emit(state.copyWith(splitLocationEntityList: tempLocationList));
    }
  }

  Future<void> onDeleteSplitStorageLocationItemByIdEvent(
    DeleteSplitStorageLocationItemByIdEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final failureOrSuccess = await deleteSplitStorageLocationItemByIdUseCase
        .call(
          event.splitLocationEntity,
          event.goodsReceiptPurchaseOrderLineItemEntity,
        );
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(isLoading: false, goodsReceiptsFailure: some(failure)),
        );
      },
      (success) {
        emit(
          state.copyWith(isLoading: false, splitLocationEntityList: success),
        );
      },
    );
  }

  Future<void> onPendingPoSplitLocationUpdateToDbEvent(
    PendingPoSplitLocationUpdateToDbEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final failureOrSuccess = await insertPendingPoSplitLocationDataUseCase(
      insertPendingPoSplitLocationDataParams:
          InsertPendingPoSplitLocationDataParams(
            splitLocationList: event.splitLocationEntityList,
          ),
    );
    failureOrSuccess.fold(
      (failure) {
        // emit(
        //   state.copyWith(isLoading: false, goodsReceiptsFailure: some(failure)),
        // );
      },
      (success) {
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  Future<void> onFetchPendingPoSplitLocationDataEvent(
    FetchPendingPoSplitLocationDataEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true, splitLocationEntityList: []));
    final failureOrSuccess = await getPendingPoSplitLocationDataUseCase(
      getPendingPoSplitLocationDataParams: GetPendingPoSplitLocationDataParams(
        poHdId: event.poHdId,
        poDtId: event.poDtId,
      ),
    );
    failureOrSuccess.fold(
      (failure) {
        // emit(
        //   state.copyWith(isLoading: false, goodsReceiptsFailure: some(failure)),
        // );
      },
      (success) {
        debugPrint("onFetchPendingPoSplitLocationDataEvent success : $success");
        emit(
          state.copyWith(isLoading: false, splitLocationEntityList: success),
        );
      },
    );
  }

  Future<void> onTransactionItemSplitLocationEvent(
    TransactionItemSplitLocationEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true, splitLocationEntityList: []));
    final failureOrSuccess = await getItemSplitLocationDataUseCase(
      getSplitLocationDataParams: GetItemSplitLocationDataParams(
        grnId: event.grnHdId,
        grnDtId: event.grnDtId,
      ),
    );
    failureOrSuccess.fold(
      (failure) {
        // emit(
        //   state.copyWith(isLoading: false, goodsReceiptsFailure: some(failure)),
        // );
      },
      (success) {
        debugPrint("onFetchPendingPoSplitLocationDataEvent success : $success");
        emit(
          state.copyWith(isLoading: false, splitLocationEntityList: success),
        );
      },
    );
  }
}
