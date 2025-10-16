import 'package:fpdart/fpdart.dart';

import '../failure/rfid_failure.dart';
import '../rfid_repository.dart';

abstract interface class RfidStopScanUseCase {
  Either<RfidFailure, Unit> call();
}

class RfidStopScanUseCaseImpl implements RfidStopScanUseCase {
  RfidStopScanUseCaseImpl({required this.rfidRepository});

  final RfidRepository rfidRepository;
  @override
  Either<RfidFailure, Unit> call() {
    return rfidRepository.stopScan();
  }
}
