import 'package:fpdart/fpdart.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../data/repositories/barcode_repository.dart';
import '../failure/barcode_failure.dart';

class InitializeBarcodeScannerUseCase {

  InitializeBarcodeScannerUseCase(this.repository);
  final BarcodeRepository repository;
  Future<Either<BarcodeFailure, MobileScannerController>> call() async {
    return  repository.createAndInitializeScannerController();
  }
}
