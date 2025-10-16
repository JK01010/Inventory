import 'package:equatable/equatable.dart';

import '../../domain/entities/goods_receipt_transaction_detail_entity.dart';

class GoodsReceiptTransactionDetailResponseModel extends Equatable {
  GoodsReceiptTransactionDetailResponseModel({
    this.goodsReceiptTransactionDetailList,
  });

  factory GoodsReceiptTransactionDetailResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return GoodsReceiptTransactionDetailResponseModel(
      goodsReceiptTransactionDetailList:
          (json['goodsReceiptTransactionDetail'] as List<dynamic>?)
              ?.map((e) => GoodsReceiptTransactionDetailModel.fromMap(e))
              .toList(),
    );
  }

  List<GoodsReceiptTransactionDetailModel>? goodsReceiptTransactionDetailList;

  Map<String, dynamic> toJson() {
    return {
      'goodsReceiptTransactionDetail':
          goodsReceiptTransactionDetailList?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [goodsReceiptTransactionDetailList];
}

class GoodsReceiptTransactionDetailModel extends Equatable {
  const GoodsReceiptTransactionDetailModel({
    required this.id,
    required this.itemId,
    required this.hdId,
    required this.poDtId,
    required this.receivedQty,
    required this.remarks,
    required this.qualityId,
    required this.flag,
    required this.reConditionedQty,
    required this.damagedQty,
    required this.newQty,
    required this.imdgClassId,
    required this.batchName,
    required this.remarksFromVendor,
    required this.expiryDate,
    required this.tags,
    required this.isSync,
  });

  factory GoodsReceiptTransactionDetailModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return GoodsReceiptTransactionDetailModel(
      id: json['id'] as int?,
      itemId: json['itemId'] as int?,
      hdId: json['hdId'] as int?,
      poDtId: json['poDtId'] as String?,
      receivedQty: json['receivedQty'] as int?,
      remarks: json['remarks'] as String?,
      qualityId: json['qualityId'] as int?,
      flag: json['flag'] as String?,
      reConditionedQty: json['reConditionedQty'] as int?,
      damagedQty: json['damagedQty'] as int?,
      newQty: json['newQty'] as int?,
      imdgClassId: json['imdgClassId'] as int?,
      batchName: json['batchName'] as String?,
      remarksFromVendor: json['remarksFromVendor'] as String,
      expiryDate: json['expiryDate'] as String?,
      tags: json['tags'] as String?,
      isSync: json['isSync'] as String?,
    );
  }

  factory GoodsReceiptTransactionDetailModel.fromEntity(
    GoodsReceiptTransactionDetailEntity goodsReceiptTransactionDetailEntity,
  ) {
    return GoodsReceiptTransactionDetailModel(
      id: goodsReceiptTransactionDetailEntity.id,
      itemId: goodsReceiptTransactionDetailEntity.itemId,
      hdId: goodsReceiptTransactionDetailEntity.hdId,
      poDtId: goodsReceiptTransactionDetailEntity.poDtId,
      receivedQty: goodsReceiptTransactionDetailEntity.receivedQty,
      remarks: goodsReceiptTransactionDetailEntity.remarks,
      qualityId: goodsReceiptTransactionDetailEntity.qualityId,
      flag: goodsReceiptTransactionDetailEntity.flag,
      reConditionedQty: goodsReceiptTransactionDetailEntity.reConditionedQty,
      damagedQty: goodsReceiptTransactionDetailEntity.damagedQty,
      newQty: goodsReceiptTransactionDetailEntity.newQty,
      imdgClassId: goodsReceiptTransactionDetailEntity.imdgClassId,
      batchName: goodsReceiptTransactionDetailEntity.batchName,
      remarksFromVendor: goodsReceiptTransactionDetailEntity.remarksFromVendor,
      expiryDate: goodsReceiptTransactionDetailEntity.expiryDate,
      tags: goodsReceiptTransactionDetailEntity.tags,
      isSync: goodsReceiptTransactionDetailEntity.isSync,
    );
  }

  final int? id;
  final int? itemId;
  final int? hdId;
  final String? poDtId;
  final int? receivedQty;
  final String? remarks;
  final int? qualityId;
  final String? flag;
  final int? reConditionedQty;
  final int? damagedQty;
  final int? newQty;
  final int? imdgClassId;
  final String? batchName;
  final String? remarksFromVendor;
  final String? expiryDate;
  final String? tags;
  final String? isSync;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'itemId': itemId,
      'hdId': hdId,
      'poDtId': poDtId,
      'receivedQty': receivedQty,
      'remarks': remarks,
      'qualityId': qualityId,
      'flag': flag,
      'reConditionedQty': reConditionedQty,
      'damagedQty': damagedQty,
      'newQty': newQty,
      'imdgClassId': imdgClassId,
      'batchName': batchName,
      'remarksFromVendor': remarksFromVendor,
      'expiryDate': expiryDate,
      'tags': tags,
      'isSync': isSync,
    };
  }

  GoodsReceiptTransactionDetailModel toEntity() {
    return GoodsReceiptTransactionDetailModel(
      id: id ?? 0,
      itemId: itemId ?? 0,
      hdId: hdId ?? 0,
      poDtId: poDtId ?? "",
      receivedQty: receivedQty ?? 0,
      remarks: remarks ?? '',
      qualityId: qualityId ?? 0,
      flag: flag ?? '',
      reConditionedQty: reConditionedQty ?? 0,
      damagedQty: damagedQty ?? 0,
      newQty: newQty ?? 0,
      imdgClassId: imdgClassId ?? 0,
      batchName: batchName ?? '',
      remarksFromVendor: remarksFromVendor ?? '',
      expiryDate: expiryDate ?? '',
      tags: tags ?? '',
      isSync: isSync ?? 'N',
    );
  }

  static List<GoodsReceiptTransactionDetailModel> fromEntityList(
    List<GoodsReceiptTransactionDetailEntity>
    goodsReceiptTransactionDetailEntityList,
  ) {
    List<GoodsReceiptTransactionDetailModel>
    goodsReceiptTransactionDetailModelList = [];
    for (var entity in goodsReceiptTransactionDetailEntityList) {
      goodsReceiptTransactionDetailModelList.add(
        GoodsReceiptTransactionDetailModel.fromEntity(entity),
      );
    }
    return goodsReceiptTransactionDetailModelList;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itemId': itemId,
      'hdId': hdId,
      'poDtId': poDtId,
      'receivedQty': receivedQty,
      'remarks': remarks,
      'qualityId': qualityId,
      'flag': flag,
      'reConditionedQty': reConditionedQty,
      'damagedQty': damagedQty,
      'newQty': newQty,
      'imdgClassId': imdgClassId,
      'batchName': batchName,
      'remarksFromVendor': remarksFromVendor,
      'expiryDate': expiryDate,
      'tags': tags,
      'isSync': isSync,
    };
  }

  @override
  List<Object?> get props => [
    id,
    itemId,
    hdId,
    poDtId,
    receivedQty,
    remarks,
    qualityId,
    flag,
    reConditionedQty,
    damagedQty,
    newQty,
    imdgClassId,
    batchName,
    remarksFromVendor,
    expiryDate,
    tags,
    isSync,
  ];
}
