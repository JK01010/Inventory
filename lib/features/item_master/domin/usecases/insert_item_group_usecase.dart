import 'package:fpdart/fpdart.dart';

import '../failures/item_master_failures.dart';
import '../repository/item_master_repository.dart';

abstract interface class ItemGroupInsertUseCase{
  Future<Either<ItemMasterFailures, Unit>> call();
}

class ItemGroupInsertUseCaseImpl implements ItemGroupInsertUseCase{
  const ItemGroupInsertUseCaseImpl({required this.itemMasterRepository});
  final ItemMasterRepository itemMasterRepository;

  @override
  Future<Either<ItemMasterFailures, Unit>> call() {
    return itemMasterRepository.insertItemGroupNumberList();
  }

}