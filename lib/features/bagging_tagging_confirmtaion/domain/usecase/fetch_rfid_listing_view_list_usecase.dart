import 'package:fpdart/fpdart.dart';
import '../failures/bagging_and_tagging_failures.dart';
import '../repository/bagging_tagging_repository.dart';

abstract interface class FetchRfidListingViewListUsecase {
  Future<Either<BaggingAndTaggingFailures, List<String>>> call({required int itemId});
}

class FetchRfidListingViewListUsecaseImpl
    implements FetchRfidListingViewListUsecase {
  FetchRfidListingViewListUsecaseImpl({
    required this.baggingTaggingRepository,
  });

  final BaggingTaggingRepository baggingTaggingRepository;

  @override
  Future<Either<BaggingAndTaggingFailures, List<String>>>call({required int itemId}) {
    return baggingTaggingRepository.fetchRFIDListViewData(itemId: itemId);
  }
}

