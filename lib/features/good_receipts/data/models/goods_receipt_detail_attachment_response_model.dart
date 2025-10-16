// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../../core/constants/app_enum.dart';
import '../../domain/entities/goods_receipt_attachment_entity.dart';
import '../../domain/entities/purchase_order_hd_entity.dart';

class GoodsReceiptDetailAttachmentResponseModel extends Equatable {
  const GoodsReceiptDetailAttachmentResponseModel({required this.goodsReceiptDetailAttachmentModel});

  final List<GoodsReceiptDetailAttachmentModel> goodsReceiptDetailAttachmentModel;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'attachmentList':
      goodsReceiptDetailAttachmentModel.map((x) => x.toMap()).toList(),
    };
  }

  factory GoodsReceiptDetailAttachmentResponseModel.fromMap(Map<String, dynamic> map) {
    return GoodsReceiptDetailAttachmentResponseModel(
      goodsReceiptDetailAttachmentModel: (map['attachmentList'] as List<dynamic>)
          .map((x) => GoodsReceiptDetailAttachmentModel.fromMap(x)).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory GoodsReceiptDetailAttachmentResponseModel.fromJson(String source) =>
      GoodsReceiptDetailAttachmentResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  List<Object?> get props => [goodsReceiptDetailAttachmentModel];

  @override
  bool? get stringify => true;
}

class GoodsReceiptDetailAttachmentModel extends GoodsReceiptAttachmentEntity {
  const GoodsReceiptDetailAttachmentModel({
    required super.poHDId,
    required super.fileName,
    required super.url,
    required super.fileType,
    required super.fileSize,
    required super.date,
    required super.localUrl,
    required super.isSync});

  @override
  bool? get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'poHDId': poHDId,
      'fileName': fileName,
      'url': url,
      'fileType': fileType,
      'fileSize': fileSize,
      'date': date,
      'localUrl': localUrl,
      'isSync': isSync
    };
  }

  factory GoodsReceiptDetailAttachmentModel.fromMap(Map<String, dynamic> map) {
    return GoodsReceiptDetailAttachmentModel(
        poHDId: map['poHDId'].toString(),
        fileName: map['fileName'],
        url: map['url'],
        fileType: map['fileType'],
        fileSize: map['fileSize'],
        date: map['date'],
        localUrl: map['localUrl'],
        isSync: map['isSync']
    );
  }

  String toJson() => json.encode(toMap());

  factory GoodsReceiptDetailAttachmentModel.fromJson(String source) =>
      GoodsReceiptDetailAttachmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  GoodsReceiptAttachmentEntity toEntity(){
    return GoodsReceiptAttachmentEntity(
        poHDId: poHDId,
        fileName: fileName,
        url: url,
        fileType: fileType,
        fileSize: fileSize,
        date: date,
        localUrl: localUrl,
        isSync: isSync
    );
  }

  factory GoodsReceiptDetailAttachmentModel.fromEntity(GoodsReceiptAttachmentEntity goodsReceiptAttachmentEntity){
    return GoodsReceiptDetailAttachmentModel(
        poHDId: goodsReceiptAttachmentEntity.poHDId,
        fileName: goodsReceiptAttachmentEntity.fileName,
        url: goodsReceiptAttachmentEntity.url,
        fileType: goodsReceiptAttachmentEntity.fileType,
        fileSize: goodsReceiptAttachmentEntity.fileSize,
        date: goodsReceiptAttachmentEntity.date,
        localUrl: goodsReceiptAttachmentEntity.localUrl,
        isSync: goodsReceiptAttachmentEntity.isSync
    );
  }

  static List<GoodsReceiptDetailAttachmentModel> fromEntityList(List<GoodsReceiptAttachmentEntity> goodsReceiptAttachmentEntityList){
    List<GoodsReceiptDetailAttachmentModel> attachmentModelList = [];
    for (var entity in goodsReceiptAttachmentEntityList) {
      attachmentModelList.add(GoodsReceiptDetailAttachmentModel.fromEntity(entity));
    }
    return attachmentModelList;
  }
}
