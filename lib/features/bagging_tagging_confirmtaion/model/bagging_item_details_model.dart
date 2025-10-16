import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../domain/entities/bagging_item_details_entity.dart';

class BaggingItemDetailResponseModel extends Equatable {
  const BaggingItemDetailResponseModel({required this.baggingItemDetailModel});

  final List<BaggingItemDetailModel> baggingItemDetailModel;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'baggingItemDetailsEntity':
          baggingItemDetailModel.map((x) => x.toMap()).toList(),
    };
  }

  factory BaggingItemDetailResponseModel.fromMap(Map<String, dynamic> map) {
    return BaggingItemDetailResponseModel(
      baggingItemDetailModel: List<BaggingItemDetailModel>.from(
        (map['baggingItemDetailsEntity'] as List<dynamic>)
            .map<BaggingItemDetailModel>(
              (x) => BaggingItemDetailModel.fromMap(x as Map<String, dynamic>),
            ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory BaggingItemDetailResponseModel.fromJson(String source) =>
      BaggingItemDetailResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  List<Object?> get props => [baggingItemDetailModel];

  @override
  bool? get stringify => true;
}

class BaggingItemDetailModel extends BaggingItemDetailsEntity {
  const BaggingItemDetailModel({
    required super.itemId,
    required super.roughItemId,
    required super.articleNo,
    required super.partNo,
    required super.productName,
    required super.plateDrawingNo,
    required super.uom,
    required super.packSize,
    required super.poQty,
    required super.unitPrize,
    required super.totalAcceptedQty,
    required super.returnQty,
    required super.imdgClass,
    required super.remarksFromVendor,
    required super.equipment,
    required super.itemCategory,
    required super.itemSection,
    required super.itemSubSection,
    required super.receivedQty,
    required super.damageWrongQty,
    required super.newStock,
    required super.reconditionStock,
    required super.quality,
    required super.expiryDate,
    required super.batchNo,
    required super.serialNo,
    required super.remarks,
    required super.defaultStorageLocation,
    super.attachment,
    required super.mdRequired,
    required super.sDocRequired,
    required super.zeroDeclaration,
    required super.iHMMaterialQty,
    super.iHMAttachment,

  });

  @override
  bool? get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemId': itemId,
      'roughItemId': roughItemId,
      'articleNo': articleNo,
      'partNo': partNo,
      'productName': productName,
      'plateDrawingNo': plateDrawingNo,
      'uom': uom,
      'packSize': packSize,
      'poQty': poQty,
      'unitPrize': unitPrize,
      'totalAcceptedQty': totalAcceptedQty,
      'returnQty': returnQty,
      'imdgClass': imdgClass,
      'remarksFromVendor': remarksFromVendor,
      'equipment': equipment,
      'itemCategory': itemCategory,
      'itemSection': itemSection,
      'itemSubSection': itemSubSection,
      'receivedQty': receivedQty,
      'damageWrongQty': damageWrongQty,
      'newStock': newStock,
      'reconditionStock': reconditionStock,
      'quality': quality,
      'expiryDate': expiryDate,
      'batchNo': batchNo,
      'serialNo': serialNo,
      'remarks': remarks,
      'defaultStorageLocation': defaultStorageLocation,
      'attachment': attachment,
      'mdRequired': mdRequired,
      'sDocRequired': sDocRequired,
      'zeroDeclaration': zeroDeclaration,
      'iHMMaterialQty': iHMMaterialQty,
      'iHMAttachment': iHMAttachment,

    };
  }

  factory BaggingItemDetailModel.fromMap(Map<String, dynamic> map) {
    return BaggingItemDetailModel(
      itemId: map['itemId'] as int,
      roughItemId: map['roughItemId'] as int,
      articleNo: map['articleNo'] as String,
      partNo: map['partNo'] as String,
      productName: map['productName'] as String,
      plateDrawingNo: map['plateDrawingNo'] as String,
      uom: map['uom'] as String,
      packSize: map['packSize'] as int,
      poQty: map['poQty'] as int,
      unitPrize: map['unitPrize'] as int,
      totalAcceptedQty: map['totalAcceptedQty'] as int,
      returnQty: map['returnQty'] as int,
      imdgClass: map['imdgClass'] as String,
      remarksFromVendor: map['remarksFromVendor'] as String,
      equipment: map['equipment'] as String,
      itemCategory: map['itemCategory'] as String,
      itemSection: map['itemSection'] as String,
      itemSubSection: map['itemSubSection'] as String,
      receivedQty: map['receivedQty'] as int,
      damageWrongQty: map['damageWrongQty'] as int,
      newStock: map['newStock'] as int,
      reconditionStock: map['reconditionStock'] as int,
      quality: map['quality'] as String,
      expiryDate: map['expiryDate'] as String,
      batchNo: map['batchNo'] as String,
      serialNo: map['serialNo'] as String,
      remarks: map['remarks'] as String,
      defaultStorageLocation: map['defaultStorageLocation'] as String,
      attachment: map['attachment'] as String,
      mdRequired: map['mdRequired'] as String,
      sDocRequired: map['sDocRequired'] as String,
      zeroDeclaration: map['zeroDeclaration'] as String,
      iHMMaterialQty: map['iHMMaterialQty'] as String,
      iHMAttachment: map['iHMAttachment'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BaggingItemDetailModel.fromJson(String source) =>
      BaggingItemDetailModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
