import 'package:kdcreader_platform_interface/kdcreader_platform_interface.dart';

/// Control software decoder component view
class SWComponentViewController {
  late SWComponentViewControllerInterface _viewControllerInterface;

  SWComponentViewController(int id) {
    _viewControllerInterface = SWComponentViewControllerInterface(id);
  }

  /// Enable barcode scanning.
  ///
  /// [isEnable] true if enabled, otherwise false
  Future<void> enableScanning(bool isEnable) {
    return _viewControllerInterface.enableScanning(isEnable);
  }

  /// Allows setting freeze mode on the decode component.
  ///
  /// [isEnable] true if enabled, otherwise false
  Future<void> setFreezeMode(bool isEnable) async {
    return _viewControllerInterface.setFreezeMode(isEnable);
  }
}
