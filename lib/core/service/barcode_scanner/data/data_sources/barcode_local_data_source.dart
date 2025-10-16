import 'dart:async';

import 'package:barcode/barcode.dart' as bc;
import 'package:flutter/cupertino.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/entities/barcode_entity.dart';
import '../../domain/failure/barcode_failure.dart';

abstract class BarcodeLocalDataSource {
  Future<bool> requestCameraPermission();

  /// Creates and returns a new [MobileScannerController] instance.
  /// Sets up barcode listening on this controller.
  /// Throws [CameraInitializationFailure] if controller creation fails.
  MobileScannerController createAndInitializeScannerController();

  /// Provides a stream of scanned barcodes.
  Stream<BarcodeEntity> getScannedBarcodes();

  /// Disposes of internal resources managed by the data source itself (e.g., stream controllers).
  void dispose();
}

/// Concrete implementation of [BarcodeLocalDataSource] using [MobileScanner].
class BarcodeLocalDataSourceImpl implements BarcodeLocalDataSource {
  // This StreamController is managed by the data source, independent of the MobileScannerController
  final StreamController<BarcodeEntity> _barcodeStreamController =
      StreamController<BarcodeEntity>.broadcast();

  @override
  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  @override
  MobileScannerController createAndInitializeScannerController() {
    final newController = MobileScannerController(
      formats: [BarcodeFormat.all],
      returnImage: true,
      autoZoom: true,
    );

    // Listen to barcodes stream from this new controller
    newController.barcodes.listen((barcodeCapture) {
      for (final barcode in barcodeCapture.barcodes) {
        debugPrint("barcode.format : ${barcode.format}");
        final a = generateBarcodeType(barcode.format);
        var newBarCode = bc.Barcode.fromType(a);
        final svg = newBarCode.toSvg(
          barcode.rawValue ?? '',
          width: 300,
          height: 100,
        );
        _barcodeStreamController.add(
          BarcodeEntity(
            rawValue: barcode.rawValue,
            type: barcode.type.name,
            image: svg,
          ),
        );
      }
    });
    return newController; // Return the newly created controller
  }

  @override
  Stream<BarcodeEntity> getScannedBarcodes() {
    return _barcodeStreamController.stream;
  }

  @override
  void dispose() {
    // Only dispose the internal stream controller here.
    // The MobileScannerController will be disposed by the BLoC.
    _barcodeStreamController.close();
    debugPrint(
      'BarcodeLocalDataSourceImpl disposed (stream controller closed).',
    );
  }

  bc.BarcodeType generateBarcodeType(BarcodeFormat barcodeFormat) {
    switch (barcodeFormat) {
      case BarcodeFormat.unknown:
        return bc.BarcodeType.Code39;
      case BarcodeFormat.all:
        return bc.BarcodeType.Code39;
      case BarcodeFormat.code128:
        return bc.BarcodeType.Code128;
      case BarcodeFormat.code39:
        return bc.BarcodeType.Code39;
      case BarcodeFormat.code93:
        return bc.BarcodeType.Code93;
      case BarcodeFormat.codabar:
        return bc.BarcodeType.Codabar;
      case BarcodeFormat.dataMatrix:
        return bc.BarcodeType.DataMatrix;
      case BarcodeFormat.ean13:
        return bc.BarcodeType.CodeEAN13;
      case BarcodeFormat.ean8:
        return bc.BarcodeType.CodeEAN8;
      case BarcodeFormat.itf:
        return bc.BarcodeType.Code39;
      case BarcodeFormat.qrCode:
        return bc.BarcodeType.QrCode;
      case BarcodeFormat.upcA:
        return bc.BarcodeType.CodeUPCA;
      case BarcodeFormat.upcE:
        return bc.BarcodeType.CodeUPCE;
      case BarcodeFormat.pdf417:
        return bc.BarcodeType.PDF417;
      case BarcodeFormat.aztec:
        return bc.BarcodeType.Aztec;
    }
  }
}
