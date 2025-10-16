import 'package:fpdart/fpdart.dart';

import '../../data/repositories/barcode_repository.dart';
import '../failure/barcode_failure.dart';
class StopScanUseCase {

  StopScanUseCase(this.repository);
  final BarcodeRepository repository;

  Future<Either<BarcodeFailure, bool>> call() async {
    return const Right(true);
  }
}
/*class StopScanUseCase {
  StopScanUseCase(this.repository);
  final BarcodeRepository repository;

  Future<Either<BarcodeFailure, bool>> call() async {
    return repository.stopScan();
  }
}*/
