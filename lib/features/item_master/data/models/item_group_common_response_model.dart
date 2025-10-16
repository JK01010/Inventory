import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../domin/entities/item_group_common_entity_model.dart';
import '../../domin/entities/serial_number_common_entity_model.dart';

class ItemGroupListResponseModel extends Equatable {
  const ItemGroupListResponseModel({required this.itemGroup});

  factory ItemGroupListResponseModel.fromMap(Map<String, dynamic> map) {
    return ItemGroupListResponseModel(
      itemGroup: List<ItemGroupModel>.from(
        (map['itemGroup'] as List).map(
              (x) => ItemGroupModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory ItemGroupListResponseModel.fromJson(String source) =>
      ItemGroupListResponseModel.fromMap(json.decode(source));

  final List<ItemGroupModel> itemGroup;

  Map<String, dynamic> toMap() {
    return {
      'itemGroup': itemGroup.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [itemGroup];
}

class ItemGroupModel extends Equatable {
  const ItemGroupModel({
    required this.itemCode,
    required this.rfid,
    required this.quantity,
    required this.canUpdateQuantity,
    required this.storageLocation,
  });

  factory ItemGroupModel.fromTable(Map<String, dynamic> map) {
    return ItemGroupModel(
      itemCode: map['itemCode'] as String,
      rfid: map['rfid'] as String,
      quantity: map['quantity'] as int,
      canUpdateQuantity: map['canUpdateQuantity'] as String,
      storageLocation: map['storageLocation'] as String,
    );
  }

  factory ItemGroupModel.fromMap(Map<String, dynamic> map) {
    return ItemGroupModel(
      itemCode: map['itemCode'] ?? '',
      rfid: map['rfid'] ?? '',
      quantity: map['quantity'] ?? 0,
      canUpdateQuantity: map['canUpdateQuantity'] ?? '',
      storageLocation: map['storageLocation'] ?? '',
    );
  }

  factory ItemGroupModel.fromJson(String source) =>
      ItemGroupModel.fromMap(json.decode(source));

  factory ItemGroupModel.fromEntity({required ItemGroupEntityModel entity}) =>
      ItemGroupModel(
        itemCode: entity.itemCode,
        rfid: entity.rfid,
        quantity: entity.quantity,
        canUpdateQuantity: entity.canUpdateQuantity,
        storageLocation: entity.storageLocation,
      );

  final String itemCode;
  final String rfid;
  final int quantity;
  final String canUpdateQuantity;
  final String storageLocation;

  Map<String, dynamic> toMap() {
    return {
      'itemCode': itemCode,
      'rfid': rfid,
      'quantity': quantity,
      'canUpdateQuantity': canUpdateQuantity,
      'storageLocation': storageLocation,
    };
  }

  String toJson() => json.encode(toMap());

  ItemGroupEntityModel toEntity() => ItemGroupEntityModel(
        itemCode: itemCode,
        rfid: rfid,
        quantity: quantity,
        canUpdateQuantity: canUpdateQuantity,
        storageLocation: storageLocation,
      );

  ItemGroupModel copyWith({
    int? id,
    int? itemId,
    int? poId,
    int? transactionId,
  }) {
    return ItemGroupModel(
      itemCode: itemCode,
      rfid: rfid,
      quantity: quantity,
      canUpdateQuantity: canUpdateQuantity,
      storageLocation: storageLocation,
    );
  }

  @override
  List<Object?> get props => [
        itemCode,
        rfid,
        quantity,
        canUpdateQuantity,
        storageLocation,
      ];

  @override
  bool? get stringify => true;
}