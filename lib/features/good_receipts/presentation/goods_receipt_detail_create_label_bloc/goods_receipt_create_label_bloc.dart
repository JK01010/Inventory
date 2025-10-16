import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../common_feature/domain/entities/fetch_imdg_class_entity.dart';
import '../../../common_feature/domain/entities/storage_location_entity.dart';
import '../../domain/entities/goods_receipt_label_entity.dart';
import '../../domain/entities/goods_receipt_purchase_item_detail_entity.dart';
import '../../domain/entities/item_rob_details_entity.dart';
import '../../domain/entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../../domain/failures/goods_receipts_failures.dart';
import '../../domain/use_cases/goods_receipt_create_label_get_label_detail_usecase.dart';
import '../../domain/use_cases/goods_receipt_create_label_get_storage_locations_usecase.dart';
import '../../domain/use_cases/goods_receipt_create_label_save_label_detail_usecase.dart';
import '../../domain/use_cases/grn_location_mapping_use_case.dart';
import '../../domain/use_cases/grn_location_serial_mapping_use_case.dart';
import '../../domain/use_cases/goods_receipts_po_usecase/item_rob_details_usecase.dart';

part 'goods_receipt_create_label_event.dart';

part 'goods_receipt_create_label_state.dart';

class GoodsReceiptCreateLabelBloc
    extends Bloc<GoodsReceiptCreateLabelEvent, GoodsReceiptCreateLabelState> {
  GoodsReceiptCreateLabelBloc({
    required this.goodsReceiptCreateLabelGetLabelDetailUseCase,
    required this.goodsReceiptCreateLabelSaveLabelDetailUseCase,
    required this.goodsReceiptCreateLabelGetStorageLocationsUseCase,
    required this.itemRobDetailsUseCase,
    required this.fetchGRNLocationMappingUseCase,
    required this.fetchGRNLocationSerialMappingUseCase,
  }) : super(GoodsReceiptCreateLabelState.initial()) {
    on<GoodsReceiptCreateLabelEvent>((event, emit) async {
      switch (event) {
        case GoodsReceiptGetLabelDetailById():
          await getGoodsReceiptLabelDetailById(event, emit);
          break;
        case GoodsReceiptCreateLabelSaveEvent():
          await goodsReceiptCreateLabelSaveDetails(event, emit);
          break;
        case OnDamagedQtyUpdateEvent():
          await updateDamagedQtyInBloc(event, emit);
          break;
        case OnReceivedQtyUpdateEvent():
          await updateReceivedQtyInBloc(event, emit);
          break;
        case OnNewStockUpdateEvent():
          await updateNewStockInBloc(event, emit);
          break;
        case OnReConditionedStockUpdateEvent():
          await updateReConditionedStockInBloc(event, emit);
          break;
        case OnQualityUpdateEvent():
          await updateQualityInBloc(event, emit);
          break;
        case OnExpiryDateUpdateEvent():
          await updateExpiryDateInBloc(event, emit);
          break;
        case OnBatchNoUpdateEvent():
          await updateBatchNoInBloc(event, emit);
          break;
        case OnSerialNoUpdateEvent():
          await updateSerialNoInBloc(event, emit);
          break;
        case OnImdgClassIdUpdateEvent():
          await updateImdgClassIdInBloc(event, emit);
          break;
        case OnRemarksUpdateEvent():
          await updateRemarksInBloc(event, emit);
          break;
        case OnDefaultStorageLocationEvent():
          await updateDefaultStorageLocationInBloc(event, emit);
          break;
        case FetchAllStorageLocationsEvent():
          await fetchAllStorageLocations(event, emit);
        case FetchAllImdgClassEvent():
          await fetchAllImdgClasses(event, emit);
        case GenerateAutoNumberCheckboxEvent():
          await updateGenerateSerialNumberList(event, emit);
        case FetchGRNLocationMappingAPIEvent():
          await fetchGRNLocationMappingAPI(event, emit);
          break;
        // case FetchGRNLocationSerialMappingAPIEvent():
        //   await fetchGRNLocationSerialMappingAPI(event, emit);
        //   break;
        case FetchItemRobDetailsEvent():
          await fetchItemRobDetails(event, emit);
        case GetItemDetailEvent():
          await onGetItemDetailsEvent(event, emit);
        case RestInitialData():
          await onResetInitialData(event, emit);
      }
    });

    /// initially triggering the event for GRN Location Mapping and GRN Location Serial Mapping
    add(FetchGRNLocationMappingAPIEvent());
    // add(FetchGRNLocationSerialMappingAPIEvent());
  }

  final GoodsReceiptCreateLabelGetLabelDetailUseCase
  goodsReceiptCreateLabelGetLabelDetailUseCase;
  final GoodsReceiptCreateLabelSaveLabelDetailUseCase
  goodsReceiptCreateLabelSaveLabelDetailUseCase;
  final GoodsReceiptCreateLabelGetStorageLocationsUseCase
  goodsReceiptCreateLabelGetStorageLocationsUseCase;
  final ItemRobDetailsUseCase itemRobDetailsUseCase;
  final FetchGRNLocationMappingUseCase fetchGRNLocationMappingUseCase;
  final FetchGRNLocationSerialMappingUseCase
  fetchGRNLocationSerialMappingUseCase;

  Future<void> updateDamagedQtyInBloc(
    OnDamagedQtyUpdateEvent event,
    Emitter emit,
  ) async {
    state.goodsReceiptPurchaseOrderLineItemEntity?.damagedOrWrongSupply =
        event.damagedOrWrongSupply;
    emit(
      state.copyWith(
        goodsReceiptPurchaseOrderLineItemEntity:
            state.goodsReceiptPurchaseOrderLineItemEntity,
      ),
    );
  }

  Future<void> updateReceivedQtyInBloc(
    OnReceivedQtyUpdateEvent event,
    Emitter emit,
  ) async {
    state.goodsReceiptPurchaseOrderLineItemEntity?.receivedQty =
        event.receivedQty;
    emit(
      state.copyWith(
        goodsReceiptPurchaseOrderLineItemEntity:
            state.goodsReceiptPurchaseOrderLineItemEntity,
      ),
    );
  }

  Future<void> updateNewStockInBloc(
    OnNewStockUpdateEvent event,
    Emitter emit,
  ) async {
    state.goodsReceiptPurchaseOrderLineItemEntity?.newStock = event.newStock;
    emit(
      state.copyWith(
        goodsReceiptPurchaseOrderLineItemEntity:
            state.goodsReceiptPurchaseOrderLineItemEntity,
      ),
    );
  }

  Future<void> updateReConditionedStockInBloc(
    OnReConditionedStockUpdateEvent event,
    Emitter emit,
  ) async {
    state.goodsReceiptPurchaseOrderLineItemEntity?.reconditionedStock =
        event.reconditionedStock;
    emit(
      state.copyWith(
        goodsReceiptPurchaseOrderLineItemEntity:
            state.goodsReceiptPurchaseOrderLineItemEntity,
      ),
    );
  }

  Future<void> updateQualityInBloc(
    OnQualityUpdateEvent event,
    Emitter emit,
  ) async {
    state.goodsReceiptPurchaseOrderLineItemEntity?.qualityId = event.qualityId;
    emit(
      state.copyWith(
        goodsReceiptPurchaseOrderLineItemEntity:
            state.goodsReceiptPurchaseOrderLineItemEntity,
      ),
    );
  }

  Future<void> updateExpiryDateInBloc(
    OnExpiryDateUpdateEvent event,
    Emitter emit,
  ) async {
    state.goodsReceiptPurchaseOrderLineItemEntity?.expiryDate =
        event.expiryDate;
    emit(
      state.copyWith(
        goodsReceiptPurchaseOrderLineItemEntity:
            state.goodsReceiptPurchaseOrderLineItemEntity,
      ),
    );
  }

  Future<void> updateBatchNoInBloc(
    OnBatchNoUpdateEvent event,
    Emitter emit,
  ) async {
    state.goodsReceiptPurchaseOrderLineItemEntity?.batchNo = event.batchNo;
    emit(
      state.copyWith(
        goodsReceiptPurchaseOrderLineItemEntity:
            state.goodsReceiptPurchaseOrderLineItemEntity,
      ),
    );
  }

  Future<void> updateSerialNoInBloc(
    OnSerialNoUpdateEvent event,
    Emitter emit,
  ) async {
    state.goodsReceiptPurchaseOrderLineItemEntity?.articleNo = event.articleNo;
    emit(
      state.copyWith(
        goodsReceiptPurchaseOrderLineItemEntity:
            state.goodsReceiptPurchaseOrderLineItemEntity,
      ),
    );
  }

  Future<void> updateImdgClassIdInBloc(
    OnImdgClassIdUpdateEvent event,
    Emitter emit,
  ) async {
    state.goodsReceiptPurchaseOrderLineItemEntity?.imdgClassId =
        event.fetchImdgClassEntity.id;
    emit(
      state.copyWith(
        goodsReceiptPurchaseOrderLineItemEntity:
            state.goodsReceiptPurchaseOrderLineItemEntity,
      ),
    );
  }

  Future<void> updateRemarksInBloc(
    OnRemarksUpdateEvent event,
    Emitter emit,
  ) async {
    state.goodsReceiptPurchaseOrderLineItemEntity?.remarks = event.remarks;
    emit(
      state.copyWith(
        goodsReceiptPurchaseOrderLineItemEntity:
            state.goodsReceiptPurchaseOrderLineItemEntity,
      ),
    );
  }

  Future<void> updateDefaultStorageLocationInBloc(
    OnDefaultStorageLocationEvent event,
    Emitter emit,
  ) async {
    state.goodsReceiptPurchaseOrderLineItemEntity?.className =
        event.storageLocationEntity.code;
    emit(
      state.copyWith(
        goodsReceiptPurchaseOrderLineItemEntity:
            state.goodsReceiptPurchaseOrderLineItemEntity,
      ),
    );
  }

  Future<void> getGoodsReceiptLabelDetailById(
    GoodsReceiptGetLabelDetailById event,
    Emitter<GoodsReceiptCreateLabelState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 2));
    final failureOrSuccess = await goodsReceiptCreateLabelGetLabelDetailUseCase
        .getGoodsReceiptLabelDetail(event.dtId, event.hdId, event.itemId);
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
            goodsReceiptPurchaseOrderLineItemEntity: success,
            isLoading: false,
          ),
        );
      },
    );
  }

  Future<void> goodsReceiptCreateLabelSaveDetails(
    GoodsReceiptCreateLabelSaveEvent event,
    Emitter<GoodsReceiptCreateLabelState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 2));
    final failureOrSuccess = await goodsReceiptCreateLabelSaveLabelDetailUseCase
        .goodsReceiptCreateLabelSaveDetail(
          event.goodsReceiptPurchaseOrderLineItemEntity,
        );
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(
            getGoodsReceiptsLabelDetailFailure: some(failure),
            isLoading: false,
            isInitialLoad: true,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            // goodsReceiptPurchaseOrderLineItemEntity: success,
            isInitialLoad: false,
            isLoading: false,
            isSaveSuccess: true,
          ),
        );
        emit(state.copyWith(isSaveSuccess: false));
      },
    );
  }

  Future<void> fetchAllStorageLocations(
    FetchAllStorageLocationsEvent event,
    Emitter emit,
  ) async {
    final failureOrSuccess =
        await goodsReceiptCreateLabelGetStorageLocationsUseCase
            .getAllStorageLocations();
    failureOrSuccess.fold(
      (failure) {
        emit(state.copyWith(getGoodsReceiptsLabelDetailFailure: some(failure)));
      },
      (success) {
        emit(state.copyWith(storageLocationEntityList: success));
      },
    );
  }

  Future<void> fetchAllImdgClasses(
    FetchAllImdgClassEvent event,
    Emitter emit,
  ) async {
    // final failureOrSuccess =
    //     await goodsReceiptCreateLabelGetImdgClassesUseCase.getAllImdgClasses();
    // failureOrSuccess.fold(
    //   (failure) {
    //     emit(state.copyWith(getGoodsReceiptsLabelDetailFailure: some(failure)));
    //   },
    //   (success) {
    //     emit(state.copyWith(fetchImdgClassList: success));
    //   },
    // );
  }

  Future<void> updateGenerateSerialNumberList(
    GenerateAutoNumberCheckboxEvent event,
    Emitter emit,
  ) async {
    String vesselName = "VESSEL";
    List<String> serialNoList = [];

    for (int i = 1; i <= 10; i++) {
      serialNoList.add('$vesselName - 00 $i');
    }

    emit(
      state.copyWith(
        isAutoSerialNumber: event.isAutoGenerateNumberEnabled,
        autoSerialNumberList: serialNoList,
      ),
    );
  }

  Future<void> fetchGRNLocationMappingAPI(
    FetchGRNLocationMappingAPIEvent event,
    Emitter emit,
  ) async {
    final failureOrSuccess = await fetchGRNLocationMappingUseCase();

    failureOrSuccess.fold(
      (failure) {
        debugPrint("GRNLocationMapping failure $failure");
      },
      (success) {
        debugPrint("GRNLocationMapping success $success");
      },
    );
  }

  // Future<void> fetchGRNLocationSerialMappingAPI(
  //   FetchGRNLocationSerialMappingAPIEvent event,
  //   Emitter emit,
  // ) async {
  //   final failureOrSuccess = await fetchGRNLocationSerialMappingUseCase();
  //
  //   failureOrSuccess.fold(
  //     (failure) {
  //       debugPrint("GRNLocationSerialMapping failure $failure");
  //     },
  //     (success) {
  //       debugPrint("GRNLocationSerialMapping success $success");
  //     },
  //   );
  // }

  Future<void> fetchItemRobDetails(
    FetchItemRobDetailsEvent event,
    Emitter<GoodsReceiptCreateLabelState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final failureOrSuccess = await itemRobDetailsUseCase(itemID: event.itemId);
    debugPrint("Item rob details in bloc:::::$failureOrSuccess");

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
        emit(state.copyWith(itemRobDetailsList: success, isLoading: false));
      },
    );
  }

  Future<void> onGetItemDetailsEvent(
    GetItemDetailEvent event,
    Emitter<GoodsReceiptCreateLabelState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 2));
    emit(
      state.copyWith(
        goodsReceiptPurchaseOrderLineItemEntity:
            event.getGoodsReceiptPurchaseOrderLineItemEntity,
        isLoading: false,
      ),
    );
  }

  Future<void> onResetInitialData(
    RestInitialData event,
    Emitter<GoodsReceiptCreateLabelState> emit,
  ) async {
    emit(GoodsReceiptCreateLabelState.initial());
  }
}
