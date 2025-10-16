import 'package:equatable/equatable.dart';

class ItemMasterCommonEntityModel {
  ItemMasterCommonEntityModel({required this.itemMasterList});

  final List<ItemMasterEntity> itemMasterList;
}

class ItemMasterEntity extends Equatable {
  const ItemMasterEntity({
    required this.itemId,
    required this.itemCode,
    required this.itemName,
    required this.defaultStorageLocationId,
    required this.partNo,
    required this.drawingNo,
    required this.articleNumber,
    required this.uomId,
    required this.totalAcceptedQty,
    required this.returnQty,
    required this.stockAdjustmentFlag,
    required this.equipmentId,
    required this.equipmentName,
    required this.equipmentFlag,
    required this.activeFlag,
    required this.categoryId,
    required this.sectionId,
    required this.subSectionId,
    required this.serialNo,
    required this.ihm,
    required this.groupId,
    required this.mdRequired,
    required this.sDocRequired,
    required this.zeroDeclaration,
  });

  final int itemId;
  final String itemCode;
  final String itemName;
  final int defaultStorageLocationId;
  final String partNo;
  final String drawingNo;
  final String articleNumber;
  final int uomId;
  final int totalAcceptedQty;
  final int returnQty;
  final String stockAdjustmentFlag;
  final int equipmentId;
  final String equipmentName;
  final String equipmentFlag;
  final int activeFlag;
  final int categoryId;
  final int sectionId;
  final int subSectionId;
  final String serialNo;
  final int ihm;
  final int groupId;
  final int mdRequired;
  final int sDocRequired;
  final int zeroDeclaration;

  @override
  List<Object?> get props => [
    itemId,
    itemCode,
    itemName,
    defaultStorageLocationId,
    partNo,
    drawingNo,
    articleNumber,
    uomId,
    totalAcceptedQty,
    returnQty,
    stockAdjustmentFlag,
    equipmentId,
    equipmentName,
    equipmentFlag,
    activeFlag,
    categoryId,
    sectionId,
    subSectionId,
    serialNo,
    ihm,
    groupId,
    mdRequired,
    sDocRequired,
    zeroDeclaration,
  ];

  @override
  bool get stringify => true;
}
