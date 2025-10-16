import 'package:fpdart/fpdart.dart';

import '../entities/item_master_common_entity_model.dart';
import '../failures/item_master_failures.dart';
import '../repository/item_master_repository.dart';

abstract interface class FetchSearchDataItemMasterUseCase{
  Future<Either<ItemMasterFailures, List<ItemMasterEntity>>> call({required String searchText});
}

class FetchSearchDataItemMasterUseCaseImpl implements FetchSearchDataItemMasterUseCase{
  const FetchSearchDataItemMasterUseCaseImpl({required this.itemMasterRepository});
  final ItemMasterRepository itemMasterRepository;

  @override
  Future<Either<ItemMasterFailures,  List<ItemMasterEntity>>> call({required String searchText}) {
    return itemMasterRepository.fetchSearchItemMasterList(searchText: searchText);
  }

}