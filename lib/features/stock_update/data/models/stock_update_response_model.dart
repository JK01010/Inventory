import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../../domin/entities/srock_update_entity_model.dart';
import '../../domin/entities/stock_update_view_entity_model.dart';

class StockUpdateResponseModel extends Equatable {
  const StockUpdateResponseModel({
    required this.stockUpdates,
  });

  /// fromMap
  factory StockUpdateResponseModel.fromMap(Map<String, dynamic> map) {
    return StockUpdateResponseModel(
      stockUpdates: List<StockUpdateModel>.from(
        (map['stockUpdateList'] as List).map(
              (x) => StockUpdateModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  /// fromJson
  factory StockUpdateResponseModel.fromJson(String source) =>
      StockUpdateResponseModel.fromMap(json.decode(source));

  final List<StockUpdateModel> stockUpdates;

  /// toMap
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stockUpdateList': stockUpdates.map((x) => x.toMap()).toList(),
    };
  }

  /// toJson
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [stockUpdates];
}

class StockUpdateModel extends Equatable {
  const StockUpdateModel({
    required this.id,
    required this.itemId,
    required this.quantity,
    required this.storageLocationId,
    required this.remarks,
    required this.modifiedOn,
    required this.syncStatus,
    required this.syncMerge,
    required this.transactionId,
    required this.totalRob,
    this.adjustNewStock,
    this.adjustReconditionStock,
  });

  /// fromMap
  factory StockUpdateModel.fromMap(Map<String, dynamic> map) {
    return StockUpdateModel(
      id: map['id'] as String,
      itemId: map['itemId'] as int,
      quantity: map['quantity'] as int,
      storageLocationId: map['storageLocationId'] as int,
      remarks: map['remarks'] as String,
      modifiedOn: map['modifiedOn'] as String,
      syncStatus: map['syncStatus'] as String,
      syncMerge: map['syncMerge'] as String,
      transactionId: map['transactionId'] as String,
      totalRob: map['totalRob'] as int,
      adjustNewStock: map['adjustNewStock'] as double?,
      adjustReconditionStock: map['adjustReconditionStock'] as double?,
    );
  }

  /// fromJson
  factory StockUpdateModel.fromJson(String source) =>
      StockUpdateModel.fromMap(json.decode(source) as Map<String, dynamic>);


  factory StockUpdateModel.fromEntity({required StockUpdateEntity entity,
  }) =>
      StockUpdateModel(
          id: entity.id,
          itemId: entity.itemId,
          quantity: entity.quantity,
          storageLocationId: entity.storageLocationId,
          remarks: entity.remarks,
          modifiedOn: entity.modifiedOn,
          syncStatus: entity.syncStatus,
          syncMerge: entity.syncMerge,
          transactionId: entity.transactionId,
          totalRob: entity.totalRob,
          adjustNewStock: entity.adjNewStock,
          adjustReconditionStock: entity.adjReconditionedStock
      );

  final String id;
  final int itemId;
  final int quantity;
  final int storageLocationId;
  final String remarks;
  final String modifiedOn;
  final String syncStatus;
  final String syncMerge;
  final String transactionId;
  final int totalRob;
  final double? adjustNewStock;
  final double? adjustReconditionStock;


  /// toMap
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'itemId': itemId,
      'quantity': quantity,
      'storageLocationId': storageLocationId,
      'remarks': remarks,
      'modifiedOn': modifiedOn,
      'syncStatus': syncStatus,
      'syncMerge': syncMerge,
      'transactionId': transactionId,
      'totalRob': totalRob,
      'adjustNewStock': adjustNewStock,
      'adjustReconditionStock': adjustReconditionStock,
    };
  }

  /// toJson
  String toJson() => json.encode(toMap());

  /// copyWith
  StockUpdateModel copyWith({
    String? id,
    int? itemId,
    int? quantity,
    int? storageLocationId,
    String? remarks,
    String? modifiedOn,
    String? syncStatus,
    String? syncMerge,
    String? transactionId,
    int? totalRob,
    double? adjustNewStock,
    double? adjustReconditionStock,
  }) {
    return StockUpdateModel(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      quantity: quantity ?? this.quantity,
      storageLocationId: storageLocationId ?? this.storageLocationId,
      remarks: remarks ?? this.remarks,
      modifiedOn: modifiedOn ?? this.modifiedOn,
      syncStatus: syncStatus ?? this.syncStatus,
      syncMerge: syncMerge ?? this.syncMerge,
      transactionId: transactionId ?? this.transactionId,
      totalRob: totalRob ?? this.totalRob,
      adjustNewStock: adjustNewStock ?? this.adjustNewStock,
      adjustReconditionStock: adjustReconditionStock ?? this.adjustReconditionStock,
    );
  }

  @override
  List<Object?> get props => [
    id,
    itemId,
    quantity,
    storageLocationId,
    remarks,
    modifiedOn,
    syncStatus,
    syncMerge,
    transactionId,
    totalRob,
    adjustNewStock,
    adjustReconditionStock,
  ];

  @override
  bool? get stringify => true;
}
