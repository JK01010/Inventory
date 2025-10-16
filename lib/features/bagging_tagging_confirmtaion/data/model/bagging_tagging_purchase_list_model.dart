import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/bagging_tagging_purchase_list_entity.dart';

class BaggingTaggingPurchaseListResponseModel extends Equatable {
  const BaggingTaggingPurchaseListResponseModel({
    required this.baggingTaggingPurchaseList,
  });

  factory BaggingTaggingPurchaseListResponseModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return BaggingTaggingPurchaseListResponseModel(
      baggingTaggingPurchaseList: List<BaggingTaggingPurchaseListModel>.from(
        (map['baggingTaggingPurchaseList'] as List).map(
          (x) => BaggingTaggingPurchaseListModel.fromMap(
            x as Map<String, dynamic>,
          ),
        ),
      ),
    );
  }

  factory BaggingTaggingPurchaseListResponseModel.fromJson(String source) =>
      BaggingTaggingPurchaseListResponseModel.fromMap(json.decode(source));

  final List<BaggingTaggingPurchaseListModel> baggingTaggingPurchaseList;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'baggingTaggingPurchaseList':
          baggingTaggingPurchaseList.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [baggingTaggingPurchaseList];
}

class BaggingTaggingPurchaseListModel extends Equatable {
  const BaggingTaggingPurchaseListModel({
    required this.id,
    required this.itemId,
    required this.poHdId,
    required this.receivedQty,
    required this.remark,
    required this.qualityId,
    required this.flag,
    required this.tags,
    required this.imdgClassId,
    required this.unitPrice,
    required this.packetSize,
    required this.poQty,
    required this.remarksFromVendor,
    required this.reconditionedQty,
    required this.damagedQty,
    required this.newQty,
    required this.batchName,
    required this.expiryDate,
  });

  factory BaggingTaggingPurchaseListModel.fromMap(Map<String, dynamic> map) {
    return BaggingTaggingPurchaseListModel(
      id: map['id'] as int,
      itemId: map['itemId'] as int,
      poHdId: map['poHdId'] as int,
      receivedQty: map['receivedQty'] as int,
      remark: map['remark'] as String,
      qualityId: map['qualityId'] as int,
      flag: map['flag'] as String,
      tags: map['tags'] as String,
      imdgClassId: map['imdgClassId'] as int,
      unitPrice: map['unitPrice'] as String,
      packetSize: map['packetSize'] as String,
      poQty: map['poQty'] as int,
      remarksFromVendor: map['remarksFromVendor'] as String,
      reconditionedQty: map['reconditionedQty'] as int,
      damagedQty: map['damagedQty'] as int,
      newQty: map['newQty'] as int,
      batchName: map['batchName'] as String,
      expiryDate: map['expiryDate'] as String,
    );
  }

  factory BaggingTaggingPurchaseListModel.fromJson(String source) =>
      BaggingTaggingPurchaseListModel.fromMap(json.decode(source));

  factory BaggingTaggingPurchaseListModel.fromEntity(
    BaggingTaggingPurchaseEntity entity,
  ) => BaggingTaggingPurchaseListModel(
    id: entity.id,
    itemId: entity.itemId,
    poHdId: entity.poHdId,
    receivedQty: entity.receivedQty,
    remark: entity.remark,
    qualityId: entity.qualityId,
    flag: entity.flag,
    tags: entity.tags,
    imdgClassId: entity.imdgClassId,
    unitPrice: entity.unitPrice,
    packetSize: entity.packetSize,
    poQty: entity.poQty,
    remarksFromVendor: entity.remarksFromVendor,
    reconditionedQty: entity.reconditionedQty,
    damagedQty: entity.damagedQty,
    newQty: entity.newQty,
    batchName: entity.batchName,
    expiryDate: entity.expiryDate,
  );

  final int id;
  final int itemId;
  final int poHdId;
  final int receivedQty;
  final String remark;
  final int qualityId;
  final String flag;
  final String tags;
  final int imdgClassId;
  final String unitPrice;
  final String packetSize;
  final int poQty;
  final String remarksFromVendor;
  final int reconditionedQty;
  final int damagedQty;
  final int newQty;
  final String batchName;
  final String expiryDate;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'itemId': itemId,
      'poHdId': poHdId,
      'receivedQty': receivedQty,
      'remark': remark,
      'qualityId': qualityId,
      'flag': flag,
      'tags': tags,
      'imdgClassId': imdgClassId,
      'unitPrice': unitPrice,
      'packetSize': packetSize,
      'poQty': poQty,
      'remarksFromVendor': remarksFromVendor,
      'reconditionedQty': reconditionedQty,
      'damagedQty': damagedQty,
      'newQty': newQty,
      'batchName': batchName,
      'expiryDate': expiryDate,
    };
  }

  String toJson() => json.encode(toMap());

  BaggingTaggingPurchaseListModel copyWith({
    int? id,
    int? itemId,
    int? poHdId,
    int? receivedQty,
    String? remark,
    int? qualityId,
    String? flag,
    String? tags,
    int? imdgClassId,
    String? unitPrice,
    String? packetSize,
    int? poQty,
    String? remarksFromVendor,
    int? reconditionedQty,
    int? damagedQty,
    int? newQty,
    String? batchName,
    String? expiryDate,

  }) {
    return BaggingTaggingPurchaseListModel(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      poHdId: poHdId ?? this.poHdId,
      receivedQty: receivedQty ?? this.receivedQty,
      remark: remark ?? this.remark,
      qualityId: qualityId ?? this.qualityId,
      flag: flag ?? this.flag,
      tags: tags ?? this.tags,
      imdgClassId: imdgClassId ?? this.imdgClassId,
      unitPrice: unitPrice ?? this.unitPrice,
      packetSize: packetSize ?? this.packetSize,
      poQty: poQty ?? this.poQty,
      remarksFromVendor: remarksFromVendor ?? this.remarksFromVendor,
      reconditionedQty: reconditionedQty?? this.reconditionedQty,
      damagedQty: damagedQty ?? this.damagedQty,
      newQty: newQty ?? this.newQty,
      batchName: batchName ?? this.batchName,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }

  BaggingTaggingPurchaseEntity toEntity() => BaggingTaggingPurchaseEntity(
    id: id,
    itemId: itemId,
    poHdId: poHdId,
    receivedQty: receivedQty,
    remark: remark,
    qualityId: qualityId,
    flag: flag,
    tags: tags,
    imdgClassId: imdgClassId,
    unitPrice: unitPrice,
    packetSize: packetSize,
    poQty: poQty,
    remarksFromVendor: remarksFromVendor,
    reconditionedQty: reconditionedQty,
    damagedQty: damagedQty,
    newQty: newQty,
    batchName: batchName,
    expiryDate: expiryDate,
  );

  @override
  List<Object?> get props => [
    id,
    itemId,
    poHdId,
    receivedQty,
    remark,
    qualityId,
    flag,
    tags,
    imdgClassId,
    unitPrice,
    packetSize,
    poQty,
    remarksFromVendor,
    reconditionedQty,
    damagedQty,
    newQty,
    batchName,
    expiryDate,
  ];

  @override
  bool? get stringify => true;
}
