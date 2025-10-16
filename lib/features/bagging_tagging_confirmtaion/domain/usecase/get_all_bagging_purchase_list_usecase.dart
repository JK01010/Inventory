import 'package:fpdart/fpdart.dart';

import '../entities/bagging_tagging_purchase_list_view_entity.dart';
import '../failures/bagging_and_tagging_failures.dart';
import '../repository/bagging_tagging_repository.dart';

abstract interface class GetAllBaggingPurchaseListUsecase {
  Future<Either<BaggingAndTaggingFailures, List<BaggingTaggingPurchaseListViewEntity>>> call({required String poHDId});
}

class GetAllBaggingPurchaseListUsecaseImpl
    implements GetAllBaggingPurchaseListUsecase {
  GetAllBaggingPurchaseListUsecaseImpl({required this.commonRepository});

  final BaggingTaggingRepository commonRepository;
  @override
  Future<Either<BaggingAndTaggingFailures,List<BaggingTaggingPurchaseListViewEntity>>> call({required String poHDId}) {
    return commonRepository.getAllBaggingPurchaseList(poHDId: poHDId);
  }
}
