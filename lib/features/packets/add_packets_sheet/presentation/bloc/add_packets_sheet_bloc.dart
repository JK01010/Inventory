import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import '../../domain/entities/packets_entity.dart';
import 'add_packets_sheet_bloc_event.dart';
import 'add_packets_sheet_bloc_state.dart';

class AddPacketsSheetBloc
    extends Bloc<AddPacketsSheetBlocEvent, AddPacketsSheetBlocState> {
  AddPacketsSheetBloc() : super(AddPacketsSheetBlocState.initial()) {
    on<AddPacketsSheetBlocEvent>((event, emit) async {
      switch (event) {
        case AddPacketSetInitialDataEvent():
          await onAddPacketSetInitialDataEvent(event, emit);
          break;
        case AddPacketEvent():
          onAddPacketEvent(event, emit);
          break;
        case PacketValueChangeEvent():
          onPacketValueChangeEvent(event, emit);
          break;
        case SavePacketsEvent():
          onSavePacketsEvent(event, emit);
          break;
      }
    });
  }

  Future<void> onAddPacketSetInitialDataEvent(
    AddPacketSetInitialDataEvent event,
    Emitter<AddPacketsSheetBlocState> emit,
  ) async {
    debugPrint("inside the onAddPacketSetInitialDataEvent *************");
    emit(
      state.copyWith(
        isLoading: false,
        packets: event.currentPackets,
        poHdId: event.poHdId,
      ),
    );
  }

  void onAddPacketEvent(
    AddPacketEvent event,
    Emitter<AddPacketsSheetBlocState> emit,
  ) async {
    debugPrint("inside the onAddPacketEvent *************");
    final List<PacketEntity> currentPackets = List<PacketEntity>.from(
      state.packets,
    );
    final currentCount = currentPackets.length;
    currentPackets.add(
      PacketEntity.initial().copyWith(
        id: DateTime.now().microsecondsSinceEpoch,
        packetName: "Packet ${currentCount + 1}",
        poHdId: state.poHdId,
      ),
    );
    emit(state.copyWith(packets: currentPackets));
  }

  void onPacketValueChangeEvent(
    PacketValueChangeEvent event,
    Emitter<AddPacketsSheetBlocState> emit,
  ) {
    if (event.newValue.isNotEmpty) {
      final selectedPacketItem = event.packetEntity;
      final PacketEntity? updatedPacketEntity;
      switch (event.packetTextFieldType) {
        case PacketTextFieldType.width:
          updatedPacketEntity = selectedPacketItem.copyWith(
            width: double.parse(event.newValue),
          );
          break;
        case PacketTextFieldType.length:
          updatedPacketEntity = selectedPacketItem.copyWith(
            length: double.parse(event.newValue),
          );
          break;
        case PacketTextFieldType.height:
          updatedPacketEntity = selectedPacketItem.copyWith(
            height: double.parse(event.newValue),
          );
          break;
        case PacketTextFieldType.weight:
          updatedPacketEntity = selectedPacketItem.copyWith(
            weight: double.parse(event.newValue),
          );
          break;
        case PacketTextFieldType.actualVolume:
          updatedPacketEntity = selectedPacketItem.copyWith(
            actualVolume: double.parse(event.newValue),
          );
          break;
        case PacketTextFieldType.packetName:
          updatedPacketEntity = selectedPacketItem.copyWith(
            packetName: event.newValue,
          );
          break;
      }
      final List<PacketEntity> currentPackets = List<PacketEntity>.from(
        state.packets,
      );
      final int index = currentPackets.indexOf(selectedPacketItem);
      if (index != -1) {
        double totalVolume =
            updatedPacketEntity.length *
            updatedPacketEntity.width *
            updatedPacketEntity.height;
        currentPackets[index] = updatedPacketEntity.copyWith(
          actualVolume: totalVolume,
        );
        debugPrint("totalVolume : $totalVolume");
        emit(state.copyWith(packets: currentPackets));
      }
    }
  }

  void onSavePacketsEvent(
    SavePacketsEvent event,
    Emitter<AddPacketsSheetBlocState> emit,
  ) {
    
  }
}
