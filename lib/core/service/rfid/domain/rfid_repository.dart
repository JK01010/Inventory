import 'package:fpdart/fpdart.dart';
import 'package:zebraRfid/enums.dart';

import 'failure/rfid_failure.dart';

abstract interface class RfidRepository {
  Either<RfidFailure, Unit> initializeRfId({required dynamic callback});
  Either<RfidFailure, Unit> connect();
  Either<RfidFailure, Unit> setPowerLevel({required int powerLevel});
  Either<RfidFailure, Status> connectionStatus();
  Either<RfidFailure, Unit> startScan();
  Either<RfidFailure, Unit> stopScan();
  Either<RfidFailure, Unit> disconnectScanner();
  Future<Either<RfidFailure, Unit>> requestBluetoothPermission();
}
