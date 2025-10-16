import 'package:fpdart/fpdart.dart';
import 'package:zebraRfid/zebraRfid.dart';

import '../failure/rfid_failure.dart';
import '../rfid_repository.dart';

abstract interface class RfidConnectionStatusUseCase {
  Either<RfidFailure, Status> call();
}

class RfidConnectionStatusUseCaseImpl implements RfidConnectionStatusUseCase {
  RfidConnectionStatusUseCaseImpl({required this.rfidRepository});

  final RfidRepository rfidRepository;
  @override
  Either<RfidFailure, Status> call() {
    return rfidRepository.connectionStatus();
  }
}
