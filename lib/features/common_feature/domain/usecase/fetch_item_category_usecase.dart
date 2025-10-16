import 'package:fpdart/fpdart.dart';

import '../entities/item_category_entity.dart';
import '../failures/common_failures.dart';
import '../repositories/common_repository.dart';

abstract interface class GetItemCategoryUsecase {
  Future<Either<CommonFailures, List<ItemCategoryEntity>>> call();
}

class GetItemCategoryUsecaseImpl implements GetItemCategoryUsecase {
  GetItemCategoryUsecaseImpl({required this.commonRepository});

  final CommonRepository commonRepository;
  @override
  Future<Either<CommonFailures, List<ItemCategoryEntity>>> call() {
    return commonRepository.fetchAllItemCategory();
  }
}
