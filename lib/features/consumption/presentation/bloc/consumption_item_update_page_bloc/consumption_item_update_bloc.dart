import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../common_feature/domain/entities/equipment_list_entity.dart';
import '../../../../common_feature/domain/usecase/get_all_equipment_list_usecase.dart';
import '../../../../common_feature/domain/usecase/get_equipment_children_usecase.dart';
import '../../../../item_master/domin/failures/item_master_failures.dart';
import '../../../../widgets/common_functions.dart';
import '../../../domin/entities/consumption_location_entity.dart';
import '../../../domin/entities/consumption_rfid_scanning_view_entity_model.dart';
import '../../../domin/entities/consumption_transaction_entity_model.dart';
import '../../../domin/failures/consumption_failures.dart';
import '../../../domin/usecases/con_tran_multiple_insert_usecase.dart';
import '../../../domin/usecases/fetch_all_consuption_location_usecase.dart';
import '../../../domin/usecases/insert_consumption_equipment_list.dart';
import '../../../domin/usecases/save_api_consumption_transaction_usecase.dart';

part 'consumption_item_update_event.dart';

part 'consumption_item_update_state.dart';

class ConsumptionItemUpdateBloc
    extends Bloc<ConsumptionItemUpdateEvent, ConsumptionItemUpdateState> {
  ConsumptionItemUpdateBloc({
    required this.insertEquipmentListUseCase,
    required this.getAllEquipmentListUseCase,
    required this.conTranMultipleInsertUseCase,
    required this.getEquipmentChildrenUseCase,
    required this.fetchAllConsumptionLocationUseCase,
    required this.saveApiConsumptionTransactionUseCase
  }) : super(ConsumptionItemUpdateState.initial()) {
    on<ConsumptionItemUpdateEvent>((event, emit) async {
      switch (event) {
        case EquipmentListInsertDataEvent():
          await insertEquipmentData(event, emit);

        case EquipmentListGetAllDataEvent():
          await _getAllEquipmentList(event, emit);
        case LocationListGetAllDataEvent():
          await _getAllLocationList(event, emit);

        case SelectedEquipmentFromListEvent():
          await _selectedEquipmentFromListEvent(event, emit);

        case SelectedLocationFromListEvent():
          await _selectedLocationFromListEvent(event, emit);

        case ReadPreviousPageDataEvent():
          _readData(event, emit);
        case SaveTransactionListEvent():
          await _save(event, emit);
        case UpdateItemValue():
          _onValueOnChange(event, emit);
        case ResetStateEvent():
          _resetState(event, emit);

        case EquipmentListSearchEvent():
          _equipmentListSearch(event, emit);
        case LocationListSearchEvent():
          _locationListSearch(event, emit);

        case EquipmentSelectedEvent():
          _equipmentSelected(event, emit);
        case LocationSelectedEvent():
          _locationSelected(event, emit);

        case EquipmentDataResetEvent():
          _equipmentReset(event, emit);
        case LocationDataResetEvent():
          _locationReset(event, emit);

        case LocationOrEquipmentCheckEvent():
          _isLocationOrEquipmentCheck(event, emit);
        case ConsumptionListSearchEvent():
          _itemSearch(event, emit);
      }
    });
  }

  final InsertEquipmentListUseCase insertEquipmentListUseCase;
  final GetAllEquipmentListUseCase getAllEquipmentListUseCase;
  final FetchAllConsumptionLocationUseCase fetchAllConsumptionLocationUseCase;
  final GetEquipmentChildrenUsecase getEquipmentChildrenUseCase;
  final ConTranMultipleInsertUseCase conTranMultipleInsertUseCase;
  final SaveApiConsumptionTransactionUseCase saveApiConsumptionTransactionUseCase;

  Future<void> insertEquipmentData(
    ConsumptionItemUpdateEvent event,
    Emitter<ConsumptionItemUpdateState> emit,
  ) async {
    await insertEquipmentListUseCase();
  }

  ///Equipment
  Future<void> _getAllEquipmentList(
    EquipmentListGetAllDataEvent event,
    Emitter<ConsumptionItemUpdateState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    final failureOrSuccess = await getAllEquipmentListUseCase();
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(
            itemMasterFailures: some(
              GetAllEquipmentFailure(code: "", message: ""),
            ),
            isLoading: false,
          ),
        );
      },
      (success) {
        emit(state.copyWith(isLoading: false, allEquipmentListEntity: success));
        emit(
          state.copyWith(
            equipmentListEntity:
                state.allEquipmentListEntity.take(5).toList(),
          ),
        );
      },
    );
  }

  ///Location
  Future<void> _getAllLocationList(
    LocationListGetAllDataEvent event,
    Emitter<ConsumptionItemUpdateState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(Duration(seconds: 1));

    final failureOrSuccess = await fetchAllConsumptionLocationUseCase();
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(consumptionFailures: some(failure), isLoading: false),
        );
      },
      (success) {
        emit(state.copyWith(isLoading: false, allLocationEntity: success));
        emit(
          state.copyWith(
            locationListEntity:
                state.allLocationEntity
                    .where((element) => element.parentId == -1)
                    .toList(),
          ),
        );
      },
    );
  }

  void _equipmentListSearch(
    EquipmentListSearchEvent event,
    Emitter<ConsumptionItemUpdateState> emit,
  ) {
    final List<EquipmentListEntity> updatedList;
    if (state.breadCrumbList.isEmpty) {
      //search functionality for the initial page of search equipment
      if (event.searchText != "") {
        updatedList =
            state.allEquipmentListEntity
                .where(
                  (e) => e.name.toLowerCase().contains(
                    event.searchText.toLowerCase(),
                  ),
                )
                .toList();
      } else {
        updatedList =
            state.allEquipmentListEntity
                .where((element) => element.parentId == 0)
                .toList();
      }
    } else {
      EquipmentListEntity? searchList = state.breadCrumbList.last;
      if (event.searchText != "") {
        updatedList =
            state.allEquipmentListEntity
                .where(
                  (e) =>
                      e.name.toLowerCase().contains(
                        event.searchText.toLowerCase(),
                      ) &&
                      e.parentId == searchList.id,
                )
                .toList();
      } else {
        updatedList =
            state.allEquipmentListEntity
                .where((e) => e.parentId == searchList.id)
                .toList();
      }
    }

    emit(state.copyWith(equipmentListEntity: updatedList));
  }

  void _locationListSearch(
    LocationListSearchEvent event,
    Emitter<ConsumptionItemUpdateState> emit,
  ) {
    final List<ConsumptionLocationEntity> updatedList;
    if (state.locationBreadCrumbList.isEmpty) {
      //search functionality for the initial page of search equipment
      if (event.searchText != "") {
        updatedList =
            state.allLocationEntity
                .where(
                  (e) => e.name.toLowerCase().contains(
                    event.searchText.toLowerCase(),
                  ),
                )
                .toList();
      } else {
        updatedList =
            state.allLocationEntity
                .where((element) => element.parentId == -1)
                .toList(); //parentId check
      }
    } else {
      ConsumptionLocationEntity? searchList = state.locationBreadCrumbList.last;
      if (event.searchText != "") {
        updatedList =
            state.allLocationEntity
                .where(
                  (e) =>
                      e.name.toLowerCase().contains(
                        event.searchText.toLowerCase(),
                      ) &&
                      e.parentId == searchList.id,
                )
                .toList();
      } else {
        updatedList =
            state.allLocationEntity
                .where((e) => e.parentId == searchList.id)
                .toList();
      }
    }
    emit(state.copyWith(locationListEntity: updatedList));
  }

  void _equipmentSelected(
    EquipmentSelectedEvent event,
    Emitter<ConsumptionItemUpdateState> emit,
  ) {
    bool hasChildren = state.allEquipmentListEntity.any(
      (e) => e.parentId == event.currentItem.id,
    );

    EquipmentListEntity home = EquipmentListEntity(
      id: 00,
      parentId: 00,
      name: "Home",
      equipmentTypeId: 0,
      code: "",
    );

    if (!hasChildren) {
      ///////////////////////////////////////////////////////////////////////////////////////////
      if (state.breadCrumbList.isEmpty) {
        List<EquipmentListEntity> breadCrumbChain = [];
        EquipmentListEntity? current = event.currentItem;
        do {
          for (int i = 0; i < state.allEquipmentListEntity.length; i++) {
            //adding the 1st element ones,
            if (breadCrumbChain.isEmpty) {
              breadCrumbChain.insert(0, current!);
            }

            if (current?.parentId == state.allEquipmentListEntity[i].id) {
              current = state.allEquipmentListEntity[i];
              breadCrumbChain.add(current);
            }
          }
        } while (current != null && current.parentId != 0);

        breadCrumbChain.remove(event.currentItem);

        if (breadCrumbChain.isNotEmpty) {
          int id = breadCrumbChain.first.id;
          List<EquipmentListEntity> searchList =
              state.allEquipmentListEntity
                  .where((element) => element.parentId == id)
                  .toList();
          emit(state.copyWith(equipmentListEntity: searchList));
        } /*else {
          List<EquipmentListEntity> searchList =
              state.allEquipmentListEntity
                  .where((element) => element.parentId == event.currentItem.id)
                  .toList();
          breadCrumbChain.add(current!);
          emit(
            state.copyWith(
              equipmentListEntity: searchList,
              breadCrumbList: breadCrumbChain,
            ),
          );
        }*/
        if (breadCrumbChain.isNotEmpty) {
          breadCrumbChain.add(home);
        }
        emit(state.copyWith(breadCrumbList: breadCrumbChain.reversed.toList()));

        ///////////////////////////////////////////////////////////////////////////////////////////
      }

      // First, set all items' isSelected to false
      final resetList =
          state.equipmentListEntity.map((item) {
            return item.copyWith(isSelected: false);
          }).toList();
      // Then, set the selected item's isSelected to true
      final updatedList =
          state.equipmentListEntity.map((item) {
            return item.id == event.currentItem.id
                ? item.copyWith(isSelected: true)
                : item.copyWith(isSelected: false);
          }).toList();
      emit(
        state.copyWith(
          equipmentListEntity: updatedList,
          equipmentSaveEnabled: true,
        ),
      );
    } else {
      List<EquipmentListEntity> breadCrumbChain = [];
      EquipmentListEntity? current = event.currentItem;

      do {
        for (int i = 0; i < state.allEquipmentListEntity.length; i++) {
          //adding the 1st element ones,
          if (breadCrumbChain.isEmpty) {
            breadCrumbChain.insert(0, current!);
          }

          if (current?.parentId == state.allEquipmentListEntity[i].id) {
            current = state.allEquipmentListEntity[i];
            breadCrumbChain.add(current);
          }
        }
      } while (current != null && current.parentId != 0 && current.id != 00);

      if (breadCrumbChain.isNotEmpty) {
        int id = breadCrumbChain.first.id;
        List<EquipmentListEntity> searchList =
            state.allEquipmentListEntity
                .where((element) => element.parentId == id)
                .toList();
        emit(state.copyWith(equipmentListEntity: searchList));
      } else {
        List<EquipmentListEntity> searchList =
            state.allEquipmentListEntity
                .where((element) => element.parentId == event.currentItem.id)
                .toList();
        breadCrumbChain.add(current!);
        emit(
          state.copyWith(
            equipmentListEntity: searchList,
            breadCrumbList: breadCrumbChain,
          ),
        );
      }
      if (breadCrumbChain.isNotEmpty) {
        breadCrumbChain.add(home);
        if (event.currentItem.id == 00) {
          emit(state.copyWith(breadCrumbList: []));
          return;
        }
      }
      emit(state.copyWith(breadCrumbList: breadCrumbChain.reversed.toList()));
    }
  }

  void _locationSelected(
    LocationSelectedEvent event,
    Emitter<ConsumptionItemUpdateState> emit,
  ) {
    bool hasChildren = state.allLocationEntity.any(
      (e) => e.parentId == event.currentItem.id,
    );

    if (event.currentItem.name == "Home") {
      final List<ConsumptionLocationEntity> updatedList;

      updatedList =
          state.allLocationEntity
              .where((element) => element.parentId == -1)
              .toList();

      emit(
        state.copyWith(
          locationListEntity: updatedList,
          locationBreadCrumbList: [],
        ),
      );
      return;
    }

    ConsumptionLocationEntity home = ConsumptionLocationEntity(
      id: 00,
      parentId: 00,
      name: 'Home',
      code: '',
      parentName: '',
      activeFlag: '',
      type: '',
      sortOrder: 0,
    );

    if (!hasChildren) {
      ///////////////////////////////////////////////////////////////////////////////////////////
      if (state.locationBreadCrumbList.isEmpty) {
        List<ConsumptionLocationEntity> breadCrumbChain = [];
        ConsumptionLocationEntity? current = event.currentItem;
        do {
          for (int i = 0; i < state.allLocationEntity.length; i++) {
            //adding the 1st element ones,
            if (breadCrumbChain.isEmpty) {
              breadCrumbChain.insert(0, current!);
            }

            if (current?.parentId == state.allLocationEntity[i].id) {
              current = state.allLocationEntity[i];
              breadCrumbChain.add(current);
            }
          }
        } while (current != null && current.parentId != -1);

        breadCrumbChain.remove(event.currentItem);

        if (breadCrumbChain.isNotEmpty) {
          int id = breadCrumbChain.first.id;
          List<ConsumptionLocationEntity> searchList =
              state.allLocationEntity
                  .where((element) => element.parentId == id)
                  .toList();
          emit(state.copyWith(locationListEntity: searchList));
        }
        /*else{
          List<ConsumptionLocationEntity> searchList = state.allLocationEntity.where((element) => element.parentId == event.currentItem.id).toList();
          // breadCrumbChain.add(current!);
          // emit(state.copyWith(locationListEntity: searchList,locationBreadCrumbList: breadCrumbChain));
        }*/
        if (breadCrumbChain.isNotEmpty) {
          breadCrumbChain.add(home);
        }
        emit(
          state.copyWith(
            locationBreadCrumbList: breadCrumbChain.reversed.toList(),
          ),
        );

        ///////////////////////////////////////////////////////////////////////////////////////////
      }

      // First, set all items' isSelected to false
      final resetList =
          state.locationListEntity.map((item) {
            return item.copyWith(isSelected: false);
          }).toList();
      // Then, set the selected item's isSelected to true
      final updatedList =
          state.locationListEntity.map((item) {
            return item.id == event.currentItem.id
                ? item.copyWith(isSelected: true)
                : item.copyWith(isSelected: false);
          }).toList();
      emit(
        state.copyWith(
          locationListEntity: updatedList,
          locationSaveEnabled: true,
        ),
      );
    } else {
      List<ConsumptionLocationEntity> breadCrumbChain = [];
      ConsumptionLocationEntity? current = event.currentItem;

      do {
        for (int i = 0; i < state.allLocationEntity.length; i++) {
          //adding the 1st element ones,
          if (breadCrumbChain.isEmpty) {
            breadCrumbChain.insert(0, current!);
          }

          if (current?.parentId == state.allLocationEntity[i].id) {
            current = state.allLocationEntity[i];
            breadCrumbChain.add(current);
          }
        }
      } while (current != null && current.parentId != -1 && current.id != 00);

      if (breadCrumbChain.isNotEmpty) {
        int id = breadCrumbChain.first.id;
        List<ConsumptionLocationEntity> searchList =
            state.allLocationEntity
                .where((element) => element.parentId == id)
                .toList();
        emit(state.copyWith(locationListEntity: searchList));
      } else {
        List<ConsumptionLocationEntity> searchList =
            state.allLocationEntity
                .where((element) => element.parentId == event.currentItem.id)
                .toList();
        breadCrumbChain.add(current!);
        emit(
          state.copyWith(
            locationListEntity: searchList,
            locationBreadCrumbList: breadCrumbChain,
          ),
        );
      }
      if (breadCrumbChain.isNotEmpty) {
        breadCrumbChain.add(home);
        if (event.currentItem.id == 00) {
          emit(state.copyWith(locationBreadCrumbList: []));
          return;
        }
      }
      emit(
        state.copyWith(
          locationBreadCrumbList: breadCrumbChain.reversed.toList(),
        ),
      );
    }
  }

  Future<void> _selectedEquipmentFromListEvent(
    SelectedEquipmentFromListEvent event,
    Emitter<ConsumptionItemUpdateState> emit,
  ) async {
    if (state.equipmentSaveEnabled && state.equipmentListEntity.isNotEmpty) {
      final updatedList = List<ConsumptionRfidListingViewEntity>.from(
        state.selectedRfidItemList,
      );
      EquipmentListEntity selectedItem = state.equipmentListEntity.firstWhere(
        (element) => element.isSelected == true,
      );
      String displayName = selectedItem.code;
      displayName += " - ${selectedItem.name}";
      updatedList[event
          .selectedItemIndex] = updatedList[event.selectedItemIndex].copyWith(
        selectedEquipmentName: displayName,
        selectedEquipmentId: selectedItem.id,
      );
      emit(state.copyWith(selectedRfidItemList: updatedList));

      List<ConsumptionRfidListingViewEntity> searchList = updatedList;
      List<ConsumptionRfidListingViewEntity> mainList = List.of(
        state.selectedMainList,
      );
      for (int j = 0; j < searchList.length; j++) {
        for (int i = 0; i < mainList.length; i++) {
          if (searchList[j].itemId == mainList[i].itemId) {
            mainList[i] = searchList[j];
          }
        }
      }
      emit(state.copyWith(selectedMainList: mainList));
    }
  }

  Future<void> _selectedLocationFromListEvent(
    SelectedLocationFromListEvent event,
    Emitter<ConsumptionItemUpdateState> emit,
  ) async {
    if (state.locationSaveEnabled && state.locationListEntity.isNotEmpty) {
      final updatedList = List<ConsumptionRfidListingViewEntity>.from(
        state.selectedRfidItemList,
      );
      ConsumptionLocationEntity selectedItem = state.locationListEntity
          .firstWhere((element) => element.isSelected == true);

      String displayName = selectedItem.code;
      displayName += " - ${selectedItem.name}";
      updatedList[event
          .selectedItemIndex] = updatedList[event.selectedItemIndex].copyWith(
        selectedLocationName: displayName,
        selectedLocationId: selectedItem.id,
      );

      emit(state.copyWith(selectedRfidItemList: updatedList));

      List<ConsumptionRfidListingViewEntity> searchList = updatedList;
      List<ConsumptionRfidListingViewEntity> mainList = List.of(
        state.selectedMainList,
      );
      for (int j = 0; j < searchList.length; j++) {
        for (int i = 0; i < mainList.length; i++) {
          if (searchList[j].itemId == mainList[i].itemId) {
            mainList[i] = searchList[j];
          }
        }
      }
      emit(state.copyWith(selectedMainList: mainList));
    }
  }

  void _readData(
    ReadPreviousPageDataEvent event,
    Emitter<ConsumptionItemUpdateState> emit,
  ) {
    emit(
      state.copyWith(
        selectedRfidItemList: event.selectedItemsList,
        selectedMainList: event.selectedItemsList,
      ),
    );
  }

  Future<void> _save(
    SaveTransactionListEvent event,
    Emitter<ConsumptionItemUpdateState> emit,
  ) async {
    emit(state.copyWith(isSaveCompleted: false));
    List<ConsumptionTransactionEntityModel> insertList = [];

    // Create a new list to avoid modifying the state directly during iteration
    List<ConsumptionRfidListingViewEntity> validationList = List.from(
      state.selectedRfidItemList,
    );
    bool hasError = false;

  /*  for (int i = 0; i < validationList.length; i++) {
      if (validationList[i].newStockController == null ||
          validationList[i].newStockController?.trim() == "" ||
          validationList[i].newStockController?.trim() == "0") {
        validationList[i] = validationList[i].copyWith(
          showErrorConsumedQty: true,
        );
        hasError = true;
      }
    }*/

    if (hasError) {
      emit(state.copyWith(selectedRfidItemList: validationList));
      return;
    }
    //checking any of the elements in the list has no value and return
    for (int i = 0; i < state.selectedRfidItemList.length; i++) {
      int quantity = 0;
      int updatedNewStock = 0;
      int updatedReconditionStock = 0;
      int updatedRob = 0;
      if(state.selectedRfidItemList[i].newStockController != ""){
        updatedNewStock = int.parse(
          state.selectedRfidItemList[i].newStockController ?? "0",
        );
      }
      if(state.selectedRfidItemList[i].reconditionStockController != ""){
        updatedReconditionStock = int.parse(
          state.selectedRfidItemList[i].reconditionStockController ?? "0",
        );
      }

      //decrease total Rob with consumed stocks
      if(state.selectedRfidItemList[i].rob != 0){
        quantity = updatedNewStock + updatedReconditionStock;
        updatedRob = state.selectedRfidItemList[i].rob - quantity;
      }

      final ConsumptionTransactionEntityModel insertModel =
          ConsumptionTransactionEntityModel(
            id: generateMobRefId(),
            itemId: state.selectedRfidItemList[i].itemId,
            quantity: quantity,
            storageLocationId:
                state.selectedRfidItemList[i].defaultStorageLocationId,
            remarks: state.selectedRfidItemList[i].remarkController ?? "",
            modifiedOn: getCurrentFormattedDateTime(),
            syncStatus: "N",
            syncMerge: "Y",
            transactionId: generateMobRefId(),
            tags: "",
            locationId: state.selectedRfidItemList[i].selectedLocationId ?? 0,
            equipmentId: state.selectedRfidItemList[i].selectedEquipmentId ?? 0,

            totalRob: state.selectedRfidItemList[i].rob ?? 0, //old rob
            totalNewStock: state.selectedRfidItemList[i].newStock ?? 0, //old newStock
            totalReconditionStock: state.selectedRfidItemList[i].reconditionStock ?? 0,//old reconditionStock

            currentRob: updatedRob,//updated Rob from old rob
            newStock: updatedNewStock, //user updated value
            reconditionStock: updatedReconditionStock,//user updated value
          );
      insertList.add(insertModel);
    }
    // Final check for errors before proceeding
    bool showErrorConsumedQyt =
        state.selectedRfidItemList
            .where((element) => element.showErrorConsumedQty == true)
            .isNotEmpty;
    bool showErrorConsumedQytRob =
        state.selectedRfidItemList
            .where((element) => element.showErrorConsumedQtyRob == true)
            .isNotEmpty;
    if (showErrorConsumedQyt || showErrorConsumedQytRob) {
      return;
    }
    await conTranMultipleInsertUseCase(list: insertList);
    saveApiConsumptionTransactionUseCase();
    emit(state.copyWith(isSaveCompleted: true));
  }

  void _onValueOnChange(
    UpdateItemValue event,
    Emitter<ConsumptionItemUpdateState> emit,
  ) {
    List<ConsumptionRfidListingViewEntity> updatedList = List.from(
      state.selectedRfidItemList,
    );

    if (event.newStockRob != "" && !event.isForRemarks) {
      int consumedQty = int.parse(event.newStockRob);

      if (event.rob < consumedQty) {
        updatedList[event.index] = updatedList[event.index].copyWith(
          showErrorConsumedQtyRob: true,
        );
        emit(state.copyWith(selectedRfidItemList: updatedList));

        //saving the entered value to the main list from the searched list
        List<ConsumptionRfidListingViewEntity> searchList = updatedList;
        List<ConsumptionRfidListingViewEntity> mainList = List.of(
          state.selectedMainList,
        );
        for (int j = 0; j < searchList.length; j++) {
          for (int i = 0; i < mainList.length; i++) {
            if (searchList[j].itemId == mainList[i].itemId) {
              mainList[i] = searchList[j];
            }
          }
        }

        emit(state.copyWith(selectedMainList: mainList));

        return;
      } else {
        updatedList[event.index] = updatedList[event.index].copyWith();
      }
    } else {
      updatedList[event.index] = updatedList[event.index].copyWith(
        showErrorConsumedQty: true,
      );
    }

    if (event.isForRemarks) {
      updatedList[event.index] = updatedList[event.index].copyWith(
        remarkController: event.newValue,
      );
    } else {
      updatedList[event.index] = updatedList[event.index].copyWith();
      updatedList[event.index] = updatedList[event.index].copyWith(
        newStockController: event.newStockRob,
      );
      updatedList[event.index] = updatedList[event.index].copyWith(
        reconditionStockController: event.reconditionStock,
      );
    }

    emit(state.copyWith(selectedRfidItemList: updatedList));

    //saving the entered value to the main list from the searched list
    List<ConsumptionRfidListingViewEntity> searchList = updatedList;
    List<ConsumptionRfidListingViewEntity> mainList = List.of(
      state.selectedMainList,
    );
    for (int j = 0; j < searchList.length; j++) {
      for (int i = 0; i < mainList.length; i++) {
        if (searchList[j].itemId == mainList[i].itemId) {
          mainList[i] = searchList[j];
        }
      }
    }

    emit(state.copyWith(selectedMainList: mainList));
  }

  void _resetState(
    ResetStateEvent event,
    Emitter<ConsumptionItemUpdateState> emit,
  ) {
    emit(state.copyWith(selectedRfidItemList: []));
    ConsumptionItemUpdateState.initial();
  }

  void _equipmentReset(
    EquipmentDataResetEvent event,
    Emitter<ConsumptionItemUpdateState> emit,
  ) {
    emit(
      state.copyWith(
        equipmentSaveEnabled: false,
        breadCrumbList: [],
        allEquipmentListEntity: [],
        equipmentListEntity: [],
      ),
    );
  }

  void _locationReset(
    LocationDataResetEvent event,
    Emitter<ConsumptionItemUpdateState> emit,
  ) {
    emit(
      state.copyWith(
        locationSaveEnabled: false,
        locationBreadCrumbList: [],
        allLocationEntity: [],
        locationListEntity: [],
      ),
    );
  }

  void _isLocationOrEquipmentCheck(
    LocationOrEquipmentCheckEvent event,
    Emitter<ConsumptionItemUpdateState> emit,
  ) {
    final updatedList = List<ConsumptionRfidListingViewEntity>.from(
      state.selectedRfidItemList,
    );
    final currentItem = updatedList[event.index];
    final updatedItem = currentItem.copyWith(
      isLocationSelected: event.isLocation,
      isEquipmentSelected: event.isEquipment,
    );

    if (event.isLocation == true) {
      updatedList[event.index] = updatedItem;
      emit(state.copyWith(selectedEquipmentName: "", selectedEquipmentId: 0));
    }

    if (event.isEquipment == true) {
      updatedList[event.index] = updatedItem;
      emit(state.copyWith(selectedLocationName: "", selectedLocationId: 0));
    }

    updatedList[event.index] = updatedItem;
    emit(state.copyWith(selectedRfidItemList: updatedList));

    //saving the entered value to the main list from the searched list
    List<ConsumptionRfidListingViewEntity> searchList = updatedList;
    List<ConsumptionRfidListingViewEntity> mainList = List.of(
      state.selectedMainList,
    );
    for (int j = 0; j < searchList.length; j++) {
      for (int i = 0; i < mainList.length; i++) {
        if (searchList[j].itemId == mainList[i].itemId) {
          mainList[i] = searchList[j];
        }
      }
    }
    emit(state.copyWith(selectedMainList: mainList));
  }

  void _itemSearch(
    ConsumptionListSearchEvent event,
    Emitter<ConsumptionItemUpdateState> emit,
  ) async {
    List<ConsumptionRfidListingViewEntity> itemList = List.of(
      state.selectedMainList,
    );
    //checking the event is from search or onBack and searching the data isNotEmpty
    if (event.isSearch && event.searchText.trim().isNotEmpty) {
      emit(
        state.copyWith(
          selectedRfidItemList:
              itemList
                  .where(
                    (element) => element.itemName.toLowerCase().contains(
                      event.searchText.toLowerCase(),
                    ),
                  )
                  .toList(),
        ),
      );

      //saving the entered value to the main list from the searched list
      List<ConsumptionRfidListingViewEntity> searchList =
          itemList
              .where(
                (element) => element.itemName.toLowerCase().contains(
                  event.searchText.toLowerCase(),
                ),
              )
              .toList();
      List<ConsumptionRfidListingViewEntity> mainList = List.of(
        state.selectedMainList,
      );
      for (int j = 0; j < searchList.length; j++) {
        for (int i = 0; i < itemList.length; i++) {
          if (searchList[j].itemId == mainList[i].itemId) {
            mainList[i] = searchList[j];
          }
        }
      }
      emit(state.copyWith(selectedMainList: mainList));
    } else {
      emit(
        state.copyWith(
          selectedRfidItemList: itemList,
          selectedMainList: itemList,
        ),
      );
    }
  }
}
