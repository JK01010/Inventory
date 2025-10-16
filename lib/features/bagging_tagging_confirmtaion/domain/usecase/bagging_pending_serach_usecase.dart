import 'package:fpdart/fpdart.dart';
import '../entities/pending_list_model.dart';
import '../failures/bagging_and_tagging_failures.dart';
import '../repository/bagging_tagging_repository.dart';

abstract interface class BaggingPendingSearchUsecase {
  Future<Either<BaggingAndTaggingFailures, List<BaggingTaggingPendingEntity>>> call({
    required String query,
  });
}

class BaggingPendingSerachUsecaseImpl implements BaggingPendingSearchUsecase {
  BaggingPendingSerachUsecaseImpl({required this.baggingTaggingRepository});

  final BaggingTaggingRepository baggingTaggingRepository;
  @override
  Future<Either<BaggingAndTaggingFailures, List<BaggingTaggingPendingEntity>>> call({
    required String query,
  }) {
    return baggingTaggingRepository.searchFromBaggingPendingList(query: query);
  }
}
