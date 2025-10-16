import 'package:fpdart/fpdart.dart';

import '../failure/rfid_failure.dart';
import '../rfid_repository.dart';

abstract interface class InitializeRfidUseCase {
  Either<RfidFailure, Unit> call({required dynamic callback});
}

class InitializeRfidUseCaseImpl implements InitializeRfidUseCase {
  InitializeRfidUseCaseImpl({required this.rfidRepository});

  final RfidRepository rfidRepository;
  @override
  Either<RfidFailure, Unit> call({required dynamic callback}) {
    return rfidRepository.initializeRfId(callback: callback);
  }
}
