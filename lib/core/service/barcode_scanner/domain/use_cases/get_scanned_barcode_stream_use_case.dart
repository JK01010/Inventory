
import '../../data/repositories/barcode_repository.dart';
import '../entities/barcode_entity.dart';

class GetScannedBarcodeStreamUseCase {

  GetScannedBarcodeStreamUseCase(this.repository);
  final BarcodeRepository repository;

  Stream<BarcodeEntity> call() {
    return repository.getScannedBarcodes();
  }
}