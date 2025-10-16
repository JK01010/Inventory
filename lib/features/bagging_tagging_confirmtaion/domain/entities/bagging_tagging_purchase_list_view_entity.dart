import 'package:equatable/equatable.dart';

class BaggingTaggingPurchaseListViewEntity extends Equatable {
    BaggingTaggingPurchaseListViewEntity({
    required this.itemId,
    required this.articleNumber,
    required this.partNo,
    required this.itemName,
    required this.drawingNo,
    required this.uomId,
    required this.packetSize,
    required this.poQty,
    required this.unitPrice,
    required this.totalAcceptedQty,
    required this.returnQty,
    required this.imdgTypeName,
    required this.remarksFromVendor,
    required this.equipmentName,
    required this.receivedQty,
    required this.damagedQty,
    required this.newQty,
    required this.reconditionedQty,
    required this.categoryName,
    required this.sectionName,
    required this.subSectionName,
    required this.quality,
    required this.expiryDate,
    required this.batchName,
    required this.serialNo,
    required this.remark,
    required this.locName,
    required this.tags,
    required this.mdRequired,
    required this.sDocRequired,
    required this.zeroDeclaration,
    this.isSelected = false

  });
  final int itemId;
  final String articleNumber;
  final String partNo;
  final String itemName;
  final String drawingNo;
  final int uomId;
  final String packetSize;
  final int poQty;
  final String unitPrice;
  final int totalAcceptedQty;
  final int returnQty;
  final String imdgTypeName;
  final String remarksFromVendor;
  final String equipmentName;
  final int receivedQty;
  final int damagedQty;
  final int newQty;
  final int reconditionedQty;
  final String categoryName;
  final String sectionName;
  final String subSectionName;
  final String quality;
  final String expiryDate;
  final String batchName;
  final String serialNo;
  final String remark;
  final String locName;
  final String tags;
  final String mdRequired;
  final String sDocRequired;
  final String zeroDeclaration;
  bool isSelected;

  @override
  List<Object?> get props => [
    itemId,
    articleNumber,
    partNo,
    itemName,
    drawingNo,
    uomId,
    packetSize,
    poQty,
    unitPrice,
    totalAcceptedQty,
    returnQty,
    imdgTypeName,
    remarksFromVendor,
    equipmentName,
    receivedQty,
    damagedQty,
    newQty,
    reconditionedQty,
    categoryName,
    sectionName,
    subSectionName,
    quality,
    expiryDate,
    batchName,
    serialNo,
    remark,
    locName,
    tags,
    mdRequired,
    sDocRequired,
    zeroDeclaration,
    isSelected
  ];

  @override
  bool? get stringify => true;

  BaggingTaggingPurchaseListViewEntity copyWith({
    int? itemId,
    String? articleNumber,
    String? partNo,
    String? itemName,
    String? drawingNo,
    int? uomId,
    String? packetSize,
    int? poQty,
    String? unitPrice,
    int? totalAcceptedQty,
    int? returnQty,
    String? imdgTypeName,
    String? remarksFromVendor,
    String? equipmentName,
    int? receivedQty,
    int? damagedQty,
    int? newQty,
    int? reconditionedQty,
    String? categoryName,
    String? sectionName,
    String? subSectionName,
    String? quality,
    String? expiryDate,
    String? batchName,
    String? serialNo,
    String? remark,
    String? locName,
    String? tags,
    String? mdRequired,
    String? sDocRequired,
    String? zeroDeclaration,
    bool? isSelected,
  }) {
    return BaggingTaggingPurchaseListViewEntity(
      itemId: itemId ?? this.itemId,
      articleNumber: articleNumber ?? this.articleNumber,
      partNo: partNo ?? this.partNo,
      itemName: itemName ?? this.itemName,
      drawingNo: drawingNo ?? this.drawingNo,
      uomId: uomId ?? this.uomId,
      packetSize: packetSize ?? this.packetSize,
      poQty: poQty ?? this.poQty,
      unitPrice: unitPrice ?? this.unitPrice,
      totalAcceptedQty: totalAcceptedQty ?? this.totalAcceptedQty,
      returnQty: returnQty ?? this.returnQty,
      imdgTypeName: imdgTypeName ?? this.imdgTypeName,
      remarksFromVendor: remarksFromVendor ?? this.remarksFromVendor,
      equipmentName: equipmentName ?? this.equipmentName,
      receivedQty: receivedQty ?? this.receivedQty,
      damagedQty: damagedQty ?? this.damagedQty,
      newQty: newQty ?? this.newQty,
      reconditionedQty: reconditionedQty ?? this.reconditionedQty,
      categoryName: categoryName ?? this.categoryName,
      sectionName: sectionName ?? this.sectionName,
      subSectionName: subSectionName ?? this.subSectionName,
      quality: quality ?? this.quality,
      expiryDate: expiryDate ?? this.expiryDate,
      batchName: batchName ?? this.batchName,
      serialNo: serialNo ?? this.serialNo,
      remark: remark ?? this.remark,
      locName: locName ?? this.locName,
      tags: tags ?? this.tags,
      mdRequired: mdRequired ?? this.mdRequired,
      sDocRequired: sDocRequired ?? this.sDocRequired,
      zeroDeclaration: zeroDeclaration ?? this.zeroDeclaration,
      isSelected: isSelected ?? this.isSelected,
    );
  }

}