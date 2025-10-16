import 'package:flutter/services.dart';

class SWComponentViewControllerInterface {
  late MethodChannel _channel;

  SWComponentViewControllerInterface(int id) {
    _channel = MethodChannel('plugins.flutter.koamtac/swcomponentview_$id');
  }

  Future<void> enableScanning(bool isEnable) async {
    return await _channel.invokeMethod('enableScanning', isEnable);
  }

  Future<void> setFreezeMode(bool isEnable) async {
    return await _channel.invokeMethod('setFreezeMode', isEnable);
  }
}
