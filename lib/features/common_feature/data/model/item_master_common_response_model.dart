import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../../domain/entities/item_master_common_entity_model.dart';

class ItemMasterResponseModel extends Equatable {
  const ItemMasterResponseModel({required this.itemMasterList});

  factory ItemMasterResponseModel.fromJson(String source) =>
      ItemMasterResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  factory ItemMasterResponseModel.fromMap(Map<String, dynamic> map) {
    return ItemMasterResponseModel(
      itemMasterList: List<ItemMasterModel>.from(
        (map['itemMasterList'] as List<dynamic>).map<ItemMasterModel>(
              (x) => ItemMasterModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  final List<ItemMasterModel> itemMasterList;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemMasterList': itemMasterList.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [itemMasterList];

  @override
  bool? get stringify => true;
}

class ItemMasterModel extends ItemMasterEntity {
  const ItemMasterModel({
    required super.itemId,
    required super.itemCode,
    required super.itemName,
    required super.defaultStorageLocationId,
    required super.partNo,
    required super.drawingNo,
    required super.articleNumber,
    required super.uomId,
    required super.stockAdjustmentFlag,
    required super.equipmentId,
    required super.equipmentName,
    required super.equipmentFlag,
    required super.activeFlag,
    required super.categoryId,
    required super.sectionId,
    required super.subSectionId,
    required super.serialNo,
    required super.ihm,
    required super.groupId,
    required super.mdRequired,
    required super.sDocRequired,
    required super.zeroDeclaration,
    super.uomName,
    super.totalRob,
    super.newStock,
    super.reconditionedStock,
  });

  factory ItemMasterModel.fromMap(Map<String, dynamic> map) {
    return ItemMasterModel(
      itemId: map['itemId'] as int? ?? 0,
      itemCode: map['itemCode'] as String? ?? '',
      itemName: map['itemName'] as String? ?? '',
      defaultStorageLocationId: map['defaultStorageLocationId'] as int? ?? 0,
      partNo: map['partNo'] as String? ?? '',
      drawingNo: map['drawingNo'] as String? ?? '',
      articleNumber: map['articleNumber'] as String? ?? '',
      uomId: map['uomId'] as int? ?? 0,
      stockAdjustmentFlag: map['stockAdjustmentFlag'] as String? ?? '',
      equipmentId: map['equipmentId'] as int? ?? 0,
      equipmentName: map['equipmentName'] as String? ?? '',
      equipmentFlag: map['equipmentFlag'] as String? ?? '',
      activeFlag: map['activeFlag'] as String? ?? '',
      categoryId: map['categoryId'] as int? ?? 0,
      sectionId: map['sectionId'] as int? ?? 0,
      subSectionId: map['subSectionId'] as int? ?? 0,
      serialNo: map['serialNo'] as String? ?? '',
      ihm: map['ihm'] as String? ?? '',
      groupId: map['groupId'] as int? ?? 0,
      mdRequired: map['mdRequired'] as String? ?? '',
      sDocRequired: map['sDocRequired'] as String? ?? '',
      zeroDeclaration: map['zeroDeclaration'] as String? ?? '',
      uomName: map['uomName'] as String? ?? '',
      totalRob: map['TotalROB'] as double? ?? 0.0,
      newStock: map['NewStock'] as double? ?? 0.0,
      reconditionedStock: map['ReconditionedStock'] as double? ?? 0.0,
    );
  }

  factory ItemMasterModel.fromJson(String source) =>
      ItemMasterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemId': itemId,
      'itemCode': itemCode,
      'itemName': itemName,
      'defaultStorageLocationId': defaultStorageLocationId,
      'partNo': partNo,
      'drawingNo': drawingNo,
      'articleNumber': articleNumber,
      'uomId': uomId,
      'stockAdjustmentFlag': stockAdjustmentFlag,
      'equipmentId': equipmentId,
      'equipmentName': equipmentName,
      'equipmentFlag': equipmentFlag,
      'activeFlag': activeFlag,
      'categoryId': categoryId,
      'sectionId': sectionId,
      'subSectionId': subSectionId,
      'serialNo': serialNo,
      'ihm': ihm,
      'groupId': groupId,
      'mdRequired': mdRequired,
      'sDocRequired': sDocRequired,
      'zeroDeclaration': zeroDeclaration,
      'uomName': uomName,
      'TotalROB': totalRob,
      'NewStock': newStock,
      'ReconditionedStock': reconditionedStock,
    };
  }

  String toJson() => json.encode(toMap());
}
