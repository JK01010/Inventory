import 'goods_receipt_common_attachment.dart';

class GoodsReceiptLabelAttachmentEntity extends GoodsReceiptCommonAttachment {
  const GoodsReceiptLabelAttachmentEntity({
    required this.dtId,
    required this.fileName,
    required this.itemId,
    required this.poId,
    required this.url,
    required this.fileType,
    required this.fileSize,
    required this.date,
    required this.localUrl,
    required this.transactionDtId,
    required this.isSync,
  }) : super(id: dtId, name: fileName, url: url, type: fileType);

  final String dtId;
  final String fileName;
  final String itemId;
  final String poId;
  final String url;
  final String fileType;
  final String fileSize;
  final String date;
  final String localUrl;
  final String transactionDtId;
  final String isSync;

  @override
  List<Object?> get props =>
      super.props +
      [itemId, poId, fileSize, date, localUrl, transactionDtId, isSync];
}
