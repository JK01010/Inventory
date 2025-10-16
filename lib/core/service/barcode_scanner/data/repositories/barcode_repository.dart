

import 'package:fpdart/fpdart.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../domain/entities/barcode_entity.dart';
import '../../domain/failure/barcode_failure.dart';
abstract class BarcodeRepository {

  Future<Either<BarcodeFailure, bool>> requestCameraPermission();

  Future<Either<BarcodeFailure, MobileScannerController>> createAndInitializeScannerController();

  Stream<BarcodeEntity> getScannedBarcodes();
}



