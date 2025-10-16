import 'package:fpdart/fpdart.dart';
import '../failures/bagging_and_tagging_failures.dart';
import '../repository/bagging_tagging_repository.dart';

/// Unified Use Case for fetching and saving bagging and tagging confirmation
abstract interface class FetchConfirmationListUseCase {
  Future<Either<BaggingAndTaggingFailures, List<Map<String, dynamic>>>> byItemIds({
  required List<int> itemIds,required int storageLocationId,required int grnId
  });

  Future<Either<BaggingAndTaggingFailures, List<Map<String, dynamic>>>> byGRNId({
    required String grnId,
  });

  Future<Either<BaggingAndTaggingFailures, Unit>> saveConfirmation({
    required int grnId,
    required List<int> itemIds,
  });
}

class FetchConfirmationListUseCaseImpl implements FetchConfirmationListUseCase {
  FetchConfirmationListUseCaseImpl({
    required this.baggingTaggingRepository,
  });

  final BaggingTaggingRepository baggingTaggingRepository;

  @override
  Future<Either<BaggingAndTaggingFailures, List<Map<String, dynamic>>>> byItemIds(
  {required List<int> itemIds,required int storageLocationId,required int grnId}) {
    return baggingTaggingRepository.fetchConfirmationListByItemIds(
      itemIds: itemIds,
      grnId: grnId,
      storageLocationId: storageLocationId
    );
  }

  @override
  Future<Either<BaggingAndTaggingFailures, List<Map<String, dynamic>>>> byGRNId({
    required String grnId,
  }) {
    return baggingTaggingRepository.fetchConfirmationListByGRNId(
      grnId: grnId,
    );
  }

  @override
  Future<Either<BaggingAndTaggingFailures, Unit>> saveConfirmation({required int grnId,required List<int> itemIds}) {
    return baggingTaggingRepository.saveConfirmation(
      grnId: grnId,
      itemIds: itemIds
    );
  }
}
