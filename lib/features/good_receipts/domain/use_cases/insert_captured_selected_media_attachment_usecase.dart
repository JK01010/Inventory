import 'package:fpdart/fpdart.dart';

import '../entities/goods_receipt_attachment_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class InsertCapturedSelectedMediaAttachmentUseCase {
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptAttachmentEntity>>> call(List<GoodsReceiptAttachmentEntity> goodsReceiptAttachmentEntityList);
}

class InsertCapturedSelectedMediaAttachmentUseCaseImpl implements InsertCapturedSelectedMediaAttachmentUseCase {
  InsertCapturedSelectedMediaAttachmentUseCaseImpl({required this.goodsReceiptsRepository});

  final GoodsReceiptsRepository goodsReceiptsRepository;
  @override
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptAttachmentEntity>>> call(List<GoodsReceiptAttachmentEntity> goodsReceiptAttachmentEntityList) {
    return goodsReceiptsRepository.insertCapturedOrSelectedMediaAttachments(goodsReceiptAttachmentEntityList);
  }
}
