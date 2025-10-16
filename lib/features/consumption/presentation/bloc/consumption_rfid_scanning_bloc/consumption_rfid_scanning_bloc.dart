import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kdcreader/kdcreader.dart';

import '../../../../rfid_scanner/scanner.dart';
import '../../../domin/entities/consumption_rfid_scanning_view_entity_model.dart';
import '../../../domin/failures/consumption_failures.dart';
import '../../../domin/usecases/consumption_rfid_scanning_view_usecase.dart';

part 'consumption_rfid_scanning_event.dart';
part 'consumption_rfid_scanning_state.dart';

class ConsumptionRfidScanningBloc extends Bloc<ConsumptionRfidScanningEvent, ConsumptionRfidScanningState> {
  ConsumptionRfidScanningBloc({
    required this.consumptionRfidScanningViewUseCase
}): super(ConsumptionRfidScanningState.initial()){
    on<ConsumptionRfidScanningEvent>((event, emit) async {
      switch(event){

        case StartScanningEvent():
          _startScanning(event,emit);
        case InitialScanningEvent():
         await  _initReader(event,emit);
        case StopScanningEvent():
        await  _stopScanning(event,emit);

        case FetchRfidScanningListEvent():
          await _fetchAllScannedRfIdsListFromDb(event,emit);
        case IsSelectedEvent():
          _isScannedItemsSelected(event,emit);

        case UpdateRangeEvent():
         await updateRange(event,emit);
        case DisposeScanningEvent():
           disposeEvent(event,emit);

        case StockUpdateListingSearchEvent():
          _itemSearchFromDb(event,emit);
      }
    });
  }

  final ConsumptionRfidScanningViewUseCase consumptionRfidScanningViewUseCase;

  void _startScanning(StartScanningEvent event, Emitter<ConsumptionRfidScanningState> emit){
    emit(state.copyWith(isScanning: true));
  }

  void disposeEvent(DisposeScanningEvent event, Emitter<ConsumptionRfidScanningState> emit){
    state.reader.disconnect();
    emit(state.copyWith(reader:  Kdcreader(),rangeValue: 18));
  }

  Future<void> updateRange(UpdateRangeEvent event, Emitter<ConsumptionRfidScanningState> emit)async{
    log("Range consumption  ${event.range}");
    emit(state.copyWith(rangeValue: event.range));
  }

  Future<void> _initReader(InitialScanningEvent event, Emitter<ConsumptionRfidScanningState> emit)async{
    emit(ConsumptionRfidScanningState.initial());
    emit(state.copyWith(isLoading:true));
    Either<bool, Kdcreader> reader = await initReader();
    reader.fold(
          (failure) {
        // emit(
        //   state.copyWith(isLoading: false,consumptionFailures: some(failure)),
        // );
      },
          (reader) {
        emit(
          state.copyWith(reader: reader),
        );
      },
    );
    await Future.delayed(Duration(seconds: 2));
    emit(state.copyWith(isLoading:false));
  }

  Future<void> _stopScanning(StopScanningEvent event, Emitter<ConsumptionRfidScanningState> emit)async{
    emit(state.copyWith(continueEnable: true));
    await state.scanController?.close();
    stopScan(reader: state.reader);
   var a = state.rfidList??[];
   log("Len ----------> ${a.length}");
    final failureOrSuccess = await consumptionRfidScanningViewUseCase(rfIds:a);
    failureOrSuccess.fold(
          (failure) {
        emit(
          state.copyWith(isLoading: false,consumptionFailures: some(failure)),
        );
      },
          (success) {
        emit(
          state.copyWith(isLoading: false,viewLists: success,mainList: success),
        );
      },
    );
  }

  Future<void> _fetchAllScannedRfIdsListFromDb(
      FetchRfidScanningListEvent event,
      Emitter<ConsumptionRfidScanningState> emit,
      ) async {
    emit(state.copyWith(isScanning: true, isLoading: true,scanController:StreamController<String>() ));

    List<String> list = [];


    // forward values from startScan into controller
    startScan(state.reader, powerLevel: state.rangeValue.toInt(), interval: Duration(seconds: 1))
        .listen((val) {
      state.scanController?.add(val);
    });

    await emit.forEach<String>(
      state.scanController!.stream,
      onData: (val) {
        log("RFID in Bloc: $val");
        if (!list.contains(val)) {
          list.add(val);
        }
        log("rfid -- ${list.length}");
        return state.copyWith(rfidList: list);
      },
      onError: (_, __) => state.copyWith(isScanning: false, isLoading: false),
    );
  }

  void _isScannedItemsSelected(IsSelectedEvent event, Emitter<ConsumptionRfidScanningState> emit) {
    ///index -1 means the event is called for uncheck all the checked items
    if (event.completeSelect !=true && event.index != -1 && state.viewList.length > event.index) {
      ///single check and un-check
      final updatedList = List.of(state.viewList);
      final mainList = List.of(state.mainList);
      updatedList[event.index] = updatedList[event.index].copyWith(isSelected: event.isSelectedValue);

      ///this is needed for search area of listing
      if(updatedList.isNotEmpty){
        for(int j=0 ; j<mainList.length ; j++){
          for(int i=0 ; i<updatedList.length ; i++){
            if(updatedList[i].itemId == mainList[j].itemId){
              mainList[j] = updatedList[i];
            }
          }
        }
      }

      emit(state.copyWith(
          viewLists: updatedList,
          mainList: mainList,
          isCompleteSelected: false));
    }
    if(event.completeSelect == true){
      ///for complete check
      final updatedList = List.of(state.viewList);
      for(int i = 0 ; i< updatedList.length ; i++){
        updatedList[i] = updatedList[i].copyWith(isSelected:true);
      }
      emit(state.copyWith(viewLists: updatedList,isCompleteSelected: true));
    }else if(event.completeSelect == false && event.index == -1){
      ///for complete  un-check
      final updatedList = List.of(state.viewList);
      for(int i = 0 ; i< updatedList.length ; i++){
        updatedList[i] = updatedList[i].copyWith(isSelected:false);
      }
      emit(state.copyWith(viewLists: updatedList,isCompleteSelected: false));
    }

  }

  //search
  void _itemSearchFromDb(
      StockUpdateListingSearchEvent event,
      Emitter<ConsumptionRfidScanningState> emit,
      ) async {
    //checking the event is from search or onBack and searching the data isNotEmpty
    if(event.isSearch && event.searchText.trim().isNotEmpty) {

      List<ConsumptionRfidListingViewEntity> itemList = List.of(state.mainList);

      emit(state.copyWith(viewLists: itemList.where((element) =>
          element.itemName.toLowerCase().contains(event.searchText.toLowerCase())).toList()));

    }else {
      List<ConsumptionRfidListingViewEntity> isSelectedTrue = state.viewList.where((element) => element.isSelected == true).toList();
      List<ConsumptionRfidListingViewEntity> itemList = List.of(state.mainList);
      for(int j=0 ; j<isSelectedTrue.length ; j++){
        for(int i=0 ; i<itemList.length ; i++){
          if(itemList[i].itemId == isSelectedTrue[j].itemId){
            itemList[i] = itemList[i].copyWith(isSelected: true);
          }
        }
      }
      emit(state.copyWith(viewLists: itemList));
    }
  }

}
