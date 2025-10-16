import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../core/utils/app_logger.dart';
import '../../../../good_receipts/domain/entities/goods_receipt_purchase_item_detail_entity.dart';
import '../../../../good_receipts/domain/entities/split_location_entity.dart';
import '../../../../good_receipts/domain/failures/goods_receipts_failures.dart';
import '../../../../good_receipts/domain/use_cases/delete_split_storage_location_item_by_id_use_case.dart';
import '../../../../good_receipts/domain/use_cases/get_split_location_by_purchase_item_detail_usecase.dart';
import '../../../../good_receipts/domain/use_cases/insert_or_update_split_storage_location_usecase.dart';

part 'bagging_tagging_split_location_event.dart';
part 'bagging_tagging_split_location_state.dart';

class BaggingTaggingSplitLocationBloc
    extends
        Bloc<
          BaggingTaggingSplitLocationEvent,
          BaggingTaggingSplitLocationState
        > {
  BaggingTaggingSplitLocationBloc({
    required this.getSplitLocationByPurchaseItemDetailUseCase,
    required this.insertOrUpdateSplitStorageLocationUseCase,
    required this.deleteSplitStorageLocationItemByIdUseCase,
  }) : super(BaggingTaggingSplitLocationState.initial()) {
    on<BaggingTaggingSplitLocationEvent>((event, emit) async {
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
      }
    });
  }

  GetSplitLocationByPurchaseItemDetailUseCase
  getSplitLocationByPurchaseItemDetailUseCase;
  InsertOrUpdateSplitStorageLocationUseCase
  insertOrUpdateSplitStorageLocationUseCase;
  DeleteSplitStorageLocationItemByIdUseCase
  deleteSplitStorageLocationItemByIdUseCase;

  Future<void> fetchSplitStorageLocationByPurchaseItemDetailEntity(
    FetchSplitStorageLocationByPurchaseItemDetailEntity event,
    Emitter<BaggingTaggingSplitLocationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    // TODO Commented for the GRPOLineItem model change
    // final failureOrSuccess = await getSplitLocationByPurchaseItemDetailUseCase
    //     .getSplitLocationByPurchaseItemDetail(
    //       event.baggingTaggingPurchaseItemDetailEntity,
    //     );
    // failureOrSuccess.fold(
    //   (failure) {
    //     emit(
    //       state.copyWith(isLoading: false, goodsReceiptsFailure: some(failure)),
    //     );
    //   },
    //   (success) {
    //     emit(
    //       state.copyWith(isLoading: false, splitLocationEntityList: success),
    //     );
    //   },
    // );
  }

  Future<void> addEmptyStorageLocationWidget(
    AddEmptySplitStorageLocationWidgetEvent event,
    Emitter emit,
  ) async {
    // SplitLocationEntity splitLocationEntity = SplitLocationEntity(
    //   id: DateTime.now().millisecondsSinceEpoch,
    //   itemId: event.itemId,
    //   locationId: 0,
    //   poId: '${event.poId}',
    //   robQty: 0,
    //   poDtId: '${event.poDtId}',
    //   quantityType: event.itemType,
    //   transactionId: '',
    //   locationName: '',
    //   grnDtId:
    // );
    // List<SplitLocationEntity> tempList =
    //     state.splitLocationEntityList..add(splitLocationEntity);
    // debugPrint("tempList Length: ${tempList.length}");
    // emit(
    //   state.copyWith(
    //     isLoading: !state.isLoading,
    //     splitLocationEntityList: tempList,
    //   ),
    // );
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
    final List<SplitLocationEntity> tempLocationList = List.from(
      state.splitLocationEntityList,
    );
    final int index = tempLocationList.indexWhere(
      (element) => element.id == event.splitLocationEntity.id,
    );
    if (index != -1) {
      final updateLocationEntity = tempLocationList[index].copyWith(
        robQty: event.quantity,
      );
      tempLocationList[index] = updateLocationEntity;
      emit(state.copyWith(splitLocationEntityList: tempLocationList));
    }
  }
}
