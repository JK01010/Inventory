import 'package:fpdart/fpdart.dart';

import '../entities/goods_receipt_label_attachment_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class InsertCapturedSelectedMediaLabelAttachmentUseCase {
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptLabelAttachmentEntity>>>
  call(List<GoodsReceiptLabelAttachmentEntity> goodsReceiptLabelAttachmentEntityList);
}

class InsertCapturedSelectedMediaLabelAttachmentUseCaseImpl implements InsertCapturedSelectedMediaLabelAttachmentUseCase {
  InsertCapturedSelectedMediaLabelAttachmentUseCaseImpl({required this.goodsReceiptsRepository});

  final GoodsReceiptsRepository goodsReceiptsRepository;
  @override
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptLabelAttachmentEntity>>>
  call(List<GoodsReceiptLabelAttachmentEntity> goodsReceiptLabelAttachmentEntityList) {
    return goodsReceiptsRepository.insertCapturedOrSelectedMediaLabelAttachments(goodsReceiptLabelAttachmentEntityList);
  }
}
