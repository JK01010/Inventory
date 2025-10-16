import 'dart:async';

import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kdcreader/kdcreader.dart';
import 'package:path/path.dart';
import '../../../../consumption/data/models/consumption_equipment_list_fetch_api_response_model.dart';
import '../../../../rfid_scanner/scanner.dart';
import '../../../domain/entities/bagging_confirmation_list_entity.dart';
import '../../../domain/failures/bagging_and_tagging_failures.dart';
import '../../../domain/usecase/fetch_all_item_id_on_rfid_scan_use_case.dart';
import '../../../domain/usecase/fetch_all_location_on_rfid_scan_usecase.dart';
import '../../../domain/usecase/fetch_confirmation_list_usecase.dart';
import '../../../domain/usecase/fetching_confirmation_storage_location_usecase.dart';
import '../../../domain/usecase/get_bagging_confirmation_list_usecase.dart';
import '../../../domain/usecase/insert_bagging_confirmation_list_usecase.dart';
import '../../../model/confirmation_selection_model.dart';

part 'bagging_confirmation_list_event.dart';

part 'bagging_confirmation_list_state.dart';

class BaggingConfirmationListBloc
    extends Bloc<BaggingConfirmationListEvent, BaggingConfirmationListState> {
  BaggingConfirmationListBloc({
    required this.insertBaggingConfirmationListUsecase,
    required this.getAllBaggingConfirmationListUsecase,
    required this.fetchingConfirmationStorageLocationUsecase,
    required this.fetchAllLocationOnRfidScanUseCase,
    required this.fetchConfirmationListUseCase,
    required this.fetchAllItemIdOnRfidScanUseCase,
  }) : super(BaggingConfirmationListState.initial()) {
    on<BaggingConfirmationListEvent>((event, emit) async {
      switch (event) {
        case BaggingConfirmationListInsertDataEvent():
          await insertBaggingConfirmationList(event, emit);
        case BaggingConfirmationListGetAllDataEvent():
          await getAllBaggingConfirmationList(event, emit);
        case BaggingConfirmationListStorageLocationEvent():
          await getAllStorageLocationList(event, emit);
        case IsCheckBoxSelectedEvent():
          await isCheckBoxSelectedEvent(event, emit);
        case IsAllItemsSelectEvent():
          isAllItemsSelectEvent(event, emit);

        //kdcReader
        case KdcReaderInitEvent():
          await _kdcReaderInit(event, emit);
        case KdcReaderStartScanEvent():
          await _kdcReaderStartScan(event, emit);
        case KdcReaderStopScanEvent():
          await _kdcReaderStopScan(event, emit);

        case KdcReaderUpdateRangeEvent():
          _updateRange(event, emit);
        case KdcReaderDisposeEvent():
          _disposeEvent(event, emit);

        case FetchConfirmationListByItemIdsEvent():
          await _fetchConfirmationListByItemIds(event, emit);
        case FetchConfirmationListByGRNIdEvent():
          await _fetchConfirmationListByGRNId(event, emit);
        case SaveConfirmationEvent():
          await _saveConfirmation(event, emit);
          
        case BaggingConfirmationListResetEvent():
          emit(BaggingConfirmationListState.initial());
      }
    });
  }

  final InsertBaggingConfirmationListUsecase
  insertBaggingConfirmationListUsecase;
  final GetAllBaggingConfirmationListUsecase
  getAllBaggingConfirmationListUsecase;
  final FetchingConfirmationStorageLocationUsecase
  fetchingConfirmationStorageLocationUsecase;
  final FetchAllLocationOnRfidScanUseCase fetchAllLocationOnRfidScanUseCase;
  final FetchConfirmationListUseCase fetchConfirmationListUseCase;
  final FetchAllItemIdOnRfidScanUseCase fetchAllItemIdOnRfidScanUseCase;

  Future<void> insertBaggingConfirmationList(
    BaggingConfirmationListEvent event,
    Emitter<BaggingConfirmationListState> emit,
  ) async {
    await insertBaggingConfirmationListUsecase();
  }

  Future<void> getAllBaggingConfirmationList(
    BaggingConfirmationListGetAllDataEvent event,
    Emitter<BaggingConfirmationListState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    final failureOrSuccess = await getAllBaggingConfirmationListUsecase();
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(
            baggingAndTaggingFailures: some(failure),
            isLoading: false,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            baggingConfirmationListEntity: success,
            isLoading: false,
          ),
        );
      },
    );
  }

  Future<void> getAllStorageLocationList(
    BaggingConfirmationListStorageLocationEvent event,
    Emitter<BaggingConfirmationListState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    final failureOrSuccess = await fetchingConfirmationStorageLocationUsecase(
      storageLocationId: event.selectedGrnId,
    );
    emit(state.copyWith(selectedGrnId: event.selectedGrnId));
    failureOrSuccess.fold(
      (failure) {
        emit(state.copyWith(storageLocation: "", isLoading: false));
      },
      (success) {
        emit(state.copyWith(storageLocation: success, isLoading: false));
      },
    );
  }

  Future<void> isCheckBoxSelectedEvent(
    IsCheckBoxSelectedEvent event,
    Emitter<BaggingConfirmationListState> emit,
  ) async {

    List<LocationModelForConfirmation> updateList = List.of(state.locList);
    if (event.index >= 0 && event.index < updateList.length) {
      updateList[event.index].isSelected = !(event.isSelectedValue);
    }

    if(event.isSelectedValue == true){
      for (int i = 0; i < updateList.length; i++) {
        if (i != event.index) {
          updateList[i].isSelected = false;
        }
      }
    }

    emit(state.copyWith(locList: updateList));
  }

  void isAllItemsSelectEvent(
    IsAllItemsSelectEvent event,
    Emitter<BaggingConfirmationListState> emit,
  ) {
    final List<BaggingConfirmationListEntity>
    currentBaggingTaggingConfirmationList = List.from(
      state.baggingConfirmationListEntity,
    );
    List<BaggingConfirmationListEntity> updatedList = [];
    if (event.isSelected == true) {
      updatedList =
          currentBaggingTaggingConfirmationList.map((element) {
            element.isSelected = true;
            return element;
          }).toList();
    } else {
      updatedList =
          currentBaggingTaggingConfirmationList.map((element) {
            element.isSelected = false;
            return element;
          }).toList();
    }
    emit(
      state.copyWith(
        isCompleteSelected: event.isSelected,
        baggingConfirmationListEntity: updatedList,
      ),
    );
  }

  //kdcReader

  Future<void> _kdcReaderInit(
    KdcReaderInitEvent event,
    Emitter<BaggingConfirmationListState> emit,
  ) async {
    Either<bool, Kdcreader> reader = await initReader();
    reader.fold(
      (failure) {
        // emit(
        //   state.copyWith(isLoading: false,consumptionFailures: some(failure)),
        // );
      },
      (reader) {
        emit(state.copyWith(reader: reader));
      },
    );
  }

  void _disposeEvent(
    KdcReaderDisposeEvent event,
    Emitter<BaggingConfirmationListState> emit,
  ) {
    state.reader.disconnect();
    emit(state.copyWith(reader: Kdcreader(), rangeValue: 18));
  }

  void _updateRange(
    KdcReaderUpdateRangeEvent event,
    Emitter<BaggingConfirmationListState> emit,
  ) {
    emit(state.copyWith(rangeValue: event.range));
  }

  Future<void> _kdcReaderStartScan(
    KdcReaderStartScanEvent event,
    Emitter<BaggingConfirmationListState> emit,
  ) async {
    emit(
      state.copyWith(
        isScanning: true,
        isLoading: true,
        scanController: StreamController<String>(),
        rfidList: [], // Clear the list when starting new scan
      ),
    );

    final list = <String>[];

    // forward values from startScan into controller
    startScan(
      state.reader,
      powerLevel: state.rangeValue,
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
          return state.copyWith(rfidList: newList);
        }
        return state; // Return current state if no change
      },
      onError: (_, __) => state.copyWith(isScanning: false, isLoading: false),
    );
  }

  Future<void> _kdcReaderStopScan(
    KdcReaderStopScanEvent event,
    Emitter<BaggingConfirmationListState> emit,
  ) async {
    await state.scanController?.close();
    stopScan(reader: state.reader);
    var a = state.rfidList;
    emit(state.copyWith(isScanning: false, isContinueEnable: true));
    log("rfid -- ${a.length}");
    var allItemListBasedOnRfid = await fetchAllItemIdOnRfidScanUseCase(rfid: a);
    allItemListBasedOnRfid.fold(
          (failure) {},
          (success) {
            emit(state.copyWith(rfidItemIds: success));
          });

    var locNameList = await fetchAllLocationOnRfidScanUseCase(rfid: a, grnId: state.selectedGrnId, itemId: 0);
    locNameList.fold(
          (failure) {},
          (success) {

        List<Map<String, dynamic>> locNameMaps = success;
 /*    *//*   List<String> locNameList = locNameMaps
            .map((map) => map['LocName'] as String)
            .toList();
        List<int> locIdList = locNameMaps
            .map((map) => m*//*ap['storageLocationId'] as int)
            .toList();*/

        List<LocationModelForConfirmation> locationModels = locNameMaps
            .map((map) => LocationModelForConfirmation(
                itemId: map['itemId'] as int,
                locName: map['LocName'] as String,
                locId: map['storageLocationId'] as int))
            .toList();

      emit(state.copyWith(locList: locationModels));
      log("Location Names: $locNameList");
    });
  }




  Future<void> _fetchConfirmationListByItemIds(
    FetchConfirmationListByItemIdsEvent event,
    Emitter<BaggingConfirmationListState> emit,
  ) async {
    ///emit loading state and clear list
    emit(state.copyWith(isConfirmationListLoading: true, confirmationListByItemIds: []));

    final failureOrSuccess = await fetchConfirmationListUseCase.byItemIds(
      itemIds: event.itemIds,
      storageLocationId: event.storageLocationId,
      grnId: event.grnId
    );

    failureOrSuccess.fold((failure) {}, (success) {
      debugPrint("Success fetchConfirmationListUseCase.byItemIds : $success");
      emit(
        state.copyWith(
          confirmationListByItemIds: success,
          isConfirmationListLoading: false,
        ),
      );
    });
  }

  Future<void> _fetchConfirmationListByGRNId(
    FetchConfirmationListByGRNIdEvent event,
    Emitter<BaggingConfirmationListState> emit,
  ) async {
    ///emit loading state and clear list
    emit(state.copyWith(isConfirmationListLoading: true, confirmationListByGRNId: []));

    final failureOrSuccess = await fetchConfirmationListUseCase.byGRNId(
    grnId: event.grnId,
    );

    failureOrSuccess.fold((failure) {}, (success) {
      debugPrint("Success fetchConfirmationListUseCase.byGRNId : $success");
      emit(
        state.copyWith(
          confirmationListByGRNId: success,
          isConfirmationListLoading: false,
        ),
      );
    });
  }

  Future<void> _saveConfirmation(
      SaveConfirmationEvent event,
      Emitter<BaggingConfirmationListState> emit,
      ) async {

    final failureOrSuccess = await fetchConfirmationListUseCase.saveConfirmation(
      grnId: event.grnId,
      itemIds: state.rfidItemIds
    );

    failureOrSuccess.fold((failure) {}, (success) {
      debugPrint("Success SaveConfirmation : ${success}");
    });
  }
}