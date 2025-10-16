import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../good_receipts/purchase_order_item_detail/domain/entity/serial_number_entity.dart';
import 'serial_numbers_listing_bloc_event.dart';
import 'serial_numbers_listing_bloc_state.dart';

class SerialNumbersListingBloc
    extends Bloc<SerialNumbersListingBlocEvent, SerialNumbersListingBlocState> {
  SerialNumbersListingBloc() : super(SerialNumbersListingBlocState.initial()) {
    on<SerialNumbersListingBlocEvent>((event, emit) async {
      switch (event) {
        case SetSerialNumbersInitialDataEvent():
          await onSetSerialNumbersInitialDataEvent(event, emit);
          break;
        case ChangeAutoGenerateCheckBoxEvent():
          onChangeAutoGenerateCheckBoxEvent(event, emit);
          break;
        case ChangeSerialNumberEvent():
          onChangeSerialNumberEvent(event, emit);
          break;
        case SaveSerialNumbersEvent():
          onSaveSerialNumbersEvent(event, emit);
      }
    });
  }

  Future<void> onSetSerialNumbersInitialDataEvent(
    SetSerialNumbersInitialDataEvent event,
    Emitter<SerialNumbersListingBlocState> emit,
  ) async {
    emit(
      state.copyWith(
        currentSerialNumbers: [],
        isLoading: true,
        editedSerialNumbers: [],
        allSerialNumbers: [],
      ),
    );
    await Future.delayed(Duration(milliseconds: 100), () {
      emit(
        state.copyWith(
          currentSerialNumbers: event.currentSerialNumbers,
          isAutoGenerateEnabled: true,
          isLoading: false,
          allSerialNumbers: event.allSerialNumbers,
          editedSerialNumbers: event.currentSerialNumbers,
        ),
      );
    });
  }

  void onChangeAutoGenerateCheckBoxEvent(
    ChangeAutoGenerateCheckBoxEvent event,
    Emitter<SerialNumbersListingBlocState> emit,
  ) async {
    debugPrint("event.value : ${event.newValue}");
    emit(
      state.copyWith(isAutoGenerateEnabled: event.newValue, isLoading: false),
    );
  }

  void onChangeSerialNumberEvent(
    ChangeSerialNumberEvent event,
    Emitter<SerialNumbersListingBlocState> emit,
  ) async {
    debugPrint("onChangeSerialNumberEvent index    ::: ${event.index}");
    debugPrint("onChangeSerialNumberEvent newValue ::: ${event.newValue}");
    List<SerialNumberEntity> serialNumbers = List<SerialNumberEntity>.from(
      state.editedSerialNumbers,
    );
    final selectedSerialNumber = serialNumbers[event.index];
    final updatedSerialNumber = selectedSerialNumber.copyWith(
      serialNumber: event.newValue,
      isManuallyEdited: true,
    );
    serialNumbers[event.index] = updatedSerialNumber;
    emit(state.copyWith(editedSerialNumbers: serialNumbers));
    // emit(state.copyWith(isAutoGenerateEnabled: event.newValue));
  }

  void onSaveSerialNumbersEvent(
    SaveSerialNumbersEvent event,
    Emitter<SerialNumbersListingBlocState> emit,
  ) async {
    final serialNumbersBeforeEdit =
        state.currentSerialNumbers
            .map((element) => element.serialNumber)
            .toList();
    debugPrint("serialNumbersBeforeEdit : $serialNumbersBeforeEdit");

    final editedSerialNumbers =
        state.editedSerialNumbers
            .map((element) => element.serialNumber)
            .toList();
    debugPrint("editedSerialNumbers : $editedSerialNumbers");
    final allSerialNumbers =
        state.allSerialNumbers.map((element) => element.serialNumber).toList();
    debugPrint("allSerialNumbers : $allSerialNumbers");

    final mainSet =
        allSerialNumbers.toSet()
          // Step 2: Remove the old values (the ones user is editing)
          ..removeAll(serialNumbersBeforeEdit);

    // Step 3: Find duplicates between edited values and remaining main list
    final duplicates = editedSerialNumbers.toSet().intersection(mainSet);
    if (duplicates.isNotEmpty) {
      emit(
        state.copyWith(
          validationMessage:
              'Serial number already exists: ${duplicates.toString()}',
          isValidated: false,
        ),
      );
      emit(state.copyWith(isValidated: true));
    } else {
      emit(state.copyWith(validationMessage: '', isValidated: true));
      emit(state.copyWith(validationMessage: '', isValidated: false));
    }

    // emit(state.copyWith(isAutoGenerateEnabled: event.newValue));
  }
}
