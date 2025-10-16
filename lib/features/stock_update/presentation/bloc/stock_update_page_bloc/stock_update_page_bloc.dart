import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../common_feature/domain/usecase/common_usecase.dart';
import '../../../../item_master/domin/failures/item_master_failures.dart';
import '../../../../widgets/common_functions.dart';
import '../../../domin/entities/srock_update_entity_model.dart';
import '../../../domin/entities/stock_update_rfid_scanning_view_entity_model.dart';
import '../../../domin/usecases/stock_update_multiple_insert_usecase.dart';
import '../../../domin/usecases/stock_update_transaction_save_api_usecase.dart';

part 'stock_update_page_event.dart';
part 'stock_update_page_state.dart';

class StockUpdatePageBloc extends Bloc<StockUpdatePageEvent, StockUpdatePageState> {
  StockUpdatePageBloc({
    required this.commonUseCase,
    required this.stockUpdateMultipleInsertUseCase,
    required this.stockUpdateTrnSaveApiUseCase
}) : super(StockUpdatePageState.initial()) {
    on<StockUpdatePageEvent>((event, emit) async {
      switch(event){
        case ReadPreviousPageDataEvent():
          _readData(event,emit);
        case SaveTransactionListEvent():
          await _save(event, emit);
        case UpdateItemValue():
          _onValueOnChange(event, emit);
        case ResetStateEvent():
          _resetState(event, emit);
        case StockUpdateListSearchEvent():
          _itemSearch(event, emit);
      }
    });
  }

  final CommonUseCase commonUseCase;
  final StockUpdateMultipleInsertUseCase stockUpdateMultipleInsertUseCase;
  final StockUpdateTrnSaveApiUseCase stockUpdateTrnSaveApiUseCase;

  void _readData(ReadPreviousPageDataEvent event,Emitter<StockUpdatePageState> emit){
    emit(state.copyWith(selectedRfidItemList: event.selectedItemsList,selectedMainList: event.selectedItemsList));
  }

  Future<void> _save(
      SaveTransactionListEvent event,
      Emitter<StockUpdatePageState> emit,
      ) async {
    emit(state.copyWith(isSaveCompleted: false));
    List<StockUpdateEntity> insertList = [];

    // Create a new list to avoid modifying the state directly during iteration
    List<StockUpdateRfidListingViewEntity> validationList = List.from(state.selectedRfidItemList);
    bool hasError = false;

    for (int i = 0; i < validationList.length; i++) {
      if (validationList[i].newStockController == null || validationList[i].newStockController?.trim() == "" || validationList[i].newStockController?.trim() == "0") {
        validationList[i] = validationList[i].copyWith(showErrorConsumedQty: true);
        hasError = true;
      }

    }

    if (hasError) {
      emit(state.copyWith(selectedRfidItemList: validationList));
      return;
    }
    //checking any of the elements in the list has no value and return
    for (int i = 0; i < state.selectedRfidItemList.length; i++) {
      int quantity = int.parse(state.selectedRfidItemList[i].newStockController??"0");
      final StockUpdateEntity insertModel =
      StockUpdateEntity(
          id: generateMobRefId(),
          itemId: state.selectedRfidItemList[i].itemId,
          quantity: quantity,
          storageLocationId: state.selectedRfidItemList[i].defaultStorageLocationId,
          remarks: state.selectedRfidItemList[i].remarkController??"",
          modifiedOn: getCurrentFormattedDateTime(),
          syncStatus: "N",
          syncMerge: "Y",
          transactionId: generateMobRefId(),
          equipmentId: 0,
          locationId: 0,
          totalRob: state.selectedRfidItemList[i].rob??0,
          adjReconditionedStock: 0,
          adjNewStock: 0,
      );
      insertList.add(insertModel);

    }
    // Final check for errors before proceeding
    bool showErrorConsumedQyt = state.selectedRfidItemList.where((element) => element.showErrorConsumedQty == true).isNotEmpty;
    // bool showErrorConsumedQytRob = state.selectedItemsList.where((element) => element.showErrorConsumedQtyRob == true).isNotEmpty;
    if(showErrorConsumedQyt){
      return;
    }
    await stockUpdateMultipleInsertUseCase(list: insertList);
    await stockUpdateTrnSaveApiUseCase(); ///todo uncomment when api ready
    emit(state.copyWith(isSaveCompleted: true));
  }


  void _onValueOnChange(
      UpdateItemValue event,
      Emitter<StockUpdatePageState> emit,
      ){

    List<StockUpdateRfidListingViewEntity> updatedList = List.from(state.selectedRfidItemList);

    if(event.consumedQty != "" && !event.isForRemarks){
      int consumedQty = int.parse(event.consumedQty);
/*
      if (event.rob < consumedQty) {
        updatedList[event.index] = updatedList[event.index].copyWith(showErrorConsumedQtyRob: true);
        emit(state.copyWith(selectedItemsList: updatedList));
        return;
      } else {
        updatedList[event.index] =
            updatedList[event.index].copyWith(showErrorConsumedQtyRob: false);
      }*/
    }else{
      updatedList[event.index] = updatedList[event.index].copyWith(showErrorConsumedQty: true);
    }


    if(event.isForRemarks){
      updatedList[event.index] = updatedList[event.index].copyWith(remarkController: event.newValue);
    }else{
      // updatedList[event.index] = updatedList[event.index].copyWith(showErrorConsumedQtyRob: false);
      updatedList[event.index] = updatedList[event.index].copyWith(newStockController: event.newValue);
    }
    emit(state.copyWith(selectedRfidItemList: updatedList));

    //saving the entered value to the main list from the searched list
    List<StockUpdateRfidListingViewEntity> searchList = updatedList;
    List<StockUpdateRfidListingViewEntity> mainList = List.of(state.selectedMainList);
    for(int j=0 ; j<searchList.length ; j++){
      for(int i=0 ; i<mainList.length ; i++){
        if(searchList[j].itemId == mainList[i].itemId){
          mainList[i] = searchList[j];
        }
      }
    }

    emit(state.copyWith(selectedMainList: mainList));
  }

  void _resetState(
      ResetStateEvent event,
      Emitter<StockUpdatePageState> emit,
      ){
    emit(state.copyWith(selectedRfidItemList: []));
    StockUpdatePageState.initial();
  }

  void _itemSearch(
      StockUpdateListSearchEvent event,
      Emitter<StockUpdatePageState> emit,
      ) async {
    List<StockUpdateRfidListingViewEntity> itemList = List.of(state.selectedMainList);
    //checking the event is from search or onBack and searching the data isNotEmpty
    if(event.isSearch && event.searchText.trim().isNotEmpty) {

      emit(state.copyWith(selectedRfidItemList: itemList.where((element) =>
          element.itemName.toLowerCase().contains(event.searchText.toLowerCase())).toList()));

      //saving the entered value to the main list from the searched list
      List<StockUpdateRfidListingViewEntity> searchList = itemList.where((element) => element.itemName.toLowerCase().contains(event.searchText.toLowerCase())).toList();
      List<StockUpdateRfidListingViewEntity> mainList = List.of(state.selectedMainList);
      for(int j=0 ; j<searchList.length ; j++){
        for(int i=0 ; i<itemList.length ; i++){
          if(searchList[j].itemId == mainList[i].itemId){
            mainList[i] = searchList[j];
          }
        }
      }
      emit(state.copyWith(selectedMainList: mainList));

    }else {

      emit(state.copyWith(selectedRfidItemList: itemList,selectedMainList: itemList));
    }
  }



}
