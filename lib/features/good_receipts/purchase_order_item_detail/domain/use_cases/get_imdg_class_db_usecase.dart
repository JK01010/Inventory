import 'package:fpdart/fpdart.dart';
import '../../../../common_feature/domain/entities/fetch_imdg_class_entity.dart';
import '../failures/purchase_order_item_details_failures.dart';
import '../repository/purchase_order_item_detail_repository.dart';

abstract interface class GetImdgClassListDbUseCase {
  Future<Either<PurchaseOrderItemDetailsFailures, List<ImdgClassEntity>>>
  call();
}

class GetImdgClassListDbUseCaseImpl implements GetImdgClassListDbUseCase {
  GetImdgClassListDbUseCaseImpl({required this.purchaseOrderItemDetailRepository});

  final PurchaseOrderItemDetailRepository purchaseOrderItemDetailRepository;

  @override
  Future<Either<PurchaseOrderItemDetailsFailures, List<ImdgClassEntity>>>
  call() async {
    return purchaseOrderItemDetailRepository.getImdgClassListDb();
  }
}
