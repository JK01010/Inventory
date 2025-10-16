import 'package:equatable/equatable.dart';
import '../../domain/entities/packets_entity.dart';

class AddPacketsSheetBlocState extends Equatable {
  const AddPacketsSheetBlocState({
    required this.isLoading,
    required this.packets,
    required this.poHdId,
    required this.isValidated,
    required this.validationErrorMessage,
  });

  factory AddPacketsSheetBlocState.initial() {
    return AddPacketsSheetBlocState(
      packets: [],
      isLoading: true,
      poHdId: -1,
      isValidated: false,
      validationErrorMessage: '',
    );
  }

  final bool isLoading;
  final List<PacketEntity> packets;
  final int poHdId;
  final bool isValidated;
  final String validationErrorMessage;

  @override
  List<Object?> get props => [
    isLoading,
    packets,
    poHdId,
    isValidated,
    validationErrorMessage,
  ];

  AddPacketsSheetBlocState copyWith({
    bool? isLoading,
    List<PacketEntity>? packets,
    int? poHdId,
    bool? isValidated,
    String? validationErrorMessage,
  }) {
    return AddPacketsSheetBlocState(
      isLoading: isLoading ?? this.isLoading,
      packets: packets ?? this.packets,
      poHdId: poHdId ?? this.poHdId,
      isValidated: isValidated ?? this.isValidated,
      validationErrorMessage:
          validationErrorMessage ?? this.validationErrorMessage,
    );
  }
}
