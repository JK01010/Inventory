import 'goods_receipt_common_attachment.dart';

class GoodsReceiptIhmAttachmentEntity extends GoodsReceiptCommonAttachment{

  const GoodsReceiptIhmAttachmentEntity({
    required this.itemId,
    required this.attachmentName,
    required this.poId,
    required this.url,
    required this.fileType,
    required this.localUrl,
    required this.createdDate,
    required this.fileSize,
    required this.transactionDtId,
    required this.isSync
  }):super(
    id: itemId,
    name: attachmentName,
    url: url,
    type: fileType,
  );

  final String itemId;
  final String attachmentName;
  final String poId;
  final String url;
  final String fileType;
  final String localUrl;
  final String createdDate;
  final String fileSize;
  final String transactionDtId;
  final String isSync;

  @override
  List<Object?> get props => super.props + [itemId, poId, localUrl, transactionDtId, isSync];
}