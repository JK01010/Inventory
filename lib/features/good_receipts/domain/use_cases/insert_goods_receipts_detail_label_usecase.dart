import 'package:fpdart/fpdart.dart';

import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class InsertGoodsReceiptsDetailLabelUseCase {
  Future<Either<GoodsReceiptsFailures, Unit>> call();
}

class InsertGoodsReceiptsLabelDetailUseCaseImpl implements InsertGoodsReceiptsDetailLabelUseCase {
  InsertGoodsReceiptsLabelDetailUseCaseImpl({required this.goodsReceiptsRepository});

  final GoodsReceiptsRepository goodsReceiptsRepository;
  @override
  Future<Either<GoodsReceiptsFailures, Unit>> call() {
    return goodsReceiptsRepository.insertGoodsReceiptsDetailLabel();
  }
}