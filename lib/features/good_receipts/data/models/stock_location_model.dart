import 'package:equatable/equatable.dart';

import '../../domain/entities/stock_location_entity.dart';

class StockLocationResponseModel extends Equatable {
  StockLocationResponseModel({this.stockLocationModelList});

  factory StockLocationResponseModel.fromJson(Map<String, dynamic> json) {
    return StockLocationResponseModel(
      stockLocationModelList:
          (json['stockLocations'] as List<dynamic>?)
              ?.map((e) => StockLocationModel.fromMap(e))
              .toList(),
    );
  }

  List<StockLocationModel>? stockLocationModelList;

  Map<String, dynamic> toJson() {
    return {
      'stockLocations': stockLocationModelList?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [stockLocationModelList];
}

class StockLocationModel extends Equatable {
  const StockLocationModel({
    required this.id,
    required this.itemId,
    required this.storageLocationId,
    required this.quantity,
    required this.tags,
  });

  factory StockLocationModel.fromMap(Map<String, dynamic> json) {
    return StockLocationModel(
      id: json['id'] as int?,
      itemId: json['itemId'] as int?,
      storageLocationId: json['storageLocationId'] as int?,
      quantity: json['quantity'] as int?,
      tags: json['tags'] as String?,
    );
  }

  factory StockLocationModel.fromEntity(
    StockLocationEntity stockLocationEntity,
  ) {
    return StockLocationModel(
      id: stockLocationEntity.storageLocationId,
      itemId: stockLocationEntity.itemId,
      storageLocationId: stockLocationEntity.storageLocationId,
      quantity: stockLocationEntity.quantity,
      tags: stockLocationEntity.tags,
    );
  }

  final int? id;
  final int? itemId;
  final int? storageLocationId;
  final int? quantity;
  final String? tags;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'itemId': itemId,
      'storageLocationId': storageLocationId,
      'quantity': quantity,
      'tags': tags,
    };
  }

  StockLocationEntity toEntity() {
    return StockLocationEntity(
      id: id ?? 0,
      itemId: itemId ?? 0,
      storageLocationId: storageLocationId ?? 0,
      quantity: quantity ?? 0,
      tags: tags ?? '',
    );
  }

  static List<StockLocationModel> fromEntityList(
    List<StockLocationEntity> stockLocationEntityList,
  ) {
    List<StockLocationModel> stockLocationModelList = [];
    for (var entity in stockLocationEntityList) {
      stockLocationModelList.add(StockLocationModel.fromEntity(entity));
    }
    return stockLocationModelList;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itemId': itemId,
      'storageLocationId': storageLocationId,
      'quantity': quantity,
      'tags': tags,
    };
  }

  @override
  List<Object?> get props => [id, itemId, storageLocationId, quantity, tags];
}
