import 'package:equatable/equatable.dart';

import '../../../good_receipts/purchase_order_item_detail/domain/entity/serial_number_entity.dart';

class SerialNumbersListingBlocState extends Equatable {
  const SerialNumbersListingBlocState({
    required this.isAutoGenerateEnabled,
    required this.editedSerialNumbers,
    required this.isLoading,
    required this.allSerialNumbers,
    required this.isValidated,
    required this.currentSerialNumbers,
    required this.validationMessage,
  });

  factory SerialNumbersListingBlocState.initial() {
    return SerialNumbersListingBlocState(
      currentSerialNumbers: [],
      isAutoGenerateEnabled: true,
      isLoading: true,
      allSerialNumbers: [],
      isValidated: false,
      editedSerialNumbers: [],
      validationMessage: '',
    );
  }

  final bool isAutoGenerateEnabled;
  final List<SerialNumberEntity> editedSerialNumbers;
  final bool isLoading;
  final List<SerialNumberEntity> allSerialNumbers;
  final bool isValidated;
  final List<SerialNumberEntity> currentSerialNumbers;
  final String validationMessage;

  @override
  List<Object?> get props => [
    isAutoGenerateEnabled,
    editedSerialNumbers,
    isLoading,
    allSerialNumbers,
    isValidated,
    currentSerialNumbers,
    validationMessage,
  ];

  SerialNumbersListingBlocState copyWith({
    bool? isAutoGenerateEnabled,
    List<SerialNumberEntity>? currentSerialNumbers,
    bool? isLoading,
    List<SerialNumberEntity>? allSerialNumbers,
    bool? isValidated,
    List<SerialNumberEntity>? editedSerialNumbers,
    String? validationMessage,
  }) {
    return SerialNumbersListingBlocState(
      isAutoGenerateEnabled:
          isAutoGenerateEnabled ?? this.isAutoGenerateEnabled,
      currentSerialNumbers: currentSerialNumbers ?? this.currentSerialNumbers,
      isLoading: isLoading ?? this.isLoading,
      allSerialNumbers: allSerialNumbers ?? this.allSerialNumbers,
      isValidated: isValidated ?? this.isValidated,
      editedSerialNumbers: editedSerialNumbers ?? this.editedSerialNumbers,
      validationMessage: validationMessage ?? this.validationMessage,
    );
  }
}
