import 'package:fpdart/fpdart.dart';

import '../failure/rfid_failure.dart';
import '../rfid_repository.dart';

abstract interface class RfidStartScanUseCase {
  Either<RfidFailure, Unit> call();
}

class RfidStartScanUseCaseImpl implements RfidStartScanUseCase {
  RfidStartScanUseCaseImpl({required this.rfidRepository});

  final RfidRepository rfidRepository;
  @override
  Either<RfidFailure, Unit> call() {
    return rfidRepository.startScan();
  }
}
