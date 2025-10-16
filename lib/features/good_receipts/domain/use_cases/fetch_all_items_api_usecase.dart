import 'package:fpdart/fpdart.dart';

import '../../../common_feature/domain/failures/common_failures.dart';
import '../../../common_feature/domain/repositories/common_repository.dart';
import '../entities/goods_receipt_purchase_item_detail_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class GetAllItemsApiUseCase {
  Future<Either<CommonFailures, Unit>> call();
}

class GetAllItemsApiUseCaseImpl implements GetAllItemsApiUseCase {
  GetAllItemsApiUseCaseImpl({required this.commonRepository});

  final CommonRepository commonRepository;

  @override
  Future<Either<CommonFailures, Unit>> call() {
    return commonRepository.getAllItemsFromApi();
  }
}
