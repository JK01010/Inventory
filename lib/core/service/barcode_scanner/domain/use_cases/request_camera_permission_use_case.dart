import 'package:fpdart/fpdart.dart';

import '../../data/repositories/barcode_repository.dart';
import '../failure/barcode_failure.dart';

class RequestCameraPermissionUseCase {
  RequestCameraPermissionUseCase(this.repository);
  final BarcodeRepository repository;

  Future<Either<BarcodeFailure, bool>> call() async {
    return repository.requestCameraPermission();
  }
}
