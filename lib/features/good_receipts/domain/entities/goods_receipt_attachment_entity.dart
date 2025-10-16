import 'goods_receipt_common_attachment.dart';

class GoodsReceiptAttachmentEntity extends GoodsReceiptCommonAttachment{

  const GoodsReceiptAttachmentEntity({
    required this.poHDId,
    required this.fileName,
    required this.url,
    required this.fileType,
    required this.fileSize,
    required this.date,
    required this.localUrl,
    required this.isSync,
  }):super(
    id: poHDId,
    name: fileName,
    url: url,
    type: fileType,
  );

  final String poHDId;
  final String fileName;
  final String url;
  final String fileType;
  final String fileSize;
  final String date;
  final String localUrl;
  final String isSync;

  @override
  List<Object?> get props => super.props + [
    fileSize,
    date,
    localUrl,
    isSync,
  ];

  @override
  bool? get stringify => true;
}
