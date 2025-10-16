import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kdcreader/kdcreader.dart';

import '../../../../rfid_scanner/scanner.dart';
import '../../../domin/entities/stock_update_rfid_scanning_view_entity_model.dart';
import '../../../domin/failures/stock_update_failures.dart';
import '../../../domin/usecases/stock_update_rfid_scanning_view_usecase.dart';

part 'stock_update_rfid_scanning_event.dart';

part 'stock_update_rfid_scanning_state.dart';

class StockUpdateRfidScanningBloc
    extends Bloc<StockUpdateRfidScanningEvent, StockUpdateRfidScanningState> {
  StockUpdateRfidScanningBloc({
    required this.stockUpdateRfidScanningViewUseCase,
  }) : super(StockUpdateRfidScanningState.initial()) {
    on<StockUpdateRfidScanningEvent>((event, emit) async {
      switch (event) {
        case InitialScanningEvent():
          await initialScanning(event, emit);
        case StopScanningEvent():
          await _stopScanning(event, emit);
        case FetchRfidScanningListEvent():
          await _fetchAllScannedRfIdsListFromDb(event, emit);
        case UpdateRangeEvent():
          updateRange(event, emit);
        case StartScanningEvent():
          _startScanning(event, emit);
        case DisposeScanningEvent():
          disposeEvent(event, emit);

        case IsSelectedEvent():
          _isScannedItemsSelected(event, emit);
        case StockUpdateListingSearchEvent():
          _itemSearchFromDb(event, emit);
      }
    });
  }

  final StockUpdateRfidScanningViewUseCase stockUpdateRfidScanningViewUseCase;

  void _resetValues(
    InitialScanningEvent event,
    Emitter<StockUpdateRfidScanningState> emit,
  ) {
    emit(StockUpdateRfidScanningState.initial());
    emit(state.copyWith(isScanning: false, continueEnable: false));
  }

  void _isScannedItemsSelected(
    IsSelectedEvent event,
    Emitter<StockUpdateRfidScanningState> emit,
  ) {
    ///index -1 means the event is called for uncheck all the checked items
    if (event.completeSelect != true &&
        event.index != -1 &&
        state.viewList.length > event.index) {
      ///single check and un-check
      final updatedList = List.of(state.viewList);
      final mainList = List.of(state.mainList);

      updatedList[event.index] = updatedList[event.index].copyWith(
        isSelected: event.isSelectedValue,
      );

      ///this is needed for search area of listing
      if (updatedList.isNotEmpty) {
        for (int j = 0; j < mainList.length; j++) {
          for (int i = 0; i < updatedList.length; i++) {
            if (updatedList[i].itemId == mainList[j].itemId) {
              mainList[j] = updatedList[i];
            }
          }
        }
      }

      emit(
        state.copyWith(
          viewList: updatedList,
          mainList: mainList,
          isCompleteSelected: false,
        ),
      );
    }
    if (event.completeSelect == true) {
      ///for complete check
      final updatedList = List.of(state.viewList);
      for (int i = 0; i < updatedList.length; i++) {
        updatedList[i] = updatedList[i].copyWith(isSelected: true);
      }
      emit(state.copyWith(viewList: updatedList, isCompleteSelected: true));
    } else if (event.completeSelect == false && event.index == -1) {
      ///for complete  un-check
      final updatedList = List.of(state.viewList);
      for (int i = 0; i < updatedList.length; i++) {
        updatedList[i] = updatedList[i].copyWith(isSelected: false);
      }
      emit(state.copyWith(viewList: updatedList, isCompleteSelected: false));
    }
  }

  //search
  void _itemSearchFromDb(
    StockUpdateListingSearchEvent event,
    Emitter<StockUpdateRfidScanningState> emit,
  ) async {
    //checking the event is from search or onBack and searching the data isNotEmpty
    if (event.isSearch && event.searchText.trim().isNotEmpty) {
      List<StockUpdateRfidListingViewEntity> itemList = List.of(state.mainList);

      emit(
        state.copyWith(
          viewList:
              itemList
                  .where(
                    (element) => element.itemName.toLowerCase().contains(
                      event.searchText.toLowerCase(),
                    ),
                  )
                  .toList(),
        ),
      );
    } else {
      List<StockUpdateRfidListingViewEntity> isSelectedTrue =
          state.viewList
              .where((element) => element.isSelected == true)
              .toList();
      List<StockUpdateRfidListingViewEntity> itemList = List.of(state.mainList);
      for (int j = 0; j < isSelectedTrue.length; j++) {
        for (int i = 0; i < itemList.length; i++) {
          if (itemList[i].itemId == isSelectedTrue[j].itemId) {
            itemList[i] = itemList[i].copyWith(isSelected: true);
          }
        }
      }
      emit(state.copyWith(viewList: itemList));
    }
  }

  ///Rfid scaning

  void _startScanning(
    StartScanningEvent event,
    Emitter<StockUpdateRfidScanningState> emit,
  ) {
    emit(state.copyWith(isScanning: true));
  }

  void disposeEvent(
    DisposeScanningEvent event,
    Emitter<StockUpdateRfidScanningState> emit,
  ) {
    state.reader.disconnect();
    emit(state.copyWith(reader: Kdcreader(), rangeValue: 18));
  }

  Future<void> updateRange(
    UpdateRangeEvent event,
    Emitter<StockUpdateRfidScanningState> emit,
  ) async {
    log("Range stock update  ${event.range}");
    emit(state.copyWith(rangeValue: event.range));
  }

  Future<void> initialScanning(
    InitialScanningEvent event,
    Emitter<StockUpdateRfidScanningState> emit,
  ) async {
    emit(StockUpdateRfidScanningState.initial());
    emit(state.copyWith(isLoading: true));
    Either<bool, Kdcreader> reader = await initReader();
    reader.fold((failure) {
      log("Kreader init called failed");
    }, (reader) {
      log("Kreader init called success");
      emit(state.copyWith(reader: reader));
    });
    await Future.delayed(Duration(seconds: 2));
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _stopScanning(
    StopScanningEvent event,
    Emitter<StockUpdateRfidScanningState> emit,
  ) async {
    emit(state.copyWith(continueEnable: true));
    await state.scanController?.close();
    stopScan(reader: state.reader);
    var a = state.rfidList ?? [];
    log("Len ----------> ${a.length}");
    final failureOrSuccess = await stockUpdateRfidScanningViewUseCase(rfIds: a);
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(isLoading: false, stockUpdateFailures: some(failure)),
        );
      },
      (success) {
        emit(
          state.copyWith(
            isLoading: false,
            viewList: success,
            mainList: success,
          ),
        );
      },
    );
  }

  Future<void> _fetchAllScannedRfIdsListFromDb(
    FetchRfidScanningListEvent event,
    Emitter<StockUpdateRfidScanningState> emit,
  ) async {
    emit(
      state.copyWith(
        isScanning: true,
        isLoading: true,
        scanController: StreamController<String>(),
      ),
    );

    List<String> list = [];

    // forward values from startScan into controller
    startScan(
      state.reader,
      powerLevel: state.rangeValue.toInt(),
      interval: Duration(seconds: 1),
    ).listen((val) {
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
}
