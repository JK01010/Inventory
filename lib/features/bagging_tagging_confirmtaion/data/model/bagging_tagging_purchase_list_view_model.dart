import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../domain/entities/bagging_tagging_purchase_list_view_entity.dart';

class BaggingTaggingPurchaseListViewResponseModel extends Equatable {
  const BaggingTaggingPurchaseListViewResponseModel({
    required this.baggingTaggingPurchaseListView,
  });

  factory BaggingTaggingPurchaseListViewResponseModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return BaggingTaggingPurchaseListViewResponseModel(
      baggingTaggingPurchaseListView: List<BaggingTaggingPurchaseListViewModel>.from(
        (map['baggingTaggingPurchaseListView'] as List).map(
              (x) => BaggingTaggingPurchaseListViewModel.fromMap(
            x as Map<String, dynamic>,
          ),
        ),
      ),
    );
  }

  factory BaggingTaggingPurchaseListViewResponseModel.fromJson(String source) =>
      BaggingTaggingPurchaseListViewResponseModel.fromMap(json.decode(source));

  final List<BaggingTaggingPurchaseListViewModel> baggingTaggingPurchaseListView;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'baggingTaggingPurchaseListView':
      baggingTaggingPurchaseListView.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [baggingTaggingPurchaseListView];
}


class BaggingTaggingPurchaseListViewModel extends Equatable {
  const BaggingTaggingPurchaseListViewModel({
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
    this.locName,
    required this.tags,
    required this.mdRequired,
    required this.sDocRequired,
    required this.zeroDeclaration
  });

  factory BaggingTaggingPurchaseListViewModel.fromMap(Map<String, dynamic> map) {
    return BaggingTaggingPurchaseListViewModel(
      itemId: map['itemId'] as int,
      articleNumber: map['articleNumber'] as String,
      partNo: map['partNo'] as String,
      itemName: map['itemName'] as String,
      drawingNo: map['drawingNo'] as String,
      uomId: map['uomId'] as int,
      packetSize: map['packetSize'] as String,
      poQty: map['poQty'] as int,
      unitPrice: map['unitPrice'] as String,
      totalAcceptedQty: map['totalAcceptedQty'] as int,
      returnQty: map['returnQty'] as int,
        imdgTypeName: map['imdgTypeName'] as String,
      remarksFromVendor: map['remarksFromVendor'] as String,
      equipmentName: map['equipmentName'] as String,
      receivedQty: map['receivedQty'] as int,
      damagedQty: map['damagedQty'] as int,
      newQty: map['newQty'] as int,
      reconditionedQty: map['reconditionedQty'] as int,
      categoryName: map['categoryName'] as String? ?? '',
      sectionName: map['sectionName'] as String,
      subSectionName: map['subSectionName'] as String,
      quality: map['quality'] as String,
      expiryDate: map['expiryDate'] as String,
      batchName: map['batchName'] as String,
      serialNo: map['serialNo'] as String,
      remark: map['remark'] as String,
        locName: map['locName'] as String?,
      tags: map['tags'] as String,
      mdRequired: map['mdRequired'] as String,
      sDocRequired: map['sDocRequired'] as String,
      zeroDeclaration: map['zeroDeclaration'] as String
    );
  }

  factory BaggingTaggingPurchaseListViewModel.fromJson(String source) =>
      BaggingTaggingPurchaseListViewModel.fromMap(json.decode(source));

  factory BaggingTaggingPurchaseListViewModel.fromEntity(
      BaggingTaggingPurchaseListViewEntity entity,
      ) => BaggingTaggingPurchaseListViewModel(
    itemId: entity.itemId,
    articleNumber: entity.articleNumber,
    partNo: entity.partNo,
    itemName: entity.itemName,
    drawingNo: entity.drawingNo,
    uomId: entity.uomId,
    packetSize: entity.packetSize,
    poQty: entity.poQty,
    unitPrice: entity.unitPrice,
    totalAcceptedQty: entity.totalAcceptedQty,
    returnQty: entity.returnQty,
      imdgTypeName: entity.imdgTypeName,
    remarksFromVendor: entity.remarksFromVendor,
    equipmentName: entity.equipmentName,
    receivedQty: entity.receivedQty,
    damagedQty: entity.damagedQty,
    newQty: entity.newQty,
    reconditionedQty: entity.reconditionedQty,
    categoryName: entity.categoryName,
    sectionName: entity.sectionName,
    subSectionName: entity.subSectionName,
    quality: entity.quality,
    expiryDate: entity.expiryDate,
    batchName: entity.batchName,
    serialNo: entity.serialNo,
    remark: entity.remark,
      locName: entity.locName,
    tags: entity.tags,
    mdRequired: entity.mdRequired,
    sDocRequired: entity.sDocRequired,
    zeroDeclaration: entity.zeroDeclaration

  );
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
  final String? locName;
  final String tags;
  final String mdRequired;
  final String sDocRequired;
  final String zeroDeclaration;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemId': itemId,
      'articleNumber': articleNumber,
      'partNo': partNo,
      'itemName': itemName,
      'drawingNo': drawingNo,
      'uomId': uomId,
      'packetSize': packetSize,
      'poQty': poQty,
      'unitPrice': unitPrice,
      'totalAcceptedQty': totalAcceptedQty,
      'returnQty': returnQty,
      'imdgTypeName': imdgTypeName,
      'remarksFromVendor': remarksFromVendor,
      'equipmentName': equipmentName,
      'receivedQty': receivedQty,
      'damagedQty': damagedQty,
      'newQty': newQty,
      'reconditionedQty': reconditionedQty,
      'categoryName': categoryName,
      'sectionName': sectionName,
      'subSectionName': subSectionName,
      'quality': quality,
      'expiryDate': expiryDate,
      'batchName': batchName,
      'serialNo': serialNo,
      'remark': remark,
      'locName': locName,
      'tags': tags,
      'mdRequired': mdRequired,
      'sDocRequired': sDocRequired,
      'zeroDeclaration': zeroDeclaration,
    };
  }

  String toJson() => json.encode(toMap());

  BaggingTaggingPurchaseListViewModel copyWith({
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
  }) {
    return BaggingTaggingPurchaseListViewModel(
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
      zeroDeclaration: zeroDeclaration ?? this.zeroDeclaration
    );
  }

  BaggingTaggingPurchaseListViewEntity toEntity() => BaggingTaggingPurchaseListViewEntity(
    itemId: itemId,
    articleNumber: articleNumber,
    partNo: partNo,
    itemName: itemName,
    drawingNo: drawingNo,
    uomId: uomId,
    packetSize: packetSize,
    poQty: poQty,
    unitPrice: unitPrice,
    totalAcceptedQty: totalAcceptedQty,
    returnQty: returnQty,
      imdgTypeName: imdgTypeName,
    remarksFromVendor: remarksFromVendor,
    equipmentName: equipmentName,
    receivedQty: receivedQty,
    damagedQty: damagedQty,
    newQty: newQty,
    reconditionedQty: reconditionedQty,
    categoryName: categoryName,
    sectionName: sectionName,
    subSectionName: subSectionName,
    quality: quality,
    expiryDate: expiryDate,
    batchName: batchName,
    serialNo: serialNo,
    remark: remark,
      locName: locName ?? "",
    tags: tags,
    mdRequired: mdRequired,
    sDocRequired: sDocRequired,
    zeroDeclaration: zeroDeclaration
  );

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
    zeroDeclaration
  ];

  @override
  bool? get stringify => true;
}