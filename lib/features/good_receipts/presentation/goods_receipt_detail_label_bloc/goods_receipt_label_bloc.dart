import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/app_logger.dart';
import '../../domain/entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../../domain/entities/grn_create_label_entity.dart';
import '../../domain/failures/goods_receipts_failures.dart';
import '../../domain/use_cases/create_new_label_list_and_update_goods_receipt_label_list_using_poid_use_case.dart';
import '../../domain/use_cases/delete_goods_receipts_label_item_by_id_use_case.dart';
import '../../domain/use_cases/get_all_item_list_to_create_new_label_usecase.dart';
import '../../domain/use_cases/get_goods_receipt_label_detail_usecase.dart';
import '../../domain/use_cases/grn_create_label_usecase.dart';
import '../../domain/use_cases/insert_goods_receipts_detail_label_usecase.dart';
import '../../domain/use_cases/update_goods_receipt_detail_label_list_use_case.dart';

part 'goods_receipt_label_event.dart';
part 'goods_receipt_label_state.dart';

class GoodsReceiptLabelBloc
    extends Bloc<GoodsReceiptLabelEvent, GoodsReceiptLabelState> {
  GoodsReceiptLabelBloc({
    required this.insertGoodsReceiptsDetailLabelUseCase,
    required this.getGoodsReceiptLabelDetailUseCase,
    required this.updateGoodsReceiptDetailLabelListUseCase,
    required this.deleteGoodsReceiptsLabelItemByIdUseCase,
    required this.getAllItemListToCreateNewLabelUseCase,
    required this.createNewLabelListAndUpdateGoodsReceiptLabelListUsingPoIdUseCase,
    required this.grnCreateLabelUseCase,
  }) : super(GoodsReceiptLabelState.initial()) {
    on<GoodsReceiptLabelEvent>((event, emit) async {
      switch (event) {
        case InsertGoodsReceiptsLabelEvent():
          await insertGoodsReceiptsLabelItems();
          return;
        case GetGoodsReceiptsLabelEventForPOId():
          await getGoodsReceiptsLabelItems(event, emit);
        case UpdateGoodsReceiptDetailLabelListForDraftEvent():
          await updateGoodsReceiptsLabelListForDraftEvent(event, emit);
        case DeleteGoodsReceiptsLabelItemByIdEvent():
          await deleteGoodsReceiptsLabelItemById(event, emit);
        case GetAllGRLabelItemListToCreateLabelEvent():
          await getAllGRLabelItemsToCreateLabel(event, emit);
        case UpdateCheckBoxSelectedStatusEvent():
          await updateCheckBoxSelectedStatus(event, emit);
        case AddItemsToUpdateCreateLabelItemsListForSelectedPOEvent():
          await addItemsToUpdateCreateLabelItemsListForSelectedPO(event, emit);
        case GRNCreateLabelEvent():
          await grnCreateLabel(event, emit);
          break;
      }
    });
  }

  final InsertGoodsReceiptsDetailLabelUseCase
  insertGoodsReceiptsDetailLabelUseCase;
  final GetGoodsReceiptLabelDetailUseCase getGoodsReceiptLabelDetailUseCase;
  final UpdateGoodsReceiptDetailLabelListUseCase
  updateGoodsReceiptDetailLabelListUseCase;
  final DeleteGoodsReceiptsLabelItemByIdUseCase
  deleteGoodsReceiptsLabelItemByIdUseCase;
  final GetAllItemListToCreateNewLabelUseCase
  getAllItemListToCreateNewLabelUseCase;
  final CreateNewLabelListAndUpdateGoodsReceiptLabelListUsingPoIdUseCase
  createNewLabelListAndUpdateGoodsReceiptLabelListUsingPoIdUseCase;
  final GRNCreateLabelUseCase grnCreateLabelUseCase;

  Future<void> insertGoodsReceiptsLabelItems() async {
    await insertGoodsReceiptsDetailLabelUseCase();
  }

  Future<void> getGoodsReceiptsLabelItems(
    GetGoodsReceiptsLabelEventForPOId event,
    Emitter<GoodsReceiptLabelState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 2));
    final failureOrSuccess = await getGoodsReceiptLabelDetailUseCase
        .getGoodsReceiptDetailLabelItems(event.poId);
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(
            getGoodsReceiptsLabelDetailFailure: some(failure),
            isLoading: false,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            goodsReceiptPurchaseOrderLineItemEntityList: success,
            isLoading: false,
          ),
        );
      },
    );
  }

  Future<void> updateGoodsReceiptsLabelListForDraftEvent(
    UpdateGoodsReceiptDetailLabelListForDraftEvent event,
    Emitter<GoodsReceiptLabelState> emit,
  ) async {
    final failureOrSuccess = await updateGoodsReceiptDetailLabelListUseCase
        .call(event.goodsReceiptPurchaseOrderLineItemEntityList);
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(
            getGoodsReceiptsLabelDetailFailure: some(failure),
            isLoading: false,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            goodsReceiptPurchaseOrderLineItemEntityList: success,
            isLoading: false,
          ),
        );
      },
    );
  }

  Future<void> deleteGoodsReceiptsLabelItemById(
    DeleteGoodsReceiptsLabelItemByIdEvent event,
    Emitter<GoodsReceiptLabelState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 2));
    final failureOrSuccess = await deleteGoodsReceiptsLabelItemByIdUseCase.call(
      event.goodsReceiptPurchaseOrderLineItemEntity,
    );
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(
            getGoodsReceiptsLabelDetailFailure: some(failure),
            isLoading: false,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            goodsReceiptPurchaseOrderLineItemEntityList: success,
            isLoading: false,
          ),
        );
      },
    );
  }

  Future<void> getAllGRLabelItemsToCreateLabel(
    GetAllGRLabelItemListToCreateLabelEvent event,
    Emitter<GoodsReceiptLabelState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final failureOrSuccess = await getAllItemListToCreateNewLabelUseCase
        .getAllGoodsReceiptDetailLabelItemsToCreateNewLabel(event.poId);
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(
            getGoodsReceiptsLabelDetailFailure: some(failure),
            isLoading: false,
          ),
        );
      },
      (success) {
        Future.delayed(Duration(seconds: 5));
        emit(
          state.copyWith(
            goodsReceiptPurchaseOrderLineItemEntityList: success,
            isLoading: false,
          ),
        );
      },
    );
  }

  Future<void> updateCheckBoxSelectedStatus(
    UpdateCheckBoxSelectedStatusEvent event,
    Emitter<GoodsReceiptLabelState> emit,
  ) async {
    final List<GoodsReceiptPurchaseOrderLineItemEntity>
    currentGoodsReceiptPurchaseItemDetailEntityList = List.from(
      state.purchaseItemToCreateNewLabelEntityList,
    );
    final updatedListItem =
        currentGoodsReceiptPurchaseItemDetailEntityList[event.index].copyWith(
          isSelected: event.isSelectedValue,
        );
    currentGoodsReceiptPurchaseItemDetailEntityList[event.index] =
        updatedListItem;
    emit(
      state.copyWith(
        purchaseItemToCreateNewLabelEntityList:
            currentGoodsReceiptPurchaseItemDetailEntityList,
      ),
    );
  }

  Future<void> addItemsToUpdateCreateLabelItemsListForSelectedPO(
    AddItemsToUpdateCreateLabelItemsListForSelectedPOEvent event,
    Emitter<GoodsReceiptLabelState> emit,
  ) async {
    final failureOrSuccess =
        await createNewLabelListAndUpdateGoodsReceiptLabelListUsingPoIdUseCase
            .call(
              event.goodsReceiptPurchaseOrderLineItemEntityList,
              event.poId,
            );
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(
            getGoodsReceiptsLabelDetailFailure: some(failure),
            isLoading: false,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            goodsReceiptPurchaseOrderLineItemEntityList: success,
            isLoading: false,
          ),
        );
      },
    );
  }

  Future<void> grnCreateLabel(
    GRNCreateLabelEvent event,
    Emitter<GoodsReceiptLabelState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final failureOrSuccess = await grnCreateLabelUseCase.createGRNLabel(
      event.grnId,
      event.itemIds,
    );

    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(
            getGoodsReceiptsLabelDetailFailure: some(failure),
            isLoading: false,
          ),
        );
      },
      (success) {
        debugPrint("event::::${event.grnId}");
        emit(
          state.copyWith(
            isLoading: false,
            // assuming you want to store the list of labels in state
            grnCreateLabelList: success,
            getGoodsReceiptsLabelDetailFailure: none(),
          ),
        );
      },
    );
  }
}
