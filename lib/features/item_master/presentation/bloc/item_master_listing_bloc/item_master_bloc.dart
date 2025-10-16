import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kdcreader/kdcreader.dart';

import '../../../../rfid_scanner/scanner.dart';
import '../../../domin/entities/item_master_common_entity_model.dart';
import '../../../domin/entities/item_master_filter_entity_model.dart';
import '../../../domin/entities/rfid_add_manually_view_model.dart';
import '../../../domin/failures/item_master_failures.dart';
import '../../../domin/usecases/fetch_all_rfid_list_db_usecase.dart';
import '../../../domin/usecases/fetch_serial_number_usecase.dart';
import '../../../domin/usecases/insert_item_group_usecase.dart';
import '../../../domin/usecases/insert_rfid_basedon_item_id_usecase.dart';
import '../../../domin/usecases/item_master_apply_filter_usecase.dart';
import '../../../domin/usecases/item_master_fetch_all_data.dart';
import '../../../domin/usecases/item_master_fetch_search_data.dart';
import '../../../domin/usecases/item_master_insert_use_case.dart';

part 'item_master_event.dart';

part 'item_master_state.dart';

class ItemMasterBloc extends Bloc<ItemMasterEvent, ItemMasterState> {
  ItemMasterBloc({
    required this.itemMasterInsertUseCase,
    required this.fetchAllDataItemMasterUseCase,
    required this.itemMasterApplyFilterUseCase,
    required this.fetchSerialNumberUseCase,
    required this.fetchSearchDataItemMasterUseCase,
    required this.itemGroupInsertUseCase,
    required this.itemMasterRfidListingInsertBasedOnItemIdUseCase,
    required this.fetchAllRfidListDbUseCase,
  }) : super(ItemMasterState.initial()) {
    on<ItemMasterEvent>((event, emit) async {
      switch (event) {
        case InsertItemMasterEvent():
          await _insertDataToDb(event, emit);
        case FetchAllDataItemMasterEvent():
          await _fetchAllDataFromDb(event, emit);
        case ApplyFilterItemMasterEvent():
          await _fetchFilterDataFromDb(event, emit);
        case LazyLoadingItemMasterEvent():
          await _fetchDataFromDbWithOffSet(event, emit);
        case ItemMasterSearchEvent():
          await _itemSearchFromDb(event, emit);

        case KdcReaderInitEvent():
          await _kdcReaderInit(event, emit);
        case KdcReaderStartScanEvent():
          await _kdcReaderStartScan(event, emit);
        case KdcReaderStopScanEvent():
          await _kdcReaderStopScan(event, emit);
        case KdcReaderUpdateRangeEvent():
          updateRange(event, emit);
        case KdcReaderDisposeEvent():
          disposeEvent(event, emit);

        case RfidSaveByItemIdEvent():
          await _saveRfidWithItemId(event, emit);
        case RfidSelectionEvent():
          _rfidSelection(event, emit);
      }
    });
  }

  final ItemMasterInsertUseCase itemMasterInsertUseCase;
  final FetchAllDataItemMasterUseCase fetchAllDataItemMasterUseCase;
  final ItemMasterApplyFilterUseCase itemMasterApplyFilterUseCase;
  final FetchSerialNumberUseCase fetchSerialNumberUseCase;
  final FetchSearchDataItemMasterUseCase fetchSearchDataItemMasterUseCase;
  final ItemGroupInsertUseCase itemGroupInsertUseCase;
  final FetchAllRfidListDbUseCase fetchAllRfidListDbUseCase;

  final ItemMasterRfidListingInsertBasedOnItemIdUseCase
  itemMasterRfidListingInsertBasedOnItemIdUseCase;

  Future<void> _insertDataToDb(
    InsertItemMasterEvent event,
    Emitter<ItemMasterState> emit,
  ) async {
    await itemMasterInsertUseCase();
    await fetchSerialNumberUseCase();
    await itemGroupInsertUseCase();
  }

