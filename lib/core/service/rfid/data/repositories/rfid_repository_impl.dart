import 'package:fpdart/fpdart.dart';
import 'package:zebraRfid/enums.dart';

import '../../domain/failure/rfid_failure.dart';
import '../../domain/rfid_repository.dart';
import '../data_sources/local_data_source.dart';

class RfidRepositoryImpl implements RfidRepository {
  RfidRepositoryImpl({required this.rfIdLocalDataSource});

  final RfIdLocalDataSource rfIdLocalDataSource;
  @override
  Either<RfidFailure, Status> connectionStatus() {
    try {
      return right(rfIdLocalDataSource.connectionStatus());
    } catch (e) {
      return left(RfidFailurePlatformFailure());
    }
  }

  @override
  Either<RfidFailure, Unit> disconnectScanner() {
    try {
      rfIdLocalDataSource.disconnectScanner();

      return right(unit);
    } catch (e) {
      return left(RfidFailurePlatformFailure());
    }
  }

  @override
  Either<RfidFailure, Unit> initializeRfId({required dynamic callback}) {
    try {
      rfIdLocalDataSource.initializeRfId(callback: callback);
      return right(unit);
    } catch (e) {
      return left(RfidFailurePlatformFailure());
    }
  }

  @override
  Either<RfidFailure, Unit> setPowerLevel({required int powerLevel}) {
    try {
      rfIdLocalDataSource.setPowerLevel(powerLevel: powerLevel);
      return right(unit);
    } catch (e) {
      return left(RfidFailurePlatformFailure());
    }
  }

  @override
  Either<RfidFailure, Unit> startScan() {
    try {
      rfIdLocalDataSource.startScan();
      return right(unit);
    } catch (e) {
      return left(RfidFailurePlatformFailure());
    }
  }

  @override
  Either<RfidFailure, Unit> stopScan() {
    try {
      rfIdLocalDataSource.stopScanner();
      return right(unit);
    } catch (e) {
      return left(RfidFailurePlatformFailure());
    }
  }

  @override
  Future<Either<RfidFailure, Unit>> requestBluetoothPermission() async {
    try {
      rfIdLocalDataSource.bluetoothPermission();
      return right(unit);
    } catch (e) {
      return left(BluetoothPermissionFailure());
    }
  }

  @override
  Either<RfidFailure, Unit> connect() {
    try {
      rfIdLocalDataSource.connect();
      return right(unit);
    } catch (e) {
      return left(RfidFailurePlatformFailure());
    }
  }
}
