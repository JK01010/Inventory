import 'package:fpdart/fpdart.dart';

import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class InsertGoodsReceiptsAttachmentUseCase {
  Future<Either<GoodsReceiptsFailures, Unit>> call();
}

class InsertGoodsReceiptsAttachmentUseCaseImpl implements InsertGoodsReceiptsAttachmentUseCase {
  InsertGoodsReceiptsAttachmentUseCaseImpl({required this.goodsReceiptsRepository});

  final GoodsReceiptsRepository goodsReceiptsRepository;
  @override
  Future<Either<GoodsReceiptsFailures, Unit>> call() {
    return goodsReceiptsRepository.insertGoodsReceiptsAttachments();
  }
}
