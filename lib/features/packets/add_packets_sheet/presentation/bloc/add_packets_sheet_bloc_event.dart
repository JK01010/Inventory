import 'package:equatable/equatable.dart';

import '../../domain/entities/packets_entity.dart';

sealed class AddPacketsSheetBlocEvent extends Equatable {
  const AddPacketsSheetBlocEvent();

  @override
  List<Object> get props => [];
}

class AddPacketEvent extends AddPacketsSheetBlocEvent {}

class AddPacketSetInitialDataEvent extends AddPacketsSheetBlocEvent {
  const AddPacketSetInitialDataEvent({
    required this.currentPackets,
    required this.poHdId,
  });

  final List<PacketEntity> currentPackets;
  final int poHdId;
}

class SavePacketsEvent extends AddPacketsSheetBlocEvent {
  const SavePacketsEvent();
}

class PacketValueChangeEvent extends AddPacketsSheetBlocEvent {
  const PacketValueChangeEvent({
    required this.newValue,
    required this.packetTextFieldType,
    required this.packetEntity,
  });

  final String newValue;
  final PacketTextFieldType packetTextFieldType;
  final PacketEntity packetEntity;
}

enum PacketTextFieldType {
  width,
  length,
  height,
  weight,
  actualVolume,
  packetName,
}
