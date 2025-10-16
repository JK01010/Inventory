import 'dart:convert';

import '../../domain/entities/goods_receipt_label_attachment_entity.dart';

class GoodsReceiptLabelAttachmentModel
    extends GoodsReceiptLabelAttachmentEntity {
  const GoodsReceiptLabelAttachmentModel({
    required super.dtId,
    required super.fileName,
    required super.itemId,
    required super.poId,
    required super.url,
    required super.fileType,
    required super.fileSize,
    required super.date,
    required super.localUrl,
    required super.transactionDtId,
    required super.isSync,
  });

  @override
  bool? get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dtId': dtId,
      'fileName': fileName,
      'itemId': itemId,
      'poId': poId,
      'url': url,
      'fileType': fileType,
      'fileSize': fileSize,
      'date': date,
      'localUrl': localUrl,
      'transactionDtId': transactionDtId,
      'syncStatus': isSync,
    };
  }

  factory GoodsReceiptLabelAttachmentModel.fromMap(Map<String, dynamic> map) {
    return GoodsReceiptLabelAttachmentModel(
      dtId: map['dtId'],
      fileName: map['fileName'],
      itemId: map['itemId'],
      poId: map['poId'],
      url: map['url'],
      fileType: map['fileType'],
      fileSize: map['fileSize'],
      date: map['date'],
      localUrl: map['localUrl'],
      transactionDtId: map['transactionDtId'],
      isSync: map['isSync'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GoodsReceiptLabelAttachmentModel.fromJson(String source) =>
      GoodsReceiptLabelAttachmentModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  GoodsReceiptLabelAttachmentEntity toEntity() {
    return GoodsReceiptLabelAttachmentEntity(
      dtId: dtId,
      fileName: fileName,
      itemId: itemId,
      poId: poId,
      url: url,
      fileType: fileType,
      fileSize: fileSize,
      date: date,
      localUrl: localUrl,
      transactionDtId: transactionDtId,
      isSync: isSync,
    );
  }

  factory GoodsReceiptLabelAttachmentModel.fromEntity(
    GoodsReceiptLabelAttachmentEntity goodsReceiptLabelAttachmentEntity,
  ) {
    return GoodsReceiptLabelAttachmentModel(
      dtId: goodsReceiptLabelAttachmentEntity.dtId,
      fileName: goodsReceiptLabelAttachmentEntity.fileName,
      itemId: goodsReceiptLabelAttachmentEntity.itemId,
      poId: goodsReceiptLabelAttachmentEntity.poId,
      url: goodsReceiptLabelAttachmentEntity.url,
      fileType: goodsReceiptLabelAttachmentEntity.fileType,
      fileSize: goodsReceiptLabelAttachmentEntity.fileSize,
      date: goodsReceiptLabelAttachmentEntity.date,
      localUrl: goodsReceiptLabelAttachmentEntity.localUrl,
      transactionDtId: goodsReceiptLabelAttachmentEntity.transactionDtId,
      isSync: goodsReceiptLabelAttachmentEntity.isSync,
    );
  }

  static List<GoodsReceiptLabelAttachmentModel> fromEntityList(
    List<GoodsReceiptLabelAttachmentEntity> goodsReceiptAttachmentEntityList,
  ) {
    List<GoodsReceiptLabelAttachmentModel> attachmentModelList = [];
    for (var entity in goodsReceiptAttachmentEntityList) {
      attachmentModelList.add(
        GoodsReceiptLabelAttachmentModel.fromEntity(entity),
      );
    }
    return attachmentModelList;
  }
}
