import 'package:fpdart/fpdart.dart';
import '../../../../common_feature/domain/entities/quality_entity.dart';
import '../failures/purchase_order_item_details_failures.dart';
import '../repository/purchase_order_item_detail_repository.dart';

abstract interface class GetQualityListDbUseCase {
  Future<Either<PurchaseOrderItemDetailsFailures, List<QualityEntity>>> call();
}

class GetQualityListDbUseCaseImpl implements GetQualityListDbUseCase {
  GetQualityListDbUseCaseImpl({
    required this.purchaseOrderItemDetailRepository,
  });

  final PurchaseOrderItemDetailRepository purchaseOrderItemDetailRepository;

  @override
  Future<Either<PurchaseOrderItemDetailsFailures, List<QualityEntity>>> call() async{
    return purchaseOrderItemDetailRepository.getQualityListDb();
  }
}
