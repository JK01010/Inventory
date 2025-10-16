import 'package:fpdart/fpdart.dart';

import '../failure/rfid_failure.dart';
import '../rfid_repository.dart';

abstract interface class RfidDisconnectUseCase {
  Either<RfidFailure, Unit> call();
}

class RfidDisconnectUseCaseImpl implements RfidDisconnectUseCase {
  RfidDisconnectUseCaseImpl({required this.rfidRepository});

  final RfidRepository rfidRepository;
  @override
  Either<RfidFailure, Unit> call() {
    return rfidRepository.disconnectScanner();
  }
}
