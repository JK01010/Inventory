import 'dart:convert';

import '../../domain/entities/goods_receipt_ihm_attachment_entity.dart';

class GoodsReceiptIhmAttachmentModel extends GoodsReceiptIhmAttachmentEntity {
  const GoodsReceiptIhmAttachmentModel({
    required super.itemId,
    required super.attachmentName,
    required super.poId,
    required super.url,
    required super.fileType,
    required super.localUrl,
    required super.createdDate,
    required super.fileSize,
    required super.transactionDtId,
    required super.isSync});

  @override
  bool? get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemId': itemId,
      'attachmentName': attachmentName,
      'poId': poId,
      'url': url,
      'fileType': fileType,
      'localUrl': localUrl,
      'createdDate': createdDate,
      'fileSize': fileSize,
      'transactionDtId': transactionDtId,
      'isSync': isSync
    };
  }

  factory GoodsReceiptIhmAttachmentModel.fromMap(Map<String, dynamic> map) {
    return GoodsReceiptIhmAttachmentModel(
        itemId: map.containsKey('itemId')? map['itemId']:map['dtId'],
        attachmentName: map.containsKey('attachmentName')? map['attachmentName']:map['fileName'],
        poId: map['poId'],
        url: map['url'],
        fileType: map['fileType'],
        localUrl: map['localUrl'],
        createdDate: map.containsKey('createdDate')? map['createdDate']:map['transactionDtId'],
        fileSize: map.containsKey('fileSize')? map['fileSize']:'102.kb',
        transactionDtId: map['transactionDtId'],
        isSync: map['isSync']
    );
  }

  String toJson() => json.encode(toMap());

  factory GoodsReceiptIhmAttachmentModel.fromJson(String source) =>
      GoodsReceiptIhmAttachmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  GoodsReceiptIhmAttachmentEntity toEntity(){
    return GoodsReceiptIhmAttachmentEntity(
        itemId: itemId,
        attachmentName: attachmentName,
        poId: poId,
        url: url,
        fileType: fileType,
        localUrl: localUrl,
        createdDate: createdDate,
        fileSize: fileSize,
        transactionDtId: transactionDtId,
        isSync: isSync
    );
  }

  factory GoodsReceiptIhmAttachmentModel.fromEntity(GoodsReceiptIhmAttachmentEntity goodsReceiptIhmAttachmentEntity){
    return GoodsReceiptIhmAttachmentModel(
        itemId: goodsReceiptIhmAttachmentEntity.itemId,
        attachmentName: goodsReceiptIhmAttachmentEntity.attachmentName,
        poId: goodsReceiptIhmAttachmentEntity.poId,
        url: goodsReceiptIhmAttachmentEntity.url,
        fileType: goodsReceiptIhmAttachmentEntity.fileType,
        localUrl: goodsReceiptIhmAttachmentEntity.localUrl,
        createdDate: goodsReceiptIhmAttachmentEntity.createdDate,
        fileSize: goodsReceiptIhmAttachmentEntity.fileSize,
        transactionDtId: goodsReceiptIhmAttachmentEntity.transactionDtId,
        isSync: goodsReceiptIhmAttachmentEntity.isSync
    );
  }

  static List<GoodsReceiptIhmAttachmentModel> fromEntityList(List<GoodsReceiptIhmAttachmentEntity> goodsReceiptIhmAttachmentEntityList){
    List<GoodsReceiptIhmAttachmentModel> attachmentModelList = [];
    for (var entity in goodsReceiptIhmAttachmentEntityList) {
      attachmentModelList.add(GoodsReceiptIhmAttachmentModel.fromEntity(entity));
    }
    return attachmentModelList;
  }
}

