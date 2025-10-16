import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../common_feature/domain/entities/item_master_common_entity_model.dart';
import '../../../../common_feature/domain/entities/storage_location_entity.dart';
import '../../../../common_feature/domain/usecase/common_usecase.dart';
import '../../../../good_receipts/domain/entities/split_location_entity.dart';
import '../../../../item_master/domin/failures/item_master_failures.dart';
import '../../../../stock_update/domin/entities/srock_update_entity_model.dart'
    show StockUpdateEntity;
import '../../../../widgets/common_functions.dart';
import '../../../domin/entities/choose_items_list_entity_model_consumption.dart';
import '../../../domin/entities/consumption_transaction_entity_model.dart';
import '../../../domin/usecases/con_tran_single_insert_usecase.dart';
import '../../../domin/usecases/fetch_rob_consumption_add_page_usecase.dart';
import '../../../domin/usecases/save_api_consumption_transaction_usecase.dart';

part 'consumption_add_page_event.dart';
part 'consumption_add_page_state.dart';

class ConsumptionAddPageBloc
    extends Bloc<ConsumptionAddPageEvent, ConsumptionAddPageState> {
  ConsumptionAddPageBloc({
    required this.commonUseCase,
    required this.conTransactionSingleInsertUseCase,
    required this.saveApiConsumptionTransactionUseCase,
    required this.fetchROBUseCase,
  }) : super(ConsumptionAddPageState.initial()) {
    on<ConsumptionAddPageEvent>((event, emit) async {
      switch (event) {
        case FetchItemMasterByStorageIdEvent():
          await _fetchItemDetailsBasedOnStorageLocationId(event, emit);
        case IsChooseItemSelectedEvent():
          await _chooseItemSelectionEvent(event, emit);
        case ChooseItemListSearchEvent():
          _chooseItemSearch(event, emit);
        case SaveItemDetailsEvent():
          await _saveItemMasterTransactionEvent(event, emit);
        case ValidationCheckEvent():
          _validationOnChangeCheck(event, emit);
        case ClearButtonEvent():
          _clearData(event, emit);
        case UpdateSplitLocationEntityWithSelectedLocationConsumptionEvent():
          await _updateSplitLocationWithSelectedStorageLocation(event, emit);
      }
    });
  }

  final CommonUseCase commonUseCase;
  final ConTransactionSingleInsertUseCase conTransactionSingleInsertUseCase;
  final SaveApiConsumptionTransactionUseCase
  saveApiConsumptionTransactionUseCase;
  final FetchROBUseCase fetchROBUseCase;

  /// Fetches item details based on the storage location ID.
  ///
  /// This method retrieves item master data using the [commonUseCase]
  /// and updates the state with the fetched items. It maps the fetched
  /// items to [ChooseItemsConEntity] for display in the UI.
  Future<void> _fetchItemDetailsBasedOnStorageLocationId(
    FetchItemMasterByStorageIdEvent event,
    Emitter<ConsumptionAddPageState> emit,
  ) async {
    emit(ConsumptionAddPageState.initial());
    await Future.delayed(Duration(seconds: 1));
    final failureOrSuccess = await commonUseCase(
      storageLocationId: event.storageLocationId,
    );
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(
            consumptionFailures: some(
              ItemDetailsStorageLocationIdFailure(code: "", message: ""),
            ),
          ),
        );
      },
      (success) {
        List<ChooseItemsConEntity> mappedItems = [];
        if (success.isNotEmpty) {
          mappedItems =
              success.map((element) {
                return ChooseItemsConEntity(
                  itemId: element.itemId,
                  umo: element.uomId.toString(),
                  itemName: element.itemName,
                  isSelected: false,
                );
              }).toList();
        }
        emit(
          state.copyWith(
            itemMasterList: success, // Ensure this is List<ItemMasterEntity>?
            chooseItemList: mappedItems,
            selectedChooseItems: mappedItems,
          ),
        );
      },
    );
  }

  /// Handles the selection of an item from the choose item list.
  ///
  /// This method updates the `isSelected` status of the selected item in both
  /// `chooseItemList` and `selectedChooseItems`. It also updates the state
  /// with the details of the selected item (item name, UOM, actual quantity, etc.).
  /// If `isClosed` is true, it resets the `selectedChooseItems` list.
  ///
  Future<void> _chooseItemSelectionEvent(
    IsChooseItemSelectedEvent event,
    Emitter<ConsumptionAddPageState> emit,
  ) async {
    final List<ChooseItemsConEntity> updatedList = List.of(
      state.chooseItemList,
    );
    final List<ChooseItemsConEntity> updatedSelectedList = List.of(
      state.selectedChooseItems,
    );
    if (event.isClosed != true) {
      ChooseItemsConEntity selectedItem =
          state.selectedChooseItems[event.index];
      //isSelected Setting for main list
      for (int i = 0; i < updatedList.length; i++) {
        if (updatedList[i].itemId == selectedItem.itemId) {
          updatedList[i] = updatedList[i].copyWith(
            isSelected: event.isSelectedValue,
          );
          int actualQuantity = 0;
          final failureOrSuccess = await fetchROBUseCase(
            itemId: updatedList[i].itemId,
          );
          failureOrSuccess.fold((failure) {}, (success) {
            actualQuantity = success;
          });
          // int rob =

          // int rob =
          //binding data to view based on the selected item
          emit(
            state.copyWith(
              chooseItemText: updatedList[i].itemName,
              umo: updatedList[i].umo,
              actualQuantity: actualQuantity.toString(),
              selectedItemId: updatedList[i].itemId,
              isUmoError: updatedList[i].umo != "" ? false : true,
            ),

            //need actualQuantity based on selected itemId and selected storageLocationId from stock location table ///todo addStockUpdate
          );
        } else {
          updatedList[i] = updatedList[i].copyWith(isSelected: false);
        }
      }
      //isSelected Setting for view list
      for (int i = 0; i < updatedSelectedList.length; i++) {
        if (updatedSelectedList[i].itemId == selectedItem.itemId) {
          updatedSelectedList[i] = updatedSelectedList[i].copyWith(
            isSelected: event.isSelectedValue,
          );
        } else {
          updatedSelectedList[i] = updatedSelectedList[i].copyWith(
            isSelected: false,
          );
        }
      }

      emit(
        state.copyWith(
          chooseItemList: updatedList,
          selectedChooseItems: updatedSelectedList,
        ),
      );
    } else {
      //reset the list while cross button press
      emit(state.copyWith(selectedChooseItems: updatedList));
    }
  }

  /// Handles the event to search items in the choose item list.
  ///
  /// This method filters the `chooseItemList` based on the provided search text
  /// and updates the `selectedChooseItems` in the state with the filtered list.
  /// The search is case-insensitive.
  void _chooseItemSearch(
    ChooseItemListSearchEvent event,
    Emitter<ConsumptionAddPageState> emit,
  ) {
    final List<ChooseItemsConEntity> updatedList;
    updatedList =
        state.chooseItemList
            .where(
              (e) => e.itemName.toLowerCase().contains(
                event.searchText.toLowerCase(),
              ),
            )
            .toList();

    emit(state.copyWith(selectedChooseItems: updatedList));
  }

  /// Handles the event to save item master transaction details.
  ///
  /// This method validates the input fields (item, quantity, UOM).
  /// If validation passes, it creates a [StockUpdateEntity] and saves it using [stockUpdateSingleInsertUseCase].
  Future<void> _saveItemMasterTransactionEvent(
    SaveItemDetailsEvent event,
    Emitter<ConsumptionAddPageState> emit,
  ) async {
    //validationCheck
    emit(state.copyWith(isCompletedFrom: ""));

    if (state.chooseItemText.isEmpty ||
        state.quantity.isEmpty ||
        state.umo.isEmpty) {
      state.chooseItemText.isEmpty
          ? emit(state.copyWith(isItemSearchError: true))
          : emit(state.copyWith(isItemSearchError: false));
      state.quantity.isEmpty
          ? emit(state.copyWith(isQuantityError: true))
          : emit(state.copyWith(isQuantityError: false));
      state.umo.isEmpty
          ? emit(state.copyWith(isUmoError: true))
          : emit(state.copyWith(isUmoError: false));
      state.selectedStorageLocationId == 0
          ? emit(state.copyWith(isChooseStorageLocationError: true))
          : emit(state.copyWith(isChooseStorageLocationError: false));
      return;
    }
    int quantity = int.parse(state.quantity);
    final ConsumptionTransactionEntityModel insertModel =
        ConsumptionTransactionEntityModel(
          id: generateMobRefId(),
          itemId: state.selectedItemId,
          quantity: quantity,
          storageLocationId: state.selectedStorageLocationId,
          remarks: state.remarks,
          modifiedOn: getCurrentFormattedDateTime(),
          syncStatus: "N",
          syncMerge: "N",
          transactionId: generateMobRefId(),
          tags: "",
          equipmentId: 0,
          locationId: state.selectedStorageLocationId,
          totalRob: 0,
          newStock: 0,
          reconditionStock: 0,
          currentRob: 0,
          totalNewStock: 0,
          totalReconditionStock: 0
        );
    await conTransactionSingleInsertUseCase(model: insertModel);
    //api call after db insert
    await saveApiConsumptionTransactionUseCase();

    if (event.isSaveAddNew) {
      emit(state.copyWith(isCompletedFrom: "saveAddNew"));
    } else {
      emit(state.copyWith(isCompletedFrom: "save"));
    }
  }

  /// Handles the validation check event when input fields change.
  ///
  /// This method updates the state based on the field name and validation status.
  /// It sets error flags and updates the corresponding field values in the state.
  void _validationOnChangeCheck(
    ValidationCheckEvent event,
    Emitter<ConsumptionAddPageState> emit,
  ) {
    switch (event.fieldName) {
      case "item":
        emit(
          state.copyWith(
            isItemSearchError: event.isEnabled,
            chooseItemText: event.onChangeValue,
          ),
        );
        break;
      case "quantity":
        emit(
          state.copyWith(
            isQuantityError: event.isEnabled,
            quantity: event.onChangeValue,
          ),
        );
        break;
      case "umo":
        emit(
          state.copyWith(isUmoError: event.isEnabled, umo: event.onChangeValue),
        );
        break;
      case "remark":
        emit(
          state.copyWith(
            isRemarksError: event.isEnabled,
            remarks: event.onChangeValue,
          ),
        );
        break;
      case "chooseItem":
        emit(state.copyWith(isItemSearchError: event.isEnabled));
        break;
    }
  }

  void _clearData(
    ClearButtonEvent event,
    Emitter<ConsumptionAddPageState> emit,
  ) {
    emit(ConsumptionAddPageState.initial());
  }


  Future<void> _updateSplitLocationWithSelectedStorageLocation(
      UpdateSplitLocationEntityWithSelectedLocationConsumptionEvent event,
      Emitter<ConsumptionAddPageState> emit,
      ) async {
    log("selectedStorageLocationId --- ${event.selectedId}");
    emit(state.copyWith(selectedStorageLocationId: event.selectedId,selectedStorageLocationCode: event.selectedCode));

    final failureOrSuccess = await commonUseCase(
      storageLocationId: event.selectedId,
    );
    failureOrSuccess.fold(
          (failure) {
        emit(
          state.copyWith(
            consumptionFailures: some(
              ItemDetailsStorageLocationIdFailure(code: "", message: ""),
            ),
          ),
        );
      },
          (success) {
        List<ChooseItemsConEntity> mappedItems = [];
        if (success.isNotEmpty) {
          mappedItems =
              success.map((element) {
                return ChooseItemsConEntity(
                  itemId: element.itemId,
                  umo: element.uomId.toString(),
                  itemName: element.itemName,
                  isSelected: false,
                );
              }).toList();
        }
        emit(
          state.copyWith(
            itemMasterList: success,
            chooseItemList: mappedItems,
            selectedChooseItems: mappedItems,
          ),
        );
      },
    );

  }
}
