import 'package:fpdart/fpdart.dart';

import '../entities/goods_receipt_ihm_attachment_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class GetGoodsReceiptIhmAttachmentsUseCase {
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptIhmAttachmentEntity>>> getGoodsReceiptIhmAttachmentList(String itemId);
}

class GetGoodsReceiptIhmAttachmentsUseCaseImpl implements GetGoodsReceiptIhmAttachmentsUseCase {
  GetGoodsReceiptIhmAttachmentsUseCaseImpl({required this.goodsReceiptsRepository});

  final GoodsReceiptsRepository goodsReceiptsRepository;
  @override
  Future<Either<GoodsReceiptsFailures, List<GoodsReceiptIhmAttachmentEntity>>> getGoodsReceiptIhmAttachmentList(String itemId) {
    return goodsReceiptsRepository.getGoodsReceiptIhmAttachmentList(itemId);
  }
}
