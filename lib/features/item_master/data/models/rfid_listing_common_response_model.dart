import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../domin/entities/item_master_rfid_view_entity_model.dart';

class RfidIdListResponseModel extends Equatable {
  const RfidIdListResponseModel({required this.rfidList});

  factory RfidIdListResponseModel.fromMap(Map<String, dynamic> map) {
    return RfidIdListResponseModel(
      rfidList: List<RfidIdModel>.from(
        (map['rfidIdList'] as List).map(
              (x) => RfidIdModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory RfidIdListResponseModel.fromJson(String source) =>
      RfidIdListResponseModel.fromMap(json.decode(source));

  final List<RfidIdModel> rfidList;

  Map<String, dynamic> toMap() {
    return {
      'rfidIdList': rfidList.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [rfidList];
}

class RfidIdModel extends Equatable {
  const RfidIdModel({
    required this.id,
    required this.itemId,
    required this.rfidId,
    required this.groupId,
    required this.itemCode,
  });

  factory RfidIdModel.fromTable(Map<String, dynamic> map) {
    return RfidIdModel(
      id: map['id'] as int,
      itemId: map['itemId'] as int,
      rfidId: map['rfidId'] as String,
      groupId: map['groupId'] as String,
      itemCode: map['itemCode'] as String,
    );
  }

  factory RfidIdModel.fromMap(Map<String, dynamic> map) {
    return RfidIdModel(
      id: map['id'] ??0,
      itemId: map['itemId'] ??0,
      rfidId: map['rfidId'] ??"",
      groupId: map['groupId'] ??"",
      itemCode: map['itemCode'] ??"",
    );
  }

  factory RfidIdModel.fromJson(String source) =>
      RfidIdModel.fromMap(json.decode(source));

  factory RfidIdModel.fromEntity({required ItemMasterRfidViewEntity entity,
  }) =>
      RfidIdModel(
        id: entity.id,
        itemId: entity.itemId,
        rfidId: entity.rfidId,
        groupId: entity.groupId,
        itemCode: entity.itemCode,
      );

  final int id;
  final int itemId;
  final String rfidId;
  final String groupId;
  final String itemCode;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itemId': itemId,
      'rfidId': rfidId,
      'groupId': groupId,
      'itemCode': itemCode,
    };
  }

  String toJson() => json.encode(toMap());

  ItemMasterRfidViewEntity toEntity() => ItemMasterRfidViewEntity(
    id: id,
    itemId: itemId,
    rfidId: rfidId,
    groupId: groupId,
    itemCode: itemCode,
  );

  RfidIdModel copyWith({
    int? id,
    int? itemId,
    String? rfidId,
    String? groupId,
    String? itemCode,
  }) {
    return RfidIdModel(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      rfidId: rfidId ?? this.rfidId,
      groupId: groupId ?? this.groupId,
      itemCode: itemCode ?? this.itemCode,
    );
  }

  @override
  List<Object?> get props => [
    id,
    itemId,
    rfidId,
    groupId,
    itemCode,
  ];

  @override
  bool? get stringify => true;
}
