import 'package:fpdart/fpdart.dart';

import '../../../data/models/item_rob_details_model.dart';
import '../../entities/item_rob_details_entity.dart';
import '../../failures/goods_receipts_failures.dart';
import '../../repository/goods_receipts_repository.dart';

abstract class ItemRobDetailsUseCase {
  Future<Either<GoodsReceiptsFailures, List<ItemRobDetailsEntity>>> call(
      {required int itemID,});
}

class ItemRobDetailsUseCaseImpl implements ItemRobDetailsUseCase {
  ItemRobDetailsUseCaseImpl({required this.goodsReceiptsRepository});

  final GoodsReceiptsRepository goodsReceiptsRepository;

  @override
  Future<Either<GoodsReceiptsFailures, List<ItemRobDetailsEntity>>> call(
      {required int itemID,}) {
    return goodsReceiptsRepository.getItemRobDetails(itemID: itemID,
     );
  }
}