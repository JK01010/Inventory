import 'package:fpdart/fpdart.dart';

import '../entities/item_master_common_entity_model.dart';
import '../entities/item_master_filter_entity_model.dart';
import '../failures/item_master_failures.dart';
import '../repository/item_master_repository.dart';

abstract interface class ItemMasterApplyFilterUseCase {
  Future<Either<ItemMasterFailures, List<ItemMasterEntity>>> call(ItemMasterFilterEntity data);
}

class ItemMasterApplyFilterUseCaseImpl extends ItemMasterApplyFilterUseCase{
  
  ItemMasterApplyFilterUseCaseImpl({required this.itemMasterRepository});

  final ItemMasterRepository itemMasterRepository;

  @override
  Future<Either<ItemMasterFailures, List<ItemMasterEntity>>> call(ItemMasterFilterEntity data) {
    return itemMasterRepository.fetchFilterItemMasterList(data);
  }
  
}