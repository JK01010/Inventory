import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zebraRfid/zebraRfid.dart';

import '../../../other_service/permission_manager_service.dart';
import '../../domain/failure/rfid_failure.dart';

abstract interface class RfIdLocalDataSource {
  void initializeRfId({required dynamic callback});
  void connect();
  void setPowerLevel({required int powerLevel});
  Status connectionStatus();
  void startScan();
  void stopScanner();
  void disconnectScanner();
  void bluetoothPermission();
}

class RfIdLocalDataSourceImpl implements RfIdLocalDataSource {
  RfIdLocalDataSourceImpl({required this.permissionManagerService});

  late ZebraRfid zebraRfid;
  final PermissionManagerService permissionManagerService;

  @override
  Future<Unit> connect() async {
    await zebraRfid.connect();
    return unit;
  }

  @override
  Unit initializeRfId({required dynamic callback}) {
    zebraRfid = ZebraRfid(callback: callback);

    return unit;
  }

  @override
  Status connectionStatus() {
    return zebraRfid.connectionStatus;
  }

  @override
  void disconnectScanner() {
    zebraRfid.disconnect().then((value) {
      log(value.toString());
    });
  }

  @override
  void setPowerLevel({required int powerLevel}) {
    zebraRfid.setPowerLevel(powerLevel);
  }

  @override
  void startScan() {
    zebraRfid.startScanning();
  }

  @override
  void stopScanner() {
    zebraRfid.stopScanning().then((value) {
      log(value.toString());
    });
  }

  @override
  Future<Unit> bluetoothPermission() async {
    final bluetoothStatus =
        await permissionManagerService.requestBluetoothPermission();
    final bluetoothConnectstatus =
        await permissionManagerService.requestBluetoothConnect();
    final bluetoothAdvertiseStatus =
        await permissionManagerService.requestBluetoothAdvertise();
    final bluetoothScanStatus =
        await permissionManagerService.requestBluetoothScan();

    if (bluetoothScanStatus.isGranted &&
        bluetoothStatus.isGranted &&
        bluetoothConnectstatus.isGranted &&
        bluetoothAdvertiseStatus.isGranted) {
      return unit;
    } else {
      throw BluetoothPermissionFailure();
    }
  }
}
