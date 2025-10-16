import 'package:fpdart/fpdart.dart';

import '../failure/rfid_failure.dart';
import '../rfid_repository.dart';

abstract interface class RequestBluetoothPermissionUseCase {
  Future<Either<RfidFailure, Unit>> call();
}

class RequestBluetoothPermissionUseCaseImpl
    implements RequestBluetoothPermissionUseCase {
  RequestBluetoothPermissionUseCaseImpl({required this.rfidRepository});

  final RfidRepository rfidRepository;
  @override
  Future<Either<RfidFailure, Unit>> call() async {
    return rfidRepository.requestBluetoothPermission();
  }
}
