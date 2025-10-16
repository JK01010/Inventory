import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../domin/entities/serial_number_common_entity_model.dart';

class SerialNumberListResponseModel extends Equatable {
  const SerialNumberListResponseModel({required this.serialNumberList});

  factory SerialNumberListResponseModel.fromMap(Map<String, dynamic> map) {
    return SerialNumberListResponseModel(
      serialNumberList: List<SerialNumberModel>.from(
        (map['serialNumberList'] as List).map(
              (x) => SerialNumberModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory SerialNumberListResponseModel.fromJson(String source) =>
      SerialNumberListResponseModel.fromMap(json.decode(source));

  final List<SerialNumberModel> serialNumberList;

  Map<String, dynamic> toMap() {
    return {
      'serialNumberList': serialNumberList.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [serialNumberList];
}

class SerialNumberModel extends Equatable {
  const SerialNumberModel({
    required this.id,
    required this.itemId,
    required this.poId,
    required this.transactionId,
  });

  factory SerialNumberModel.fromTable(Map<String, dynamic> map) {
    return SerialNumberModel(
      id: map['id'] as int,
      itemId: map['itemId'] as int,
      poId: map['poId'] as int,
      transactionId: map['transactionId'] as int,
    );
  }

  factory SerialNumberModel.fromMap(Map<String, dynamic> map) {
    return SerialNumberModel(
      id: map['id'] as int,
      itemId: map['itemId'] as int,
      poId: map['poId'] as int,
      transactionId: map['transactionId'] as int,
    );
  }

  factory SerialNumberModel.fromJson(String source) =>
      SerialNumberModel.fromMap(json.decode(source));

  factory SerialNumberModel.fromEntity({required SerialNumberEntityModel entity,
  }) =>
      SerialNumberModel(
          id: entity.id,
          itemId: entity.itemId,
          poId: entity.poId,
          transactionId: entity.transactionId
      );

  final int id;
  final int itemId;
  final int poId;
  final int transactionId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itemId': itemId,
      'poId': poId,
      'transactionId': transactionId,
    };
  }

  String toJson() => json.encode(toMap());

  SerialNumberEntityModel toEntity() => SerialNumberEntityModel(
    id: id,
    itemId: itemId,
    poId: poId,
    transactionId: transactionId,
  );

  SerialNumberModel copyWith({
    int? id,
    int? itemId,
    int? poId,
    int? transactionId,
  }) {
    return SerialNumberModel(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      poId: poId ?? this.poId,
      transactionId: transactionId ?? this.transactionId,
    );
  }

  @override
  List<Object?> get props => [
    id,
    itemId,
    poId,
    transactionId
  ];

  @override
  bool? get stringify => true;
}
