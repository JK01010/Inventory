import 'package:equatable/equatable.dart';

import '../../domain/entities/goods_receipt_label_entity.dart';

class GoodsReceiptLabelResponseModel extends Equatable {
  GoodsReceiptLabelResponseModel({this.goodsReceiptLabelList});

  factory GoodsReceiptLabelResponseModel.fromJson(Map<String, dynamic> json) {
    return GoodsReceiptLabelResponseModel(
      goodsReceiptLabelList:
          (json['goodsReceiptDetailLabelItems'] as List<dynamic>?)
              ?.map((e) => GoodsReceiptLabelModel.fromMap(e))
              .toList(),
    );
  }

  List<GoodsReceiptLabelModel>? goodsReceiptLabelList;

  Map<String, dynamic> toJson() {
    return {
      'goodsReceiptDetailLabelItems':
          goodsReceiptLabelList?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [goodsReceiptLabelList];
}

class GoodsReceiptLabelModel extends Equatable {
  factory GoodsReceiptLabelModel.fromMap(Map<String, dynamic> json) {
    return GoodsReceiptLabelModel(
      dtId: json['dtId'] as int?,
      hdId: json['hdId'] as int?,
      itemId: json['itemId'] as int?,
      qty: json['qty'] as int?,
      packetSize: json['packetSize'] as String?,
      unitPrice: json['unitPrice'] as String?,
      imdgClassId: json['imdgClassId'] as int?,
      remarksFromVendor: json['remarksFromVendor'] as String?,
      flag: json['flag'] as String?,
      expiryDate: json['expiryDate'] as String?,
      tags: json['tags'] as String?,
      isPartial: json['isPartial'] as String?,
      isSync: json['isSync'] as String?,
    );
  }

  factory GoodsReceiptLabelModel.fromEntity(
    GoodsReceiptLabelEntity goodsReceiptLabelEntity,
  ) {
    return GoodsReceiptLabelModel(
      dtId: goodsReceiptLabelEntity.dtId,
      hdId: goodsReceiptLabelEntity.hdId,
      itemId: goodsReceiptLabelEntity.itemId,
      qty: goodsReceiptLabelEntity.qty,
      packetSize: goodsReceiptLabelEntity.packetSize,
      unitPrice: goodsReceiptLabelEntity.unitPrice,
      imdgClassId: goodsReceiptLabelEntity.imdgClassId,
      remarksFromVendor: goodsReceiptLabelEntity.remarksFromVendor,
      flag: goodsReceiptLabelEntity.flag,
      expiryDate: goodsReceiptLabelEntity.expiryDate,
      tags: goodsReceiptLabelEntity.tags,
      isPartial: goodsReceiptLabelEntity.isPartial,
      isSync: goodsReceiptLabelEntity.isSync,
    );
  }

  GoodsReceiptLabelModel({
    required this.dtId,
    required this.hdId,
    required this.itemId,
    required this.qty,
    required this.packetSize,
    required this.unitPrice,
    required this.imdgClassId,
    required this.remarksFromVendor,
    required this.flag,
    required this.expiryDate,
    required this.tags,
    required this.isPartial,
    required this.isSync,
  });

  final int? dtId;
  final int? hdId;
  final int? itemId;
  final int? qty;
  final String? packetSize;
  final String? unitPrice;
  final int? imdgClassId;
  final String? remarksFromVendor;
  final String? flag;
  final String? expiryDate;
  final String? tags;
  final String? isPartial;
  final String? isSync;

  Map<String, dynamic> toJson() {
    return {
      'dtId': dtId,
      'hdId': hdId,
      'itemId': itemId,
      'qty': qty,
      'packetSize': packetSize,
      'unitPrice': unitPrice,
      'imdgClassId': imdgClassId,
      'remarksFromVendor': remarksFromVendor,
      'flag': flag,
      'expiryDate': expiryDate,
      'tags': tags,
      'isPartial': isPartial,
      'isSync': isSync,
    };
  }

  GoodsReceiptLabelModel toEntity() {
    return GoodsReceiptLabelModel(
      dtId: dtId ?? 0,
      hdId: hdId ?? 0,
      itemId: itemId ?? 0,
      qty: qty ?? 0,
      packetSize: packetSize ?? "",
      unitPrice: unitPrice ?? "",
      imdgClassId: imdgClassId ?? 0,
      remarksFromVendor: remarksFromVendor ?? "",
      flag: flag ?? "",
      expiryDate: expiryDate ?? "",
      tags: tags ?? "",
      isPartial: isPartial ?? "",
      isSync: isSync ?? "",
    );
  }

  static List<GoodsReceiptLabelModel> fromEntityList(
    List<GoodsReceiptLabelEntity> goodsReceiptDetailLabelEntityList,
  ) {
    List<GoodsReceiptLabelModel> goodsReceiptLabelModelList = [];
    for (var entity in goodsReceiptDetailLabelEntityList) {
      goodsReceiptLabelModelList.add(GoodsReceiptLabelModel.fromEntity(entity));
    }
    return goodsReceiptLabelModelList;
  }

  Map<String, dynamic> toMap() {
    return {
      'dtId': dtId,
      'hdId': hdId,
      'itemId': itemId,
      'qty': qty,
      'packetSize': packetSize,
      'unitPrice': unitPrice,
      'imdgClassId': imdgClassId,
      'remarksFromVendor': remarksFromVendor,
      'flag': flag,
      'expiryDate': expiryDate,
      'tags': tags,
      'isPartial': isPartial,
      'isSync': isSync,
    };
  }

  @override
  List<Object?> get props => [
    dtId,
    hdId,
    itemId,
    qty,
    packetSize,
    unitPrice,
    imdgClassId,
    remarksFromVendor,
    flag,
    expiryDate,
    tags,
    isPartial,
    isSync,
  ];
}
