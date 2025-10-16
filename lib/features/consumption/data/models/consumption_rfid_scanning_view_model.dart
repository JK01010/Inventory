import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../../domin/entities/consumption_rfid_scanning_view_entity_model.dart';

class ConsumptionRfidScanningViewListingModel extends Equatable {
  const ConsumptionRfidScanningViewListingModel({
    required this.consumptionRfidScanningViewModel,
  });

  final List<ConsumptionRfidScanningViewModel> consumptionRfidScanningViewModel;

  @override
  List<Object?> get props => [consumptionRfidScanningViewModel];
}

class ConsumptionRfidScanningViewModel extends Equatable {
  const ConsumptionRfidScanningViewModel({
    required this.itemId,
    required this.itemName,
    required this.itemCode,
    required this.rfidId,
    required this.rob,
    required this.articleNo,
    required this.storageLocation,
    required this.installedOnLocation,
    required this.isSelected,
    required this.defaultStorageLocationId,
    required this.equipmentFlag,
    required this.ihm,
    required this.mdRequired,
    required this.sDocRequired,
    required this.zeroDeclaration,
    required this.newStock,
    required this.reconditionStock
  });

  /// fromJson
  factory ConsumptionRfidScanningViewModel.fromJson(String source) =>
      ConsumptionRfidScanningViewModel.fromMap(json.decode(source));

  /// fromMap
  factory ConsumptionRfidScanningViewModel.fromMap(Map<String, dynamic> map) {
    return ConsumptionRfidScanningViewModel(
      itemId: map['itemId'] as int? ?? 0,
      itemName: map['itemName'] as String? ?? '',
      itemCode: map['itemCode'] as String? ?? '',
      rfidId: map['rfidId'] as String? ?? '',
      rob: map['rob'] as int? ?? 0,
      articleNo: map['articleNo'] as String? ?? '',
      storageLocation: map['storageLocation'] as String? ?? '',
      installedOnLocation: map['installedOnLocation'] as String? ?? '',
      isSelected: map['isSelected'] ?? false,
      defaultStorageLocationId: map['defaultStorageLocationId'] as int? ?? 0,
      equipmentFlag: map['equipmentFlag'] as String? ?? '',
      ihm: map['ihm'] as int? ?? 0,
      mdRequired: map['mdRequired'] as int? ?? 0,
      sDocRequired: map['sDocRequired'] as int? ?? 0,
      zeroDeclaration: map['zeroDeclaration'] as int? ?? 0,
      newStock: map['newStock'] as int? ?? 0,
      reconditionStock: map['reconditionStock'] as int? ?? 0,
    );
  }

  /// Fields
  final int itemId;
  final String itemName;
  final String itemCode;
  final String rfidId;
  final int rob;
  final String articleNo;
  final String storageLocation;
  final String installedOnLocation;
  final bool? isSelected;

  final int defaultStorageLocationId;
  final String equipmentFlag;
  final int ihm;
  final int mdRequired;
  final int sDocRequired;
  final int zeroDeclaration;
  final int newStock;
  final int reconditionStock;

  /// toMap
  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'itemCode': itemCode,
      'rfidId': rfidId,
      'rob': rob,
      'articleNo': articleNo,
      'storageLocation': storageLocation,
      'installedOnLocation': installedOnLocation,
      'isSelected': isSelected,
      'defaultStorageLocationId': defaultStorageLocationId,
      'equipmentFlag': equipmentFlag,
      'ihm': ihm,
      'mdRequired': mdRequired,
      'sDocRequired': sDocRequired,
      'zeroDeclaration': zeroDeclaration,
      'newStock': newStock,
      'reconditionStock': reconditionStock,
    };
  }

  /// toJson
  String toJson() => json.encode(toMap());

  ///toEntity
  ConsumptionRfidListingViewEntity toEntity() =>
      ConsumptionRfidListingViewEntity(
        itemId: itemId,
        itemName: itemName,
        itemCode: itemCode,
        rfidId: rfidId,
        rob: rob,
        articleNo: articleNo,
        storageLocation: storageLocation,
        installedOnLocation: installedOnLocation,
        isSelected: isSelected,
        defaultStorageLocationId: defaultStorageLocationId,
        equipmentFlag: equipmentFlag,
        ihm: ihm,
        mdRequired: mdRequired,
        sDocRequired: sDocRequired,
        zeroDeclaration: zeroDeclaration,
        newStock: newStock,
        reconditionStock: reconditionStock,
      );

  /// copyWith
  ConsumptionRfidScanningViewModel copyWith({
    int? itemId,
    String? itemName,
    String? itemCode,
    String? rfidId,
    int? rob,
    String? articleNo,
    String? storageLocation,
    String? installedOnLocation,
    bool? isSelected,
    int? defaultStorageLocationId,
    String? equipmentFlag,
    int? ihm,
    int? mdRequired,
    int? sDocRequired,
    int? zeroDeclaration,
    int? newStock,
    int? reconditionStock
  }) {
    return ConsumptionRfidScanningViewModel(
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      itemCode: itemCode ?? this.itemCode,
      rfidId: rfidId ?? this.rfidId,
      rob: rob ?? this.rob,
      articleNo: articleNo ?? this.articleNo,
      storageLocation: storageLocation ?? this.storageLocation,
      installedOnLocation: installedOnLocation ?? this.installedOnLocation,
      isSelected: isSelected ?? this.isSelected ?? false,
      defaultStorageLocationId:
          defaultStorageLocationId ?? this.defaultStorageLocationId,
      equipmentFlag: equipmentFlag ?? this.equipmentFlag,
      ihm: ihm ?? this.ihm,
      mdRequired: mdRequired ?? this.mdRequired,
      sDocRequired: sDocRequired ?? this.sDocRequired,
      zeroDeclaration: zeroDeclaration ?? this.zeroDeclaration,
      newStock: newStock ?? this.newStock,
      reconditionStock: reconditionStock ?? this.reconditionStock,
    );
  }

  @override
  List<Object?> get props => [
    itemId,
    itemName,
    itemCode,
    rfidId,
    rob,
    articleNo,
    storageLocation,
    installedOnLocation,
    isSelected,
    defaultStorageLocationId,
    equipmentFlag,
    ihm,
    mdRequired,
    sDocRequired,
    zeroDeclaration,
  ];

  @override
  bool get stringify => true;
}
