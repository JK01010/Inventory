
import 'package:fpdart/fpdart.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../domain/entities/barcode_entity.dart';
import '../../domain/failure/barcode_failure.dart';
import '../data_sources/barcode_local_data_source.dart';
import 'barcode_repository.dart';
class BarcodeRepositoryImpl implements BarcodeRepository {
  final BarcodeLocalDataSource localDataSource;

  BarcodeRepositoryImpl(this.localDataSource);

  @override
  Future<Either<BarcodeFailure, bool>> requestCameraPermission() async {
    try {
      final granted = await localDataSource.requestCameraPermission();
      if (granted) {
        return const Right(true);
      } else {
        return const Right(false); // Permission denied but not an error
      }
    } on BarcodeFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnexpectedBarcodeFailure('Error requesting permission: $e'));
    }
  }

  @override
  Future<Either<BarcodeFailure, MobileScannerController>> createAndInitializeScannerController() async {
    try {
      final controller = localDataSource.createAndInitializeScannerController();
      return Right(controller);
    } on BarcodeFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CameraInitializationFailure('Failed to initialize scanner: $e'));
    }
  }

  @override
  Stream<BarcodeEntity> getScannedBarcodes() {
    return localDataSource.getScannedBarcodes();
  }
}

/*class BarcodeRepositoryImpl implements BarcodeRepository {

  BarcodeRepositoryImpl(this.localDataSource);
  final BarcodeLocalDataSource localDataSource;

  @override
  Future<Either<BarcodeFailure, bool>> requestCameraPermission() async {
    try {
      final granted = await localDataSource.requestCameraPermission();
      if (granted) {
        return const Right(true);
      } else {
        return const Right(false); // Permission denied but not an error
      }
    } on BarcodeFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnexpectedBarcodeFailure('Error requesting permission: $e'));
    }
  }

  @override
  Future<Either<BarcodeFailure, MobileScannerController>> initializeScanner() async {
    try {
      final controller = await localDataSource.initializeScanner();
      return Right(controller);
    } on BarcodeFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CameraInitializationFailure('Failed to initialize scanner: $e'));
    }
  }

  @override
  Future<Either<BarcodeFailure, bool>> startScan() async {
    try {
      await localDataSource.startScan();
      return const Right(true);
    } on BarcodeFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ScanFailure('Failed to start scan: $e'));
    }
  }

  @override
  Future<Either<BarcodeFailure, bool>> stopScan() async {
    try {
      await localDataSource.stopScan();
      return const Right(true);
    } on BarcodeFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ScanFailure('Failed to stop scan: $e'));
    }
  }

  @override
  Stream<BarcodeEntity> getScannedBarcodes() {
    return localDataSource.getScannedBarcodes();
  }
}*/

