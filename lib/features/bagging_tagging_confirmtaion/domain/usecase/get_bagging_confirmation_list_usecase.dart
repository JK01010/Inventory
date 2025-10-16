import 'package:fpdart/fpdart.dart';

import '../entities/bagging_confirmation_list_entity.dart';
import '../failures/bagging_and_tagging_failures.dart';
import '../repository/bagging_tagging_repository.dart';

abstract interface class GetAllBaggingConfirmationListUsecase {
  Future<Either<BaggingAndTaggingFailures, List<BaggingConfirmationListEntity>>> call();
}

class GetAllBaggingConfirmationListUsecaseImpl
    implements GetAllBaggingConfirmationListUsecase {
  GetAllBaggingConfirmationListUsecaseImpl({
    required this.baggingTaggingRepository,
  });

  final BaggingTaggingRepository baggingTaggingRepository;

  @override
  Future<Either<BaggingAndTaggingFailures, List<BaggingConfirmationListEntity>>>
  call() {
    return baggingTaggingRepository.getAllConfirmationList();
  }
}
