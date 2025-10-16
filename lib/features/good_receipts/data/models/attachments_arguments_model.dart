import '../../domain/entities/goods_receipt_attachment_entity.dart';

class AttachmentsArguments {
  final List<GoodsReceiptAttachmentEntity> attachmentList;
  final int initialIndex;

  AttachmentsArguments({
    required this.attachmentList,
    required this.initialIndex,
  });
}