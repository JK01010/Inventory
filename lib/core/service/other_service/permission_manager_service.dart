import 'package:permission_handler/permission_handler.dart';

abstract interface class PermissionManagerService {
  Future<PermissionStatus> requestBluetoothPermission();
  Future<PermissionStatus> requestBluetoothAdvertise();
  Future<PermissionStatus> requestBluetoothConnect();
  Future<PermissionStatus> requestBluetoothScan();
}

class PermissionManagerServiceImpl implements PermissionManagerService {
  PermissionManagerServiceImpl();

  @override
  Future<PermissionStatus> requestBluetoothPermission() async {
    return Permission.bluetooth.request();
  }

  @override
  Future<PermissionStatus> requestBluetoothAdvertise() {
    return Permission.bluetoothAdvertise.request();
  }

  @override
  Future<PermissionStatus> requestBluetoothConnect() {
    return Permission.bluetoothConnect.request();
  }

  @override
  Future<PermissionStatus> requestBluetoothScan() {
    return Permission.bluetoothScan.request();
  }
}
