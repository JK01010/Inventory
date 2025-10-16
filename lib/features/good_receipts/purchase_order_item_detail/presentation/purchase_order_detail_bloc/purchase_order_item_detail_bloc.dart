import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common_feature/domain/entities/fetch_imdg_class_entity.dart';
import '../../../domain/entities/split_location_entity.dart';
import '../../domain/entity/serial_number_entity.dart';
import '../../domain/use_cases/generate_serial_numbers_usecase.dart';
import '../../domain/use_cases/get_imdg_class_db_usecase.dart';
import '../../domain/use_cases/get_purchase_order_item_serial_number_usecase.dart';
import '../../domain/use_cases/get_purchase_order_item_split_location_data.dart';
import '../../domain/use_cases/update_purchase_order_item_usecase.dart';
import 'purchase_order_item_detail_bloc_event.dart';
import 'purchase_order_item_detail_bloc_state.dart';

class PurchaseOrderItemDetailBloc
    extends
        Bloc<
          PurchaseOrderItemDetailBlocEvent,
          PurchaseOrderItemDetailBlocState
        > {
  PurchaseOrderItemDetailBloc({
    required this.getImdgClassListDbUseCase,
    required this.updatePurchaseOrderItemDataUseCase,
    required this.getPurchaseOrderItemSplitLocationDataUseCase,
    required this.generateSerialNumbersUseCase,
    required this.getPurchaseOrderItemSerialNumberUseCase,
  }) : super(PurchaseOrderItemDetailBlocState.initial()) {
    on<PurchaseOrderItemDetailBlocEvent>((event, emit) async {
      switch (event) {
        case SetInitialDataEvent():
          await onSetInitialDataEvent(event, emit);
          break;
        case AddSplitLocationEvent():
          onAddSplitLocationEvent(event, emit);
          break;
        case SplitLocationChangeEvent():
          onSplitLocationChangeEvent(event, emit);
          break;
        case SplitLocationQuantityChangeEvent():
          onSplitLocationQuantityChangeEvent(event, emit);
          break;
        case PurchaseOrderItemDetailTextFieldChangeEvent():
          onPurchaseOrderItemDetailTextFieldChangeEvent(event, emit);
          break;
        case PurchaseOrderItemQualityChangeEvent():
          onPurchaseOrderItemQualityChangeEvent(event, emit);
          break;
        case PurchaseOrderItemImdgClassChangeEvent():
          onPurchaseOrderItemImdgClassChangeEvent(event, emit);
          break;
        case SavePurchaseOrderItemDetailEvent():
          await onSavePurchaseOrderItemDetailEvent(event, emit);
          break;
        case GenerateSerialNumbersEvent():
          await onGenerateSerialNumbersEvent(event, emit);
          break;
        case SaveSerialNumbersEvent():
          await onSaveSerialNumbersEvent(event, emit);
          break;
      }
    });
  }

  final GetImdgClassListDbUseCase getImdgClassListDbUseCase;
  final UpdatePurchaseOrderItemDataUseCase updatePurchaseOrderItemDataUseCase;
  final GetPurchaseOrderItemSplitLocationDataUseCase
  getPurchaseOrderItemSplitLocationDataUseCase;
  final GenerateSerialNumbersUseCase generateSerialNumbersUseCase;
  final GetPurchaseOrderItemSerialNumberUseCase
  getPurchaseOrderItemSerialNumberUseCase;

  Future<void> onSetInitialDataEvent(
    SetInitialDataEvent event,
    Emitter<PurchaseOrderItemDetailBlocState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        isGeneratingSerialNumber: false,
        validationError: false,
        validationMessage: '',
      ),
    );
    final imdgClassResult = await getImdgClassListDbUseCase();
    final List<ImdgClassEntity> imdgClassList =
        imdgClassResult.getRight().toNullable() ?? [];
    final splitLocationResult =
        await getPurchaseOrderItemSplitLocationDataUseCase(
          getPurchaseOrderItemSplitLocationDataParams:
              GetPurchaseOrderItemSplitLocationDataParams(
                poHdId: event.purchaseOrderEntity.poHdId,
                poDtId: event.itemEntity.poDtId,
              ),
        );
    final List<SplitLocationEntity> splitLocationList =
        splitLocationResult.getRight().toNullable() ?? [];
    final serialNumbersResult = await getPurchaseOrderItemSerialNumberUseCase(
      getPurchaseOrderItemSerialNumberParams:
          GetPurchaseOrderItemSerialNumberParams(
            poHdId: event.purchaseOrderEntity.poHdId,
            poDtId: event.itemEntity.poDtId,
          ),
    );
    final List<SerialNumberEntity> serialNumbersList =
        serialNumbersResult.getRight().toNullable() ?? [];
    debugPrint("serialNumbersList.length : ${serialNumbersList.length}");
    if (splitLocationList.isNotEmpty && serialNumbersList.isNotEmpty) {
      for (var element in splitLocationList) {
        element.serialNumbers =
            serialNumbersList
                .where(
                  (serialNumber) => serialNumber.splitLocationId == element.id,
                )
                .toList();
      }
    }
    emit(
      state.copyWith(
        isLoading: false,
        itemEntity: event.itemEntity,
        purchaseOrderData: event.purchaseOrderEntity,
        splitLocationEntity: splitLocationList,
        imdgClassList: imdgClassList,
        isSaveSuccess: false,
        allSerialNumbers: [],
      ),
    );
  }

  void onAddSplitLocationEvent(
    AddSplitLocationEvent event,
    Emitter<PurchaseOrderItemDetailBlocState> emit,
  ) {
    debugPrint("event.itemTypeId: ${event.itemTypeId}");
    final List<SplitLocationEntity> splitLocationList = List.from(
      state.splitLocationEntity,
    )..add(
      SplitLocationEntity.initial().copyWith(
        id: DateTime.now().microsecondsSinceEpoch,
        itemId: state.itemEntity.itemId,
        poId: state.purchaseOrderData.poHdId,
        isActive: true,
        typeId: event.itemTypeId,
        quantity: 0,
        poDtId: state.itemEntity.poDtId,
      ),
    );
    emit(
      state.copyWith(isLoading: false, splitLocationEntity: splitLocationList),
    );
  }

  void onSplitLocationChangeEvent(
    SplitLocationChangeEvent event,
    Emitter<PurchaseOrderItemDetailBlocState> emit,
  ) {
    final List<SplitLocationEntity> splitLocationList = List.from(
      state.splitLocationEntity,
    );
    int index = splitLocationList.indexWhere(
      (element) => element.id == event.splitLocationEntity.id,
    );
    if (index != -1) {
      final SplitLocationEntity selectedSplitLocation =
          splitLocationList[index];
      final updatedSplitLocation = selectedSplitLocation.copyWith(
        locationName: event.data["location_name"],
        locationId: event.data["location_id"],
      );
      splitLocationList[index] = updatedSplitLocation;
      emit(
        state.copyWith(
          isLoading: false,
          splitLocationEntity: splitLocationList,
        ),
      );
    }
  }

  void onSplitLocationQuantityChangeEvent(
    SplitLocationQuantityChangeEvent event,
    Emitter<PurchaseOrderItemDetailBlocState> emit,
  ) {
    final newQuantity = double.parse(event.newQuantity);
    final List<SplitLocationEntity> splitLocationList = List.from(
      state.splitLocationEntity,
    );

    final List<SerialNumberEntity> currentAllSerialNumbers =
        List<SerialNumberEntity>.from(state.allSerialNumbers);
    debugPrint(
      "currentAllSerialNumbers before : ${currentAllSerialNumbers.length}",
    );

    int index = splitLocationList.indexOf(event.splitLocationEntity);
    if (index != -1) {
      final SplitLocationEntity selectedSplitLocation =
          splitLocationList[index];
      List<SerialNumberEntity>? updatedSerialNumbers;
      if (selectedSplitLocation.serialNumbers.isNotEmpty &&
          newQuantity < selectedSplitLocation.serialNumbers.length) {
        final currentSerialNumbers = List<SerialNumberEntity>.from(
          selectedSplitLocation.serialNumbers,
        );
        final splitIndex =
            (currentSerialNumbers.length - newQuantity)
                .clamp(0, currentSerialNumbers.length)
                .toInt();
        debugPrint("splitIndex : $splitIndex");
        final remaining = currentSerialNumbers.sublist(0, splitIndex);
        final removed = currentSerialNumbers.sublist(splitIndex);
        currentAllSerialNumbers.addAll(removed);
        updatedSerialNumbers = List<SerialNumberEntity>.from(remaining);
      }
      debugPrint(
        "currentAllSerialNumbers after : ${currentAllSerialNumbers.length}",
      );
      final updatedSplitLocation = selectedSplitLocation.copyWith(
        quantity: newQuantity,
        serialNumbers: updatedSerialNumbers,
      );
      debugPrint("updatedSplitLocation : ${updatedSplitLocation.quantity}");
      splitLocationList[index] = updatedSplitLocation;
      emit(
        state.copyWith(
          splitLocationEntity: splitLocationList,
          allSerialNumbers: currentAllSerialNumbers,
        ),
      );
    }
  }

  void onPurchaseOrderItemDetailTextFieldChangeEvent(
    PurchaseOrderItemDetailTextFieldChangeEvent event,
    Emitter<PurchaseOrderItemDetailBlocState> emit,
  ) {
    switch (event.purchaseOrderItemDetailTextFieldType) {
      case PurchaseOrderItemDetailTextFieldType.receivedQty:
        final updatedItemEntity = state.itemEntity.copyWith(
          receivedQuantity: double.parse(event.newValue),
        );
        emit(state.copyWith(itemEntity: updatedItemEntity));
        break;
      case PurchaseOrderItemDetailTextFieldType.damagedQty:
        final updatedItemEntity = state.itemEntity.copyWith(
          damagedQuantity: double.parse(event.newValue),
        );
        emit(state.copyWith(itemEntity: updatedItemEntity));
        break;
      case PurchaseOrderItemDetailTextFieldType.newStockQty:
        final updatedItemEntity = state.itemEntity.copyWith(
          newStockQuantity: double.parse(event.newValue),
        );
        emit(state.copyWith(itemEntity: updatedItemEntity));
        break;
      case PurchaseOrderItemDetailTextFieldType.reconditionedQty:
        final updatedItemEntity = state.itemEntity.copyWith(
          reconditionedStock: double.parse(event.newValue),
        );
        emit(state.copyWith(itemEntity: updatedItemEntity));
        break;
      case PurchaseOrderItemDetailTextFieldType.expiryDate:
        final updatedItemEntity = state.itemEntity.copyWith(
          expiryDate: event.newValue,
        );
        emit(state.copyWith(itemEntity: updatedItemEntity));
        break;
      case PurchaseOrderItemDetailTextFieldType.remarks:
        final updatedItemEntity = state.itemEntity.copyWith(
          remarks: event.newValue,
        );
        emit(state.copyWith(itemEntity: updatedItemEntity));
        break;
    }
  }

  void onPurchaseOrderItemQualityChangeEvent(
    PurchaseOrderItemQualityChangeEvent event,
    Emitter<PurchaseOrderItemDetailBlocState> emit,
  ) {
    final updatedItemEntity = state.itemEntity.copyWith(
      qualityId: event.newQuality,
    );
    emit(state.copyWith(itemEntity: updatedItemEntity));
  }

  void onPurchaseOrderItemImdgClassChangeEvent(
    PurchaseOrderItemImdgClassChangeEvent event,
    Emitter<PurchaseOrderItemDetailBlocState> emit,
  ) {
    final updatedItemEntity = state.itemEntity.copyWith(
      imdgClass: event.imdgClassEntity.code,
    );
    emit(state.copyWith(itemEntity: updatedItemEntity));
  }

  Future<void> onSavePurchaseOrderItemDetailEvent(
    SavePurchaseOrderItemDetailEvent event,
    Emitter<PurchaseOrderItemDetailBlocState> emit,
  ) async {
    if (state.itemEntity.receivedQuantity == 0 ||
        state.itemEntity.receivedQuantity == -1) {
      showValidationError(emit, 'Received Quantity should not be zero');
      return;
    }

    if (state.itemEntity.receivedQuantity > state.itemEntity.poQuantity) {
      showValidationError(
        emit,
        'Received Quantity should be less than Quantity',
      );
      return;
    }

    if (((state.itemEntity.damagedQuantity == -1
                ? 0
                : state.itemEntity.damagedQuantity) +
            (state.itemEntity.reconditionedStock == 1
                ? 0
                : state.itemEntity.reconditionedStock) +
            (state.itemEntity.newStockQuantity == -1
                ? 0
                : state.itemEntity.newStockQuantity)) !=
        state.itemEntity.receivedQuantity) {
      showValidationError(
        emit,
        "Total quantity of Damaged, Reconditioned, and New Stock must be equal to Received Quantity",
      );
      return;
    }
    if ((state.itemEntity.damagedQuantity > 0 ||
            state.itemEntity.newStockQuantity > 0 ||
            state.itemEntity.reconditionedStock > 0) &&
        state.splitLocationEntity.isEmpty) {
      showValidationError(emit, "Add split storage location");
      return;
    }
    final List<SplitLocationEntity> damagedSplitLocationData =
        state.splitLocationEntity
            .where((element) => element.typeId == 1 && element.quantity > 0)
            .toList();
    final List<SplitLocationEntity> newStockQuantitySplitLocationData =
        state.splitLocationEntity
            .where((element) => element.typeId == 2 && element.quantity > 0)
            .toList();
    final List<SplitLocationEntity> reConditionSplitLocationData =
        state.splitLocationEntity
            .where((element) => element.typeId == 3 && element.quantity > 0)
            .toList();

    if (state.itemEntity.damagedQuantity != 0 &&
        damagedSplitLocationData.isNotEmpty &&
        state.itemEntity.damagedQuantity !=
            damagedSplitLocationData
                .map((element) => element.quantity)
                .toList()
                .reduce((value, element) => value + element)) {
      showValidationError(
        emit,
        "Damage Split Location Quantity should be equal to Damaged Quantity",
      );
      return;
    }

    if (state.itemEntity.newStockQuantity != 0 &&
        newStockQuantitySplitLocationData.isNotEmpty &&
        state.itemEntity.newStockQuantity !=
            newStockQuantitySplitLocationData
                .map((element) => element.quantity)
                .toList()
                .reduce((value, element) => value + element)) {
      showValidationError(
        emit,
        "New Quantity Split Location Quantity should be equal to New Stock Quantity",
      );
      return;
    }

    if (state.itemEntity.reconditionedStock != 0 &&
        reConditionSplitLocationData.isNotEmpty &&
        state.itemEntity.reconditionedStock !=
            reConditionSplitLocationData
                .map((element) => element.quantity)
                .toList()
                .reduce((value, element) => value + element)) {
      showValidationError(
        emit,
        "Reconditioned Stock Quantity Split Location Quantity should be equal to Reconditioned Stock Quantity",
      );
      return;
    }

    if (state.splitLocationEntity.any(
      (element) => element.locationId == 0 || element.locationId == -1,
    )) {
      showValidationError(emit, "Choose storage locations");
      return;
    }
    emit(state.copyWith(isLoading: true));
    final UpdatePurchaseOrderItemDataParams updatePurchaseOrderItemDataParams =
        UpdatePurchaseOrderItemDataParams(
          itemEntity: state.itemEntity,
          purchaseOrderEntity: state.purchaseOrderData,
          splitLocationData:
              state.splitLocationEntity
                  .where((element) => element.quantity > 0)
                  .toList(),
        );
    final updateResult = await updatePurchaseOrderItemDataUseCase(
      updatePurchaseOrderItemDataParams: updatePurchaseOrderItemDataParams,
    );
    emit(state.copyWith(isLoading: false));
    // debugPrint("!!!!!!!!!!!!!!!!!!!!!");
    updateResult.fold(
      (l) {
        emit(state.copyWith(isLoading: false));
      },
      (r) {
        emit(state.copyWith(isLoading: false, isSaveSuccess: true));
        emit(state.copyWith(isSaveSuccess: false));
      },
    );
  }

  Future<void> onGenerateSerialNumbersEvent(
    GenerateSerialNumbersEvent event,
    Emitter<PurchaseOrderItemDetailBlocState> emit,
  ) async {
    emit(state.copyWith(isGeneratingSerialNumber: true));
    List<SerialNumberEntity> requiredSerialNumbers = [];
    List<SerialNumberEntity> currentAllSerialNumbers =
        List<SerialNumberEntity>.from(state.allSerialNumbers);
    debugPrint("currentAllSerialNumbers : ${currentAllSerialNumbers.length}");
    if (currentAllSerialNumbers.isEmpty) {
      final generateSerialNumbersResult = await generateSerialNumbersUseCase(
        generateSerialNumberParams: GenerateSerialNumberParams(
          quantity: event.quantity,
          id: state.purchaseOrderData.poHdId,
          itemId: state.itemEntity.poDtId,
          isTransaction: false,
          typeId: event.splitLocationEntity.typeId,
          splitLocationId: event.splitLocationEntity.id,
        ),
      );
      requiredSerialNumbers =
          generateSerialNumbersResult.getRight().toNullable() ?? [];
      currentAllSerialNumbers.addAll(requiredSerialNumbers);
    } else {
      int extraNeededCount =
          event.quantity.toInt() - currentAllSerialNumbers.length;
      debugPrint("extraNeededCount : $extraNeededCount");
      if (extraNeededCount > 0) {
        final generateSerialNumbersResult = await generateSerialNumbersUseCase(
          generateSerialNumberParams: GenerateSerialNumberParams(
            quantity: extraNeededCount.toDouble(),
            id: state.purchaseOrderData.poHdId,
            itemId: state.itemEntity.poDtId,
            isTransaction: false,
            typeId: event.splitLocationEntity.typeId,
            splitLocationId: event.splitLocationEntity.id,
          ),
        );
        final newlyGeneratedSerialNumbers =
            generateSerialNumbersResult.getRight().toNullable() ?? [];
        currentAllSerialNumbers.addAll(newlyGeneratedSerialNumbers);
      }
      requiredSerialNumbers = currentAllSerialNumbers.sublist(
        0,
        event.quantity.toInt(),
      );
    }

    List<SplitLocationEntity> currentSplitLocations =
        List<SplitLocationEntity>.from(state.splitLocationEntity);
    final selectedSplitLocation = event.splitLocationEntity;
    final int selectedItemIndex = currentSplitLocations.indexOf(
      selectedSplitLocation,
    );
    if (selectedItemIndex != -1) {
      final updatedSplitLocation = selectedSplitLocation.copyWith(
        serialNumbers: requiredSerialNumbers,
      );
      currentSplitLocations[selectedItemIndex] = updatedSplitLocation;
      emit(
        state.copyWith(
          isGeneratingSerialNumber: false,
          splitLocationEntity: currentSplitLocations,
          allSerialNumbers: currentAllSerialNumbers,
        ),
      );
    }
  }

  Future<void> onSaveSerialNumbersEvent(
    SaveSerialNumbersEvent event,
    Emitter<PurchaseOrderItemDetailBlocState> emit,
  ) async {
    final selectedSplitLocationEntity = event.splitLocationEntity;
    final currentSerialNumbersList = List<SerialNumberEntity>.from(
      state.allSerialNumbers,
    );
    final currentSplitLocations = List<SplitLocationEntity>.from(
      state.splitLocationEntity,
    );

    final int selectedSplitLocationIndex = state.splitLocationEntity.indexOf(
      selectedSplitLocationEntity,
    );
    debugPrint("updatedSerialNumbers in bloc: ${event.updatedSerialNumbers}");
    if (selectedSplitLocationIndex != -1 &&
        currentSerialNumbersList.isNotEmpty) {
      final updatedSerialNumbers =
          event.updatedSerialNumbers
              .map(
                (e) =>
                    e.copyWith(splitLocationId: selectedSplitLocationEntity.id),
              )
              .toList();

      final idsToRemove =
          updatedSerialNumbers.map((e) => e.serialNumberId).toSet();

      debugPrint("idsToRemove : $idsToRemove");
      final currentSerialNumberIds =
          currentSerialNumbersList.map((e) => e.serialNumberId).toSet();
      debugPrint("currentSerialNumberIds : $currentSerialNumberIds");
      currentSerialNumbersList.removeWhere(
        (element) => idsToRemove.contains(element.serialNumberId),
      );
      for (var splitData in currentSplitLocations) {
        if (splitData.serialNumbers.any(
          (serialData) => idsToRemove.contains(serialData.serialNumberId),
        )) {
          debugPrint("inside the any condition for remove **********");
          splitData.serialNumbers.removeWhere(
            (serialData) => idsToRemove.contains(serialData.serialNumberId),
          );
        }
      }
      final updatedSplitLocationEntity = selectedSplitLocationEntity.copyWith(
        serialNumbers: updatedSerialNumbers,
      );
      debugPrint(
        "updatedSplitLocationEntity.serialNumbers : ${updatedSplitLocationEntity.serialNumbers.length}",
      );
      currentSplitLocations[selectedSplitLocationIndex] =
          updatedSplitLocationEntity;
      emit(
        state.copyWith(
          splitLocationEntity: currentSplitLocations,
          allSerialNumbers: currentSerialNumbersList,
        ),
      );
    }
  }

  void showValidationError(
    Emitter<PurchaseOrderItemDetailBlocState> emit,
    String validationMessage,
  ) {
    emit(
      state.copyWith(
        validationError: true,
        validationMessage: validationMessage,
      ),
    );
    emit(state.copyWith(validationError: false, validationMessage: ''));
  }
}
