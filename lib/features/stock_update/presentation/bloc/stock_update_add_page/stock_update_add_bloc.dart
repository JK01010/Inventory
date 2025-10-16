import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../common_feature/domain/entities/item_master_common_entity_model.dart'
    show ItemMasterEntity;
import '../../../../common_feature/domain/usecase/common_usecase.dart';
import '../../../../item_master/domin/failures/item_master_failures.dart';
import '../../../../widgets/common_functions.dart';
import '../../../domin/entities/choose_items_list_entity_model.dart';
import '../../../domin/entities/srock_update_entity_model.dart';
import '../../../domin/usecases/stock_update_single_insert_usecase.dart';
import '../../../domin/usecases/stock_update_transaction_save_api_usecase.dart';

part 'stock_update_add_event.dart';

part 'stock_update_add_state.dart';

class StockUpdateAddBloc
    extends Bloc<StockUpdateAddEvent, StockUpdateAddState> {
  StockUpdateAddBloc({
    required this.commonUseCase,
    required this.stockUpdateSingleInsertUseCase,
    required this.stockUpdateTrnSaveApiUseCase,
  }) : super(StockUpdateAddState.initial()) {
    on<StockUpdateAddEvent>((event, emit) async {
      switch (event) {
        case FetchItemMasterByStorageIdEvent():
          await _fetchItemDetailsBasedOnStorageLocationId(event, emit);
        case IsChooseItemSelectedEvent():
          _chooseItemSelectionEvent(event, emit);
        case ChooseItemListSearchEvent():
          _chooseItemSearch(event, emit);
        case SaveItemDetailsEvent():
          await _saveItemMasterTransactionEvent(event, emit);
        case ValidationCheckEvent():
          _validationOnChangeCheck(event, emit);
        case ClearButtonEvent():
          _clearData(event, emit);
        case UpdateSplitLocationEntityWithSelectedLocationStockUpdateEvent():
          await _updateSplitLocationWithSelectedStorageLocation(event, emit);
      }
    });
  }

  final CommonUseCase commonUseCase;
  final StockUpdateSingleInsertUseCase stockUpdateSingleInsertUseCase;
  final StockUpdateTrnSaveApiUseCase stockUpdateTrnSaveApiUseCase;

  /// Fetches item details based on the storage location ID.
  ///
  /// This method retrieves item master data using the [commonUseCase]
  /// and updates the state with the fetched items. It maps the fetched
  /// items to [ChooseItemsEntity] for display in the UI.
  Future<void> _fetchItemDetailsBasedOnStorageLocationId(
    FetchItemMasterByStorageIdEvent event,
    Emitter<StockUpdateAddState> emit,
  ) async {
    emit(StockUpdateAddState.initial());
    await Future.delayed(Duration(seconds: 1));
    final failureOrSuccess = await commonUseCase(
      storageLocationId: event.storageLocationId,
    );
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(
            stockUpdateFailures: some(
              ItemDetailsStorageLocationIdFailure(code: "", message: ""),
            ),
          ),
        );
      },
      (success) {
        List<ChooseItemsEntity> mappedItems = [];
        if (success.isNotEmpty) {
          mappedItems =
              success.map((element) {
                return ChooseItemsEntity(
                  itemId: element.itemId,
                  umoName: element.uomId.toString(),
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

  /// Handles the selection of an item from the choose item list.
  ///
  /// This method updates the `isSelected` status of the selected item in both
  /// `chooseItemList` and `selectedChooseItems`. It also updates the state
  /// with the details of the selected item (item name, UOM, actual quantity, etc.).
  /// If `isClosed` is true, it resets the `selectedChooseItems` list.
  ///
  void _chooseItemSelectionEvent(
    IsChooseItemSelectedEvent event,
    Emitter<StockUpdateAddState> emit,
  ) {
    final List<ChooseItemsEntity> updatedList = List.of(state.chooseItemList);
    final List<ChooseItemsEntity> updatedSelectedList = List.of(
      state.selectedChooseItems,
    );
    if (event.isClosed != true) {
      ChooseItemsEntity selectedItem = state.selectedChooseItems[event.index];
      //isSelected Setting for main list
      for (int i = 0; i < updatedList.length; i++) {
        if (updatedList[i].itemId == selectedItem.itemId) {
          updatedList[i] = updatedList[i].copyWith(
            isSelected: event.isSelectedValue,
          );
          //binding data to view based on the selected item
          emit(
            state.copyWith(
              chooseItemText: updatedList[i].itemName,
              totalRob: updatedList[i].totalRob.toString(),
              uomName: updatedSelectedList[i].umoName,
              newStock: updatedSelectedList[i].newStock.toString(),
              reconditionStock: updatedSelectedList[i].reconditionStock.toString(),
              selectedItemId: updatedList[i].itemId,
              isUmoError: updatedList[i].umoName != "" ? false : true,
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
    Emitter<StockUpdateAddState> emit,
  ) {
    final List<ChooseItemsEntity> updatedList;
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
    Emitter<StockUpdateAddState> emit,
  ) async {
    //validationCheck
    emit(state.copyWith(isCompletedFrom: ""));

    if (state.chooseItemText.isEmpty ||
        // state.quantity.isEmpty ||
        state.totalRob.isEmpty) {
      state.chooseItemText.isEmpty
          ? emit(state.copyWith(isItemSearchError: true))
          : emit(state.copyWith(isItemSearchError: false));
     /* state.quantity.isEmpty
          ? emit(state.copyWith(isQuantityError: true))
          : emit(state.copyWith(isQuantityError: false));*/
      state.totalRob.isEmpty
          ? emit(state.copyWith(isUmoError: true))
          : emit(state.copyWith(isUmoError: false));
      return;
    }

    int quantity = 0;
    int newStock = 0;
    int reconditionStock = 0;

    if(state.adjNewStock != ""){
      quantity = int.parse(state.adjNewStock);
      int adjNewStock = int.parse(state.adjNewStock);
      if(state.newStock != ""){
        int newStockInt = double.parse(state.newStock).toInt();
        newStock = adjNewStock + newStockInt ;
      }else{
        newStock = adjNewStock;
      }
    }

    if(state.adjReconditionedStock != ""){
      quantity = int.parse(state.adjReconditionedStock);
      int adjRcdStock = int.parse(state.adjReconditionedStock);
      if(state.reconditionStock != ""){
        int reconditionStockInt = double.parse(state.reconditionStock).toInt();
        reconditionStock = adjRcdStock + reconditionStockInt ;
      }
    }

    final StockUpdateEntity insertModel = StockUpdateEntity(
      id: generateMobRefId(),
      itemId: state.selectedItemId,
      quantity: quantity,
      storageLocationId: state.selectedStorageLocationId,
      remarks: state.remarks,
      modifiedOn: getCurrentFormattedDateTime(),
      syncStatus: "N",
      syncMerge: "N",
      transactionId: generateMobRefId(),
      totalRob: double.parse(state.totalRob).toInt() ?? 0,
      locationId: 0,
      equipmentId: 0,
      adjNewStock: newStock != 0 ?newStock.toDouble() : double.parse(state.newStock),
      adjReconditionedStock:reconditionStock != 0 ? reconditionStock.toDouble() : double.parse(state.reconditionStock),
    );
    await stockUpdateSingleInsertUseCase(model: insertModel);
    //save api called
    await stockUpdateTrnSaveApiUseCase();

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
    Emitter<StockUpdateAddState> emit,
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
      case "rob":
        emit(
          state.copyWith(isUmoError: event.isEnabled, totalRob: event.onChangeValue),
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
      case "reconditionStock":
        emit(
          state.copyWith(
            isQuantityError: event.isEnabled,
            adjReconditionedStock: event.onChangeValue,
          ),
        );
        break;
      case "newStock":
        emit(
          state.copyWith(
            isQuantityError: event.isEnabled,
            adjNewStock: event.onChangeValue,
          ),
        );
        break;
      case "chooseItem":
        emit(state.copyWith(isItemSearchError: event.isEnabled));
        break;
    }
  }

  void _clearData(ClearButtonEvent event, Emitter<StockUpdateAddState> emit) {
    emit(StockUpdateAddState.initial());
  }

  Future<void> _updateSplitLocationWithSelectedStorageLocation(
      UpdateSplitLocationEntityWithSelectedLocationStockUpdateEvent event,
      Emitter<StockUpdateAddState> emit,
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
            stockUpdateFailures: some(
              ItemDetailsStorageLocationIdFailure(code: "", message: ""),
            ),
          ),
        );
      },
          (success) {
        List<ChooseItemsEntity> mappedItems = [];
        if (success.isNotEmpty) {
          mappedItems =
              success.map((element) {
                return ChooseItemsEntity(
                  itemId: element.itemId,
                  umoName: element.uomName??"",
                  itemName: element.itemName,
                  totalRob: element.totalRob,
                  newStock: element.newStock,
                  reconditionStock: element.reconditionedStock,
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
