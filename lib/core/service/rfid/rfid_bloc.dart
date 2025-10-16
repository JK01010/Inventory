import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zebraRfid/zebraRfid.dart';

import 'domain/use_cases/connection_status_use_case.dart';
import 'domain/use_cases/disconnect_scanner_use_case.dart';
import 'domain/use_cases/initialize_rfid_use_case.dart';
import 'domain/use_cases/request_bluetooth_permission_use_case.dart';
import 'domain/use_cases/rfid_connect_use_case.dart';
import 'domain/use_cases/set_power_level_use_case.dart';
import 'domain/use_cases/start_scan_use_case.dart';
import 'domain/use_cases/stop_scan_use_case.dart';

part 'rfid_event.dart';
part 'rfid_state.dart';

class RfidBloc extends Bloc<RfidEvent, RfidState> {
  RfidBloc({
    required this.initializeRfidUseCase,
    required this.connectionStatus,
    required this.requestBluetoothPermissionUseCase,
    required this.rfidConnectionStatusUseCase,
    required this.rfidDisconnectUseCase,
    required this.rfidSetPowerLevelUseCase,
    required this.rfidStartScanUseCase,
    required this.rfidStopScanUseCase,
    required this.rfidConnectUseCase,
  }) : super(RfidState.initial()) {
    requestBluetoothPermissionUseCase();
    on<InitRfidEvent>((event, emit) {
      initializeRfidUseCase(callback: callback);
    });
    on<ConnectScannerEvent>((event, emit) async {
      rfidConnectUseCase();
    });

    on<StartScanEvent>((event, emit) async {
      rfidStartScanUseCase();
    });
    on<StopScanEvent>((event, emit) async {
      rfidStopScanUseCase();
      //  rfidDisconnectUseCase();
      emit(RfidState.initial());
    });

    on<DisconnectScannerEvent>((event, emit) async {
      rfidDisconnectUseCase();
    });
    on<SetPowerLevelEvent>((event, emit) async {
      rfidSetPowerLevelUseCase(powerLevel: event.powerLevel);
    });

    on<StartTrackEvent>((event, emit) {});
    on<RequestTagCountEvent>((event, emit) {});
    on<DispatchScanResultEvent>((event, emit) {
      emit(state.copyWith(tags: event.tags));
    });
    on<DispatchConnectionStatusEvent>((event, emit) {
      emit(state.copyWith(isConnected: isConnected));
    });
  }
  final RequestBluetoothPermissionUseCase requestBluetoothPermissionUseCase;
  final RfidConnectionStatusUseCase rfidConnectionStatusUseCase;
  final RfidDisconnectUseCase rfidDisconnectUseCase;
  final InitializeRfidUseCase initializeRfidUseCase;
  final RfidSetPowerLevelUseCase rfidSetPowerLevelUseCase;
  final RfidStartScanUseCase rfidStartScanUseCase;
  final RfidStopScanUseCase rfidStopScanUseCase;
  final RfidConnectUseCase rfidConnectUseCase;

  ZebraRfid? zebraRfid;
  Interfaces interface = Interfaces.rfidapi3;
  Status connectionStatus = Status.disconnected;
  String deviceInfo = "";
  bool isConnected = false;
  bool scanning = false;
  bool tracking = false;
  List<RfidTag> tags = [];

  void callback(Interfaces interface, Events event, dynamic data) {
    this.interface = interface;
    if (kDebugMode) {
      log("[RfidBloc] - callback section");
    }
    if (deviceInfo.isEmpty) {
      deviceInfo += "$event";
    } else {
      deviceInfo += " | $event";
    }

    switch (event) {
      case Events.readBarcode:
        // Barcode logic
        break;

      case Events.readRfid:
        tags.clear();
        if (data is List<RfidTag>) {
          for (RfidTag tag in data) {
            tags.add(tag);

            if (kDebugMode) {
              print(
                "Tag: ${tag.epc} Rssi: ${tag.rssi}  Seen: ${tag.seen} Interface: ${tag.interface}",
              );
            }
          }
        }
        // ignore: always_put_control_body_on_new_line
        if (interface == Interfaces.datawedge && scanning) scanning = false;
        break;

      case Events.error:
        if (data is Error) {
          if (kDebugMode) {
            log("Interface: $interface Error: ${data.message}");
          }
        }
        break;

      case Events.connectionStatus:
        if (data is ConnectionStatus) {
          if (data.status == Status.connected) {
            isConnected = true;
          } else {
            isConnected = false;
          }
          add(DispatchConnectionStatusEvent());
          if (kDebugMode) {
            print("Interface: $interface ConnectionStatus: ${data.status}");
          }
        }
        if (data.status != connectionStatus) {
          connectionStatus = data.status;
        }
        break;

      case Events.reading:
        tags.clear();
        if (data is List<RfidTag>) {
          for (RfidTag tag in data) {
            log("[READING-INFO] current tag is - ${tag.epc}");
            tags.add(tag);
          }
        }
        if (interface == Interfaces.datawedge && scanning) {
          scanning = false;
        }
        add(DispatchScanResultEvent(tags: tags));
        break;

      default:
        if (kDebugMode) {
          if (kDebugMode) {
            print("Interface: $interface Unknown Event: $event");
          }
        }
    }
  }

  void startScanning() {
    zebraRfid?.setMode(Modes.rfid);
    zebraRfid?.startScanning();
    tags.clear();
    scanning = true;
    tracking = false;
  }

  void stopScanning() {
    zebraRfid?.stopScanning();
    scanning = false;
    tracking = false;
  }
}
