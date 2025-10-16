import 'package:fpdart/fpdart.dart';

import '../entities/goods_receipt_attachment_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class GetGoodsReceiptAttachmentsUseCase {
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptAttachmentEntity>>> getGoodsReceiptAttachmentList(int poId);
}

class GetGoodsReceiptAttachmentsUseCaseImpl implements GetGoodsReceiptAttachmentsUseCase {
  GetGoodsReceiptAttachmentsUseCaseImpl({required this.goodsReceiptsRepository});

  final GoodsReceiptsRepository goodsReceiptsRepository;
  @override
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptAttachmentEntity>>> getGoodsReceiptAttachmentList(int poId) {
    return goodsReceiptsRepository.getGoodsReceiptAttachmentList(poId);
  }
}
