import 'package:fpdart/fpdart.dart';

import '../../entities/item_category_config_entity.dart';
import '../../failures/goods_receipts_failures.dart';
import '../../repository/goods_receipts_repository.dart';

abstract class GetItemCategoryConfigUseCase {
  Future<Either<GoodsReceiptsFailures, List<ItemCategoryConfigEntity>>> getItemCategoryConfig() ;
 }


class GetItemCategoryConfigUseCaseImpl implements GetItemCategoryConfigUseCase {

  GetItemCategoryConfigUseCaseImpl({required this.repository});
  final GoodsReceiptsRepository repository;


  @override
  Future<Either<GoodsReceiptsFailures, List<ItemCategoryConfigEntity>>> getItemCategoryConfig() {
    return repository.getItemCategoryConfig();

  }
}
