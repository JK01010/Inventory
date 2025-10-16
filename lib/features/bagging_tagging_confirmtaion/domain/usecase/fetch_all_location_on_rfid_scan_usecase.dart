import 'package:fpdart/fpdart.dart';

import '../failures/bagging_and_tagging_failures.dart';
import '../repository/bagging_tagging_repository.dart';

abstract interface class FetchAllLocationOnRfidScanUseCase {
  Future<Either<BaggingAndTaggingFailures,  List<Map<String, dynamic>>>>  call({
    required List<String> rfid,
    required int itemId,
    required int grnId,
  });
}

class FetchAllLocationOnRfidScanUseCaseImpl implements FetchAllLocationOnRfidScanUseCase {
  FetchAllLocationOnRfidScanUseCaseImpl({required this.baggingTaggingRepository});

  final BaggingTaggingRepository baggingTaggingRepository;
  @override
  Future<Either<BaggingAndTaggingFailures,  List<Map<String, dynamic>>>> call({
    required List<String> rfid,
    required int itemId,
    required int grnId,
  }) {
    return baggingTaggingRepository.fetchAllLocationBasedOnScannedRfidItems(
      rfid: rfid,
      itemId: itemId,
      grnId: grnId,
    );
  }
}