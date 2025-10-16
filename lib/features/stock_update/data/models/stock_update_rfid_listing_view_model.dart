import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../domin/entities/stock_update_rfid_scanning_view_entity_model.dart';

class StockUpdateRfidListingViewResponseModel extends Equatable {
  const StockUpdateRfidListingViewResponseModel({
    required this.stockUpdateRfidListingViewModel,
  });

  final List<StockUpdateRfidListingViewModel> stockUpdateRfidListingViewModel;

  @override
  List<Object?> get props => [stockUpdateRfidListingViewModel];
}

class StockUpdateRfidListingViewModel extends Equatable {
  const StockUpdateRfidListingViewModel({
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
    required this.ihm,
    required this.mdRequired,
    required this.sDocRequired,
    required this.zeroDeclaration,
    required this.newStock,
    required this.reconditionStock,
  });

  /// fromJson
  factory StockUpdateRfidListingViewModel.fromJson(String source) =>
      StockUpdateRfidListingViewModel.fromMap(json.decode(source));

  /// fromMap
  factory StockUpdateRfidListingViewModel.fromMap(Map<String, dynamic> map) {
    return StockUpdateRfidListingViewModel(
      itemId: map['itemId'] as int,
      itemName: map['itemName'] as String,
      itemCode: map['itemCode'] as String,
      rfidId: map['rfidId'] as String,
      rob: map['rob'] as int,
      articleNo: map['articleNo'] as String,
      storageLocation: map['storageLocation'] as String,
      installedOnLocation: map['installedOnLocation'] as String,
      isSelected: map['isSelected'] ?? false,
      defaultStorageLocationId: map['defaultStorageLocationId'] as int,
      ihm: map['ihm'] as int,
      mdRequired: map['mdRequired'] as int,
      sDocRequired: map['sDocRequired'] as int,
      zeroDeclaration: map['zeroDeclaration'] as int,
      newStock: map['newStock'] ?? 0,
      reconditionStock: map['reconditionStock'] ?? 0,
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
  StockUpdateRfidListingViewEntity toEntity() =>
      StockUpdateRfidListingViewEntity(
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
        ihm: ihm,
        mdRequired: mdRequired,
        sDocRequired: sDocRequired,
        zeroDeclaration: zeroDeclaration,
        newStock: newStock,
        reconditionStock: reconditionStock,
      );

  /// copyWith
  StockUpdateRfidListingViewModel copyWith({
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
    int? ihm,
    int? mdRequired,
    int? sDocRequired,
    int? zeroDeclaration,
    int? newStock,
    int? reconditionStock,
  }) {
    return StockUpdateRfidListingViewModel(
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
    ihm,
    mdRequired,
    sDocRequired,
    zeroDeclaration,
    newStock,
    reconditionStock
  ];

  @override
  bool get stringify => true;
}
