import 'package:fpdart/fpdart.dart';

import '../entities/bagging_confirmation_list_entity.dart';
import '../failures/bagging_and_tagging_failures.dart';
import '../repository/bagging_tagging_repository.dart';

abstract interface class FetchAllItemIdOnRfidScanUseCase {
  Future<Either<BaggingAndTaggingFailures, List<int>>> call({
    required List<String> rfid,
  });
}

class FetchAllItemIdOnRfidScanUseCaseImpl implements FetchAllItemIdOnRfidScanUseCase {
  FetchAllItemIdOnRfidScanUseCaseImpl({required this.baggingTaggingRepository});

  final BaggingTaggingRepository baggingTaggingRepository;
  @override
  Future<Either<BaggingAndTaggingFailures, List<int>>> call({
    required List<String> rfid,
  }) {
    return baggingTaggingRepository.fetchItemIdsBasedOnRfid(rfid:rfid);
  }
}