  //DATA TAKING FROM DB FOR VIEW
  Future<void> _fetchAllDataFromDb(
    FetchAllDataItemMasterEvent event,
    Emitter<ItemMasterState> emit,
  ) async {
    emit(ItemMasterState.initial());
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    final failureOrSuccess = await fetchAllDataItemMasterUseCase(offSet: 0);
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(
            itemMasterFailures: some(failure),
            isLoading: false,
            isFilterEnable: false,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            itemMasterList: success,
            isLoading: false,
            isFilterEnable: false,
          ),
        );
      },
    );
  }

  //DATA TAKING FROM DB FOR FILTER
  Future<void> _fetchFilterDataFromDb(
    ApplyFilterItemMasterEvent event,
    Emitter<ItemMasterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    final ItemMasterFilterEntity filterModel = ItemMasterFilterEntity(
      itemName: event.itemName,
      equipmentName: event.equipmentName,
      articleNumber: event.articleNo,
      partNumber: event.partNo,
    );
    final failureOrSuccess = await itemMasterApplyFilterUseCase(filterModel);
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(
            itemMasterFailures: some(failure),
            isLoading: false,
            isFilterEnable: false,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            itemMasterList: success,
            isLoading: false,
            isFilterEnable: true,
          ),
        );
      },
    );
  }

  //DATA TAKING FROM DB WHILE SCROLLING
  Future<void> _fetchDataFromDbWithOffSet(
    LazyLoadingItemMasterEvent event,
    Emitter<ItemMasterState> emit,
  ) async {
    if (!state.hasMore) {
      return; // stop if no more data
    }

    final nextOffset = state.offSet + 10;
    final failureOrSuccess = await fetchAllDataItemMasterUseCase(
      offSet: nextOffset,
    );
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(itemMasterFailures: some(failure), isLoading: false),
        );
      },
      (success) {
        if (success.isEmpty) {
          emit(state.copyWith(hasMore: false, isLoading: false));
        } else {
          emit(
            state.copyWith(
              itemMasterList: List.from(state.itemMasterList)..addAll(success),
              offSet: nextOffset,
              isLoading: false,
            ),
          );
        }
      },
    );
  }

  //DATA TAKING FROM DB WHILE SEARCH
  Future<void> _itemSearchFromDb(
    ItemMasterSearchEvent event,
    Emitter<ItemMasterState> emit,
  ) async {
    //checking the event is from search or onBack and searching the data isNotEmpty
    if (event.isSearch && event.searchText.trim().isNotEmpty) {
      final failureOrSuccess = await fetchSearchDataItemMasterUseCase(
        searchText: event.searchText,
      );
      failureOrSuccess.fold(
        (failure) {
          emit(state.copyWith(itemMasterFailures: some(failure)));
        },
        (success) {
          emit(state.copyWith(searchList: success));
        },
      );
    } else {
      emit(state.copyWith(searchList: []));
    }
  }

  //RFID SCANNER FUNCTIONS USING FOR BOTH ADD_MANUALLY PAGE AND SCANNING RFID

  Future<void> _kdcReaderInit(
    KdcReaderInitEvent event,
    Emitter<ItemMasterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 2));
    Either<bool, Kdcreader> reader = await initReader();
    reader.fold(
      (failure) {
        log("Rfid not connected or connection failure");
        emit(state.copyWith(isLoading: false, isRfidDeviceConnected: false));
      },
      (reader) {
        emit(state.copyWith(reader: reader, isRfidDeviceConnected: true));
      },
    );
    emit(state.copyWith(isLoading: false));
  }

  void disposeEvent(
    KdcReaderDisposeEvent event,
    Emitter<ItemMasterState> emit,
  ) {
    state.reader.disconnect();
    emit(state.copyWith(reader: Kdcreader(), rangeValue: 18));
  }

  Future<void> updateRange(
    KdcReaderUpdateRangeEvent event,
    Emitter<ItemMasterState> emit,
  ) async {
    log("Range in item master ${event.range}");
    emit(state.copyWith(rangeValue: event.range));
  }

  Future<void> _kdcReaderStartScan(
    KdcReaderStartScanEvent event,
    Emitter<ItemMasterState> emit,
  ) async {

    List<String> allRfidFromDb = [];
    var rfidFromDb = await fetchAllRfidListDbUseCase();
    rfidFromDb.fold((failure) {}, (success) {
      allRfidFromDb = success;
    });

    emit(
      state.copyWith(
        isScanning: true,
        isLoading: false,
        scanController: StreamController<String>(),
        rfidList: [], // Clear the list when starting new scan
      ),
    );

    final list = <String>[];

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
          // Create a new list instance to trigger UI update
          final newList = List<String>.from(list);
          log("rfid -- ${newList.length}");
          //obtained rfid are append to a view model and push it to state
          List<RfidModel> rfidViewList = [];

          if(allRfidFromDb.isEmpty){
            //direct append to view model
            rfidViewList = newList.asMap().entries
                .map((entry) =>
                RfidModel(rfidCount: entry.key + 1,rfidName: entry.value))
                .toList();
          }else{
            //check if rfid is already present in db
            for(int i = 0;i<allRfidFromDb.length;i++){
              //if already present tagged them as true
              rfidViewList = newList.asMap().entries
                  .map((entry) =>
                  RfidModel(
                      rfidCount: entry.key + 1,
                      rfidName: entry.value,
                      isTaggedWithAnother: allRfidFromDb.contains(entry.value))
              ).toList();
            }

          }

          return state.copyWith(rfidList: rfidViewList);
        }
        return state; // Return current state if no change
      },
      onError: (_, _) => state.copyWith(isScanning: false, isLoading: false),
    );
  }

  Future<void> _kdcReaderStopScan(
    KdcReaderStopScanEvent event,
    Emitter<ItemMasterState> emit,
  ) async {
    await state.scanController?.close();
    stopScan(reader: state.reader);
    var a = state.rfidList;

    log("rfid -- ${a.length}");
    log("selected itemId -- ${event.selectedItemId}");

  /*  List<String> rfidListFromDb = [];
    var rfidFromDb = await fetchAllRfidListDbUseCase();
    rfidFromDb.fold((failure) {}, (success) {
      rfidListFromDb = success;
    });
    log("rfid -- ${rfidListFromDb.length}");

    List<String> commonRfidList = [];
    List<String> uniqueRfidListFromScan = [];

    for (String rfidInScan in state.rfidList) {
      if (rfidListFromDb.contains(rfidInScan)) {
        commonRfidList.add(rfidInScan);
      } else {
        uniqueRfidListFromScan.add(rfidInScan);
      }
    }

    emit(state.copyWith(selectedItemId: event.selectedItemId, rfidList: a));

    if (commonRfidList.isNotEmpty) {
      emit(state.copyWith(commonRfid: commonRfidList));
      return;
    }

    log("Common RFID List: ${commonRfidList.length}");
    log("Unique RFID List from Scan: ${uniqueRfidListFromScan.length}");*/

    if (event.selectedItemId != 0 && state.rfidList.isNotEmpty) {
      await itemMasterRfidListingInsertBasedOnItemIdUseCase(
        rfidList: state.rfidList
            .where((element) => element.isSelected && element.isTaggedWithAnother == false)
            .map((element) => element.rfidName)
            .toList(),
        itemId: event.selectedItemId,
      );
    }
    emit(state.copyWith(isScanning: false, rfidList: []));
  }

  Future<void> _saveRfidWithItemId(
    RfidSaveByItemIdEvent event,
    Emitter<ItemMasterState> emit,
  ) async {
    await itemMasterRfidListingInsertBasedOnItemIdUseCase(
      rfidList: state.rfidList
          .where((element) => element.isSelected && element.isTaggedWithAnother == false)
          .map((element) => element.rfidName)
          .toList(),
      itemId: event.selectedItemId,
    );
  }

  void _rfidSelection(
    RfidSelectionEvent event,
    Emitter<ItemMasterState> emit,
  ) {
    final updatedList = state.rfidList.map((rfidModel) {
      if (rfidModel.rfidName == event.rfidName) {
        return rfidModel.copyWith(isSelected: !rfidModel.isSelected);
      }
      return rfidModel;
    }).toList();

    emit(state.copyWith(rfidList: updatedList));
    // log("Selected RFID List: ${updatedList.where((element) => element?.isSelected).map((e) => e?.rfidName).toList()}");
  }
}
