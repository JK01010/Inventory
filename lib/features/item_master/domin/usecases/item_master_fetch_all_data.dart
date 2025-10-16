import 'package:fpdart/fpdart.dart';

import '../entities/item_master_common_entity_model.dart';
import '../failures/item_master_failures.dart';
import '../repository/item_master_repository.dart';

abstract interface class FetchAllDataItemMasterUseCase{
  Future<Either<ItemMasterFailures, List<ItemMasterEntity>>> call({required int offSet});
}

class FetchAllDataItemMasterUseCaseImpl implements FetchAllDataItemMasterUseCase{
  const FetchAllDataItemMasterUseCaseImpl({required this.itemMasterRepository});
  final ItemMasterRepository itemMasterRepository;

  @override
  Future<Either<ItemMasterFailures,  List<ItemMasterEntity>>> call({required int offSet}) {
    return itemMasterRepository.fetchAllItemMasterList(offSet: offSet);
  }

}