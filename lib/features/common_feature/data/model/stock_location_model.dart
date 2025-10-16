import 'package:equatable/equatable.dart';
import '../../domain/entities/stock_location_entity.dart';

class CommonStockLocationModel extends Equatable {
  final int? storageLocationID;
  final String? storageLocation;
  final String? storageLocationHierarchy;
  final int? referenceID;
  final int? referenceSubID;
  final int? referenceTypeID;
  final int? itemID;
  final int? itemLinkID;
  final String? grnNo;
  final double? totalROB;
  final double? receivedQty;
  final String? mDocReq;
  final String? sDocReq;
  final String? zeroDocReq;
  final int? ihmMaterialCount;
  final String? poAttachment;
  final String? ihmAttachment;
  final DateTime? inventoryDate;
  final DateTime? expiryDate;
  final double? unitPrice;
  final double? newStock;
  final double? reconditionedStock;

  const CommonStockLocationModel({
    this.storageLocationID,
    this.storageLocation,
    this.storageLocationHierarchy,
    this.referenceID,
    this.referenceSubID,
    this.referenceTypeID,
    this.itemID,
    this.itemLinkID,
    this.grnNo,
    this.totalROB,
    this.receivedQty,
    this.mDocReq,
    this.sDocReq,
    this.zeroDocReq,
    this.ihmMaterialCount,
    this.poAttachment,
    this.ihmAttachment,
    this.inventoryDate,
    this.expiryDate,
    this.unitPrice,
    this.newStock,
    this.reconditionedStock,
  });

  factory CommonStockLocationModel.fromJson(Map<String, dynamic> json) {
    return CommonStockLocationModel(
      storageLocationID: json['StorageLocationID'] as int?,
      storageLocation: json['StorageLocation'] as String?,
      storageLocationHierarchy: json['StorageLocationHierarchy'] as String?,
      referenceID: json['ReferenceID'] as int?,
      referenceSubID: json['ReferenceSubID'] as int?,
      referenceTypeID: json['ReferenceTypeID'] as int?,
      itemID: json['ItemID'] as int?,
      itemLinkID: json['ItemLinkID'] as int?,
      grnNo: json['GRNNo'] as String?,
      totalROB: (json['TotalROB'] as num?)?.toDouble(),
      receivedQty: (json['ReceivedQty'] as num?)?.toDouble(),
      mDocReq: (json['MDocReq'] as bool?) == true ? 'Y' : 'N',
      sDocReq: (json['SDocReq'] as bool?) == true ? 'Y' : 'N',
      zeroDocReq: (json['ZeroDocReq'] as bool?) == true ? 'Y' : 'N',
      ihmMaterialCount: json['IhmMaterialCount'] as int?,
      poAttachment: json['POAttachment'] as String?,
      ihmAttachment: json['IHMAttachment'] as String?,
      inventoryDate: json['InventoryDate'] != null
          ? DateTime.tryParse(json['InventoryDate'])
          : null,
      expiryDate: json['ExpiryDate'] != null
          ? DateTime.tryParse(json['ExpiryDate'])
          : null,
      unitPrice: (json['UnitPrice'] as num?)?.toDouble(),
      newStock: (json['NewStock'] as num?)?.toDouble(),
      reconditionedStock: (json['ReconditionedStock'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'StorageLocationID': storageLocationID,
      'StorageLocation': storageLocation,
      'StorageLocationHierarchy': storageLocationHierarchy,
      'ReferenceID': referenceID,
      'ReferenceSubID': referenceSubID,
      'ReferenceTypeID': referenceTypeID,
      'ItemID': itemID,
      'ItemLinkID': itemLinkID,
      'GRNNo': grnNo,
      'TotalROB': totalROB,
      'ReceivedQty': receivedQty,
      'MDocReq': mDocReq == 'Y',
      'SDocReq': sDocReq == 'Y',
      'ZeroDocReq': zeroDocReq == 'Y',
      'IhmMaterialCount': ihmMaterialCount,
      'POAttachment': poAttachment,
      'IHMAttachment': ihmAttachment,
      'InventoryDate': inventoryDate?.toIso8601String(),
      'ExpiryDate': expiryDate?.toIso8601String(),
      'UnitPrice': unitPrice,
      'NewStock': newStock,
      'ReconditionedStock': reconditionedStock,
    };
  }

  /// Convert Model → Entity
  CommonStockLocationEntity toEntity() {
    return CommonStockLocationEntity(
      storageLocationID: storageLocationID ?? 0,
      storageLocation: storageLocation ?? '',
      storageLocationHierarchy: storageLocationHierarchy ?? '',
      referenceID: referenceID ?? 0,
      referenceSubID: referenceSubID ?? 0,
      referenceTypeID: referenceTypeID ?? 0,
      itemID: itemID ?? 0,
      itemLinkID: itemLinkID ?? 0,
      grnNo: grnNo,
      totalROB: totalROB ?? 0.0,
      receivedQty: receivedQty,
      mDocReq: mDocReq,
      sDocReq: sDocReq,
      zeroDocReq: zeroDocReq,
      ihmMaterialCount: ihmMaterialCount,
      poAttachment: poAttachment,
      ihmAttachment: ihmAttachment,
      inventoryDate: inventoryDate ?? DateTime.now(),
      expiryDate: expiryDate,
      unitPrice: unitPrice ?? 0.0,
      newStock: newStock ?? 0.0,
      reconditionedStock: reconditionedStock ?? 0.0,
    );
  }

  @override
  List<Object?> get props => [
    storageLocationID,
    storageLocation,
    storageLocationHierarchy,
    referenceID,
    referenceSubID,
    referenceTypeID,
    itemID,
    itemLinkID,
    grnNo,
    totalROB,
    receivedQty,
    mDocReq,
    sDocReq,
    zeroDocReq,
    ihmMaterialCount,
    poAttachment,
    ihmAttachment,
    inventoryDate,
    expiryDate,
    unitPrice,
    newStock,
    reconditionedStock,
  ];
}
