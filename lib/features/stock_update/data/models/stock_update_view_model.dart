import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domin/entities/stock_update_view_entity_model.dart';

class StockUpdateViewResponseModel extends Equatable {

  const StockUpdateViewResponseModel({required this.stockUpdateViewModel});

  final List<StockUpdateViewModel> stockUpdateViewModel;

  @override
  List<Object?> get props => [stockUpdateViewModel];

}

class StockUpdateViewModel extends Equatable {
  const StockUpdateViewModel({
    required this.itemName,
    required this.quantity,
    required this.articleNumber,
    required this.remarks,
    required this.defaultStorageLocation,
    required this.syncStatus
  });

  /// fromMap
  factory StockUpdateViewModel.fromMap(Map<String, dynamic> map) {
    return StockUpdateViewModel(
        itemName: map['itemName'] as String,
        quantity: map['quantity'] as String,
        articleNumber: map['articleNumber'] as String,
        remarks: map['remarks'] as String,
        defaultStorageLocation: map['defaultStorageLocation'] as String,
        syncStatus: map['syncStatus'] as String
    );
  }



  /// fromJson
/*  factory StockUpdateViewModel.fromJson(String source) =>
      StockUpdateViewModel.fromMap(json.decode(source) as Map<String, dynamic>);*/

  factory StockUpdateViewModel.fromJson(String source) =>
      StockUpdateViewModel.fromMap(json.decode(source));

  factory StockUpdateViewModel.fromEntity({required StockUpdateViewEntity entity,
  }) =>
      StockUpdateViewModel(
          itemName: entity.itemName,
          quantity: entity.quantity,
          articleNumber: entity.articleNumber,
          remarks: entity.remarks,
          defaultStorageLocation: entity.defaultStorageLocation,
          syncStatus: entity.syncStatus
      );


  final String itemName;
  final String quantity;
  final String articleNumber;
  final String remarks;
  final String defaultStorageLocation;
  final String syncStatus;

  /// toMap
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemName': itemName,
      'quantity': quantity,
      'articleNumber': articleNumber,
      'remarks': remarks,
      'defaultStorageLocation': defaultStorageLocation,
      'syncStatus':syncStatus
    };
  }

  /// toJson
  String toJson() => json.encode(toMap());

  StockUpdateViewEntity toEntity() => StockUpdateViewEntity(
      itemName: itemName,
      quantity: quantity,
      articleNumber: articleNumber,
      remarks: remarks,
      defaultStorageLocation: defaultStorageLocation,
      syncStatus: syncStatus
  );

  StockUpdateViewModel copyWith({
    String? itemName,
    String? quantity,
    String? articleNumber,
    String? remarks,
    String? defaultStorageLocation,
    String? syncStatus
  }){
    return StockUpdateViewModel(
      itemName: itemName ?? this.itemName,
      articleNumber: articleNumber ?? this.articleNumber,
      quantity: quantity ?? this.quantity,
      remarks:  remarks ?? this.remarks,
      defaultStorageLocation: defaultStorageLocation ??this.defaultStorageLocation,
      syncStatus : syncStatus ?? this.syncStatus
    );
  }

  @override
  List<Object?> get props =>
      [
        itemName,
        quantity,
        articleNumber,
        defaultStorageLocation,
        remarks,
        syncStatus
      ];

  @override
  bool get stringify => true;
}