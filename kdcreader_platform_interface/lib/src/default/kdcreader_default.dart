import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:kdcreader_platform_interface/src/kdc_constants.dart';
import 'package:kdcreader_platform_interface/src/kpos_constants.dart';
import 'package:kdcreader_platform_interface/src/ksw_constants.dart'; // software decoder

import 'package:kdcreader_platform_interface/src/kdcreader_platform_interface.dart';

/// An implementation of [KdcreaderPlatformInterface] that is used as default.
/// Unsupported - dummy
class KdcreaderDefault extends KdcreaderPlatformInterface
    with EventChannelKdcreaderDefault {
  final _channel = const MethodChannel('plugins.flutter.koamtac/kdcreader');
}

mixin EventChannelKdcreaderDefault
    implements EventChannelKdcreaderPlatformInterface {
  final EventChannel _connectionStateEventChannel =
      EventChannel('plugins.flutter.koamtac/connection');

  final EventChannel _barcodeDataEventChannel =
      EventChannel('plugins.flutter.koamtac/barcode');
  final EventChannel _nfcDataEventChannel =
      EventChannel('plugins.flutter.koamtac/nfc');
  final EventChannel _msrDataEventChannel =
      EventChannel('plugins.flutter.koamtac/msr');
  final EventChannel _generalDataEventChannel =
      EventChannel('plugins.flutter.koamtac/general');

  final EventChannel _posDataEventChannel =
      EventChannel('plugins.flutter.koamtac/pos');

  final EventChannel _errorEventChannel =
      EventChannel('plugins.flutter.koamtac/error');

  final EventChannel _deviceScannedEventChannel =
      EventChannel('plugins.flutter.koamtac/device_scanned');
  final EventChannel _deviceScanFailedEventChannel =
      EventChannel('plugins.flutter.koamtac/device_scan_failed');

  final EventChannel _usbAttachedEventChannel =
      EventChannel('plugins.flutter.koamtac/usb_attached');
  final EventChannel _usbDetachedEventChannel =
      EventChannel('plugins.flutter.koamtac/usb_detached');

  final EventChannel _infoUpdatedEventChannel =
      EventChannel('plugins.flutter.koamtac/info_updated');

  final EventChannel _swBarcodeDataEventChannel =
      EventChannel('plugins.flutter.koamtac/sw_barcode');

  @override
  Stream<ConnectionEvent> getConnectionStateStream() {
    throw UnimplementedError(
        'getConnectionStateStream has not been implemented.');
  }

  @override
  Stream<KDCData> getBarcodeDataStream() {
    throw UnimplementedError('getBarcodeDataStream has not been implemented.');
  }

  @override
  Stream<KDCData> getNfcDataStream() {
    throw UnimplementedError('getNfcDataStream has not been implemented.');
  }

  @override
  Stream<KDCData> getMsrDataStream() {
    throw UnimplementedError('getMsrDataStream has not been implemented.');
  }

  @override
  Stream<KDCData> getGeneralDataStream() {
    throw UnimplementedError('getGeneralDataStream has not been implemented.');
  }

  @override
  Stream<KPOSData> getPosDataStream() {
    throw UnimplementedError('getPosDataStream has not been implemented.');
  }

  @override
  Stream<ErrorEvent> getErrorStream() {
    throw UnimplementedError('getErrorStream has not been implemented.');
  }

  @override
  Stream<KDCDevice> getDeviceScannedStream() {
    throw UnimplementedError(
        'getDeviceScannedStream has not been implemented.');
  }

  @override
  Stream<ScanFailEvent> getDeviceScanFailedrStream() {
    throw UnimplementedError(
        'getDeviceScanFailedrStream has not been implemented.');
  }

  @override
  Stream<KDCDevice> getUsbAttachedStream() {
    throw UnimplementedError('getUsbAttachedStream has not been implemented.');
  }

  @override
  Stream<KDCDevice> getUsbDetachedStream() {
    throw UnimplementedError('getUsbDetachedStream has not been implemented.');
  }

  @override
  Stream<InfoEvent> getInfoUpdatedStream() {
    throw UnimplementedError('getInfoUpdatedStream has not been implemented.');
  }

  @override
  Stream<List<KDCData>> getSwBarcodeDataStream() {
    throw UnimplementedError('getSwBarcodeDataStream has not been implemented.');
  }
}
