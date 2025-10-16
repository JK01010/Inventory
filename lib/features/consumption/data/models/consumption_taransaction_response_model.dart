import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../../domin/entities/choose_items_list_entity_model_consumption.dart';
import '../../domin/entities/consumption_transaction_entity_model.dart';


class ConsumptionTrnResponseModel extends Equatable {
  const ConsumptionTrnResponseModel({
    required this.consumptionTrn,
  });

  /// fromMap
  factory ConsumptionTrnResponseModel.fromMap(Map<String, dynamic> map) {
    return ConsumptionTrnResponseModel(
      consumptionTrn: List<ConsumptionTransactionModel>.from(
        (map['consumptionTransactionEntity'] as List).map(
              (x) => ConsumptionTransactionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  /// fromJson
  factory ConsumptionTrnResponseModel.fromJson(String source) =>
      ConsumptionTrnResponseModel.fromMap(json.decode(source));

  final List<ConsumptionTransactionModel> consumptionTrn;

  /// toMap
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'consumptionTransactionEntity': consumptionTrn.map((x) => x.toMap()).toList(),
    };
  }

  /// toJson
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [consumptionTrn];
}

class ConsumptionTransactionModel extends Equatable {
  const ConsumptionTransactionModel({
    required this.id,
    required this.itemId,
    required this.quantity,
    required this.storageLocationId,
    required this.remarks,
    required this.modifiedOn,
    required this.syncStatus,
    required this.syncMerge,
    required this.transactionId,
    required this.tags,
    required this.locationId,
    required this.equipmentId,
    required this.totalRob,
    required this.totalNewStock,
    required this.totalReconditionStock,
    required this.currentRob,
    required this.newStock,
    required this.reconditionStock,

  });

  /// fromMap
  factory ConsumptionTransactionModel.fromMap(Map<String, dynamic> map) {
    return ConsumptionTransactionModel(
      id: map['id'] as String? ?? '',
      itemId: map['itemId'] as int? ?? 0,
      quantity: map['quantity'] as int? ?? 0,
      storageLocationId: map['storageLocationId'] as int? ?? 0,
      remarks: map['remarks'] as String? ?? '',
      modifiedOn: map['modifiedOn'] as String? ?? '',
      syncStatus: map['syncStatus'] as String? ?? '',
      syncMerge: map['syncMerge'] as String? ?? '',
      transactionId: map['transactionId'] as String? ?? '',
      tags: map['tags'] as String? ?? '',
      locationId: map['locationId'] as int? ?? 0,
      equipmentId: map['equipmentId'] as int? ?? 0,
      totalRob: map['totalRob'] as int? ?? 0,
      totalNewStock: map['totalNewStock'] as int? ?? 0,
      totalReconditionStock: map['totalReconditionStock'] as int? ?? 0,
      currentRob: map['currentRob'] as int? ?? 0,
      newStock: map['newStock'] as int? ?? 0,
      reconditionStock: map['reconditionStock'] as int? ?? 0,
    );
  }

  /// fromJson
  factory ConsumptionTransactionModel.fromJson(String source) =>
      ConsumptionTransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);


  factory ConsumptionTransactionModel.fromEntity({required ConsumptionTransactionEntityModel entity,
  }) =>
      ConsumptionTransactionModel(
          id: entity.id,
          itemId: entity.itemId,
          quantity: entity.quantity,
          storageLocationId: entity.storageLocationId,
          remarks: entity.remarks,
          modifiedOn: entity.modifiedOn,
          syncStatus: entity.syncStatus,
          syncMerge: entity.syncMerge,
          transactionId: entity.transactionId,
          tags: entity.tags,
          locationId: entity.locationId , // Assuming default value if null
          equipmentId: entity.equipmentId , // Assuming default value if null
          totalRob: entity.totalRob,
          totalNewStock: entity.totalNewStock,
          totalReconditionStock: entity.totalReconditionStock,
          currentRob: entity.currentRob,
          newStock: entity.newStock,
          reconditionStock: entity.reconditionStock,

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
  final String tags;
  final int locationId;
  final int equipmentId;
  final int totalRob;
  final int totalNewStock;
  final int totalReconditionStock;
  final int currentRob;
  final int newStock;
  final int reconditionStock;

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
      'tags': tags,
      'locationId': locationId,
      'equipmentId': equipmentId,
      'totalRob': totalRob,
      'newStock': newStock,
      'reconditionStock': reconditionStock,
      'currentRob': currentRob,
      'totalNewStock': totalNewStock,
      'totalReconditionStock': totalReconditionStock,
    };
  }

  /// toJson
  String toJson() => json.encode(toMap());

  ///toEntity
  ConsumptionTransactionEntityModel toEntity() => ConsumptionTransactionEntityModel(
      id: id,
      itemId:itemId,
      quantity: quantity,
      storageLocationId: storageLocationId,
      remarks: remarks,
      modifiedOn: modifiedOn,
      syncStatus: syncStatus,
      syncMerge: syncMerge,
      transactionId: transactionId,
      tags: tags,
      locationId: locationId,
      equipmentId: equipmentId,
      totalRob: totalRob,
      newStock:newStock,
      reconditionStock:reconditionStock,
      currentRob: currentRob,
      totalNewStock: totalNewStock,
      totalReconditionStock: totalReconditionStock,
  );

  /// copyWith
  ConsumptionTransactionModel copyWith({
    String? id,
    int? itemId,
    int? quantity,
    int? storageLocationId,
    String? remarks,
    String? modifiedOn,
    String? syncStatus,
    String? syncMerge,
    String? transactionId,
    String? tags,
    int? locationId,
    int? equipmentId,
    int? totalRob,
    int? newStock,
    int? reconditionStock,
    int? currentRob,
    int? totalNewStock,
    int? totalReconditionStock,
  }) {
    return ConsumptionTransactionModel(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      quantity: quantity ?? this.quantity,
      storageLocationId: storageLocationId ?? this.storageLocationId,
      remarks: remarks ?? this.remarks,
      modifiedOn: modifiedOn ?? this.modifiedOn,
      syncStatus: syncStatus ?? this.syncStatus,
      syncMerge: syncMerge ?? this.syncMerge,
      transactionId: transactionId ?? this.transactionId,
      tags: tags ?? this.tags,
      locationId: locationId ?? this.locationId,
      equipmentId: equipmentId ?? this.equipmentId,
      totalRob: totalRob ?? this.totalRob,
      newStock: newStock ?? this.newStock,
      reconditionStock: reconditionStock ?? this.reconditionStock,
      currentRob: currentRob ?? this.currentRob,
      totalNewStock: totalNewStock ?? this.totalNewStock,
      totalReconditionStock: totalReconditionStock ?? this.totalReconditionStock
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
    tags,
    locationId,
    equipmentId,
    totalRob,
    newStock,
    reconditionStock,
    currentRob,
    totalNewStock,
    totalReconditionStock
  ];

  @override
  bool? get stringify => true;
}
