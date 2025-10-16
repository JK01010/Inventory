import 'package:equatable/equatable.dart';

import '../../../good_receipts/purchase_order_item_detail/domain/entity/serial_number_entity.dart';

sealed class SerialNumbersListingBlocEvent extends Equatable {
  const SerialNumbersListingBlocEvent();

  @override
  List<Object> get props => [];
}

class SetSerialNumbersInitialDataEvent extends SerialNumbersListingBlocEvent {
  const SetSerialNumbersInitialDataEvent({
    required this.currentSerialNumbers,
    required this.allSerialNumbers,
  });

  final List<SerialNumberEntity> currentSerialNumbers;
  final List<SerialNumberEntity> allSerialNumbers;
}

class ChangeAutoGenerateCheckBoxEvent extends SerialNumbersListingBlocEvent {
  const ChangeAutoGenerateCheckBoxEvent({required this.newValue});

  final bool newValue;
}

class ChangeSerialNumberEvent extends SerialNumbersListingBlocEvent {
  const ChangeSerialNumberEvent({required this.index, required this.newValue});

  final int index;
  final String newValue;
}

class SaveSerialNumbersEvent extends SerialNumbersListingBlocEvent {
  const SaveSerialNumbersEvent();
}
