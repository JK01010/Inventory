import 'package:fpdart/fpdart.dart';

import '../entities/item_master_common_entity_model.dart';
import '../failures/common_failures.dart';
import '../repositories/common_repository.dart';

abstract interface class FetchItemMasterUsingItemIdCommonUseCase {
  Future<Either<CommonFailures, List<ItemMasterEntity>>> call({
    required int id,
  });
}

class FetchItemMasterUsingItemIdCommonUseCaseImpl
    implements FetchItemMasterUsingItemIdCommonUseCase {
  FetchItemMasterUsingItemIdCommonUseCaseImpl({required this.commonRepository});
  final CommonRepository commonRepository;

  @override
  Future<Either<CommonFailures, List<ItemMasterEntity>>> call({
    required int id,
  }) {
    return commonRepository.fetchItemsByItemId(id: id);
  }
}
