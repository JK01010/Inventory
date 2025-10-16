import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../domain/entities/bagging_confirmation_list_entity.dart';

class BaggingConfirmationListResponseModel extends Equatable {

  factory BaggingConfirmationListResponseModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return BaggingConfirmationListResponseModel(
      baggingConfirmationListModel: List<BaggingConfirmationListModel>.from(
        (map['baggingConfirmedListEntity'] as List<dynamic>)
            .map<BaggingConfirmationListModel>(
              (x) => BaggingConfirmationListModel.fromMap(
                x as Map<String, dynamic>,
              ),
            ),
      ),
    );
  }

  factory BaggingConfirmationListResponseModel.fromJson(String source) =>
      BaggingConfirmationListResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
  const BaggingConfirmationListResponseModel({
    required this.baggingConfirmationListModel,
  });

  final List<BaggingConfirmationListModel> baggingConfirmationListModel;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'baggingConfirmedListEntity':
          baggingConfirmationListModel.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [baggingConfirmationListModel];

  @override
  bool? get stringify => true;
}

class BaggingConfirmationListModel extends Equatable {

  factory BaggingConfirmationListModel.fromEntity(
    BaggingConfirmationListEntity entity,
  ) {
    return BaggingConfirmationListModel(
      id: entity.id,
      poId: entity.poId,
      poCode: entity.poCode,
      transactionId: entity.transactionId,
      grnNo: entity.grnNo,
      status: entity.status,
      syncStatus: entity.syncStatus,
      syncMessage: entity.syncMessage,
      storageLocationCount: entity.storageLocationCount,
      storageLocationId: entity.storageLocationId,
    );
  }

  factory BaggingConfirmationListModel.fromMap(Map<String, dynamic> map) {
    return BaggingConfirmationListModel(
      id: map['id'] as int,
      poId: map['poId'] as String?,
      poCode: map['poCode'] as String?,
      transactionId: map['transactionId'] as String?,
      grnNo: map['grnNo'] as String?,
      status: map['status'] as String?,
      syncStatus: map['syncStatus'] as String?,
      syncMessage: map['syncMessage'] as String?,
      storageLocationCount: map['storageLocationCount'] as int?,
      storageLocationId: map['storageLocationId'] as int?,
    );
  }

  factory BaggingConfirmationListModel.fromJson(String source) =>
      BaggingConfirmationListModel.fromMap(json.decode(source));
  BaggingConfirmationListModel({
    this.id,
    this.poId,
    this.poCode,
    this.transactionId,
    this.grnNo,
    this.status,
    this.syncStatus,
    this.syncMessage,
    this.storageLocationCount,
    this.storageLocationId,
  });

  final int? id;
  final String? poId;
  final String? poCode;
  final String? transactionId;
  final String? grnNo;
  final String? status;
  final String? syncStatus;
  final String? syncMessage;
  final int? storageLocationCount;
  final int? storageLocationId;

  @override
  bool? get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'poId': poId,
      'poCode': poCode,
      'transactionId': transactionId,
      'grnNo': grnNo,
      'status': status,
      'syncStatus': syncStatus,
      'syncMessage': syncMessage,
      'storageLocation': storageLocationCount,
      'storageLocationId': storageLocationId,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [
    id,
    poId,
    poCode,
    transactionId,
    grnNo,
    status,
    syncStatus,
    syncMessage,
    storageLocationCount,
    storageLocationId,
  ];

  BaggingConfirmationListEntity toEntity() => BaggingConfirmationListEntity(
    id: id ?? 0,
    poId: poId ?? '',
    poCode: poCode ?? '',
    transactionId: transactionId ?? '',
    grnNo: grnNo ?? '',
    status: status ?? '',
    syncStatus: syncStatus ?? '',
    syncMessage: syncMessage ?? '',
    storageLocationCount: storageLocationCount ?? 0,
    storageLocationId: storageLocationId ?? 0,
  );
}
