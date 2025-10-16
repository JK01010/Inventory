import 'package:fpdart/fpdart.dart';

import '../failure/rfid_failure.dart';
import '../rfid_repository.dart';

abstract interface class RfidConnectUseCase {
  Either<RfidFailure, Unit> call();
}

class RfidConnectUseCaseImpl implements RfidConnectUseCase {
  RfidConnectUseCaseImpl({required this.rfidRepository});

  final RfidRepository rfidRepository;
  @override
  Either<RfidFailure, Unit> call() {
    return rfidRepository.connect();
  }
}
