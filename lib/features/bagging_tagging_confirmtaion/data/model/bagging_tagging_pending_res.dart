// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/pending_list_model.dart';

class BaggingTaggingPendingResponseModel extends Equatable {
  const BaggingTaggingPendingResponseModel({required this.items});

  final List<BaggingTaggingPendingModel> items;

  Map<String, dynamic> toMap() {
    return {'baggingTaggingList': items.map((x) => x.toMap()).toList()};
  }

  factory BaggingTaggingPendingResponseModel.fromMap(Map<String, dynamic> map) {
    return BaggingTaggingPendingResponseModel(
      items: List<BaggingTaggingPendingModel>.from(
        (map['baggingTaggingList'] as List<dynamic>).map(
          (x) => BaggingTaggingPendingModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory BaggingTaggingPendingResponseModel.fromJson(String source) =>
      BaggingTaggingPendingResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  List<Object?> get props => [items];

  @override
  bool? get stringify => true;
}

class BaggingTaggingPendingModel extends Equatable {
  const BaggingTaggingPendingModel({
    this.id,
    this.title,
    this.poId,
    this.poCode,
    this.portId,
    this.poRemark,
    this.transactionMobRefId,
    this.items,
    this.grnNo,
    this.grnRefNo,
    this.poNo,
    this.mobRefId,
    this.createdOnDate,
    this.modifiedOnDate,
    this.modifiedOn,
    this.grnDate,
    this.isFull,
    this.deliveryRef,
    this.isBaggingComplete,
    this.tag,
    this.syncStatus,
    this.syncMessage,
    this.storageLocation,
    this.eta,
    this.categoryId,
    this.categoryName,
    this.receivedDate,
    this.status,
    this.deliveryStatusCode,
    this.countryCode,
    this.countryName,
    this.packetSize,
    this.weight,
    this.actualVolume,
    this.partial,
  });

  final int? id;
  final String? title;
  final String? poId;
  final String? poCode;
  final int? portId;
  final String? poRemark;
  final String? transactionMobRefId;
  final String? items;
  final String? grnNo;
  final String? grnRefNo;
  final String? poNo;
  final int? mobRefId;
  final String? createdOnDate;
  final String? modifiedOnDate;
  final String? modifiedOn;
  final String? grnDate;
  final String? isFull;
  final String? deliveryRef;
  final String? isBaggingComplete;
  final String? tag;
  final String? syncStatus;
  final String? syncMessage;
  final String? storageLocation;
  final String? eta;
  final int? categoryId;
  final String? categoryName;
  final String? receivedDate;
  final String? status;
  final String? deliveryStatusCode;
  final String? countryCode;
  final String? countryName;
  final String? packetSize;
  final String? weight;
  final String? actualVolume;
  final String? partial;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'poId': poId,
      'poCode': poCode,
      'portId': portId,
      'poRemark': poRemark,
      'transactionMobRefId': transactionMobRefId,
      'items': items,
      'grnNo': grnNo,
      'grnRefNo': grnRefNo,
      'poNo': poNo,
      'mobRefId': mobRefId,
      'createdOnDate': createdOnDate,
      'modifiedOnDate': modifiedOnDate,
      'modifiedOn': modifiedOn,
      'grnDate': grnDate,
      'isFull': isFull,
      'deliveryRef': deliveryRef,
      'isBaggingComplete': isBaggingComplete,
      'tag': tag,
      'syncStatus': syncStatus,
      'syncMessage': syncMessage,
      'storageLocation': storageLocation,
      'eta': eta,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'receivedDate': receivedDate,
      'status': status,
      'deliveryStatusCode': deliveryStatusCode,
      'countryCode': countryCode,
      'countryName': countryName,
      'packetSize': packetSize,
      'weight': weight,
      'actualVolume': actualVolume,
      'partial': partial,
    };
  }

  factory BaggingTaggingPendingModel.fromMap(Map<String, dynamic> map) {
    return BaggingTaggingPendingModel(
      id: map['id'],
      title: map['title']?.toString(),
      poId: map['poId'] as String?,
      // poId: map['poId'] is String ? map['poId'] : int.tryParse(map['poId']?.toString() ?? ''),
      poCode: map['poCode']?.toString(),
      portId: map['portId'] is int ? map['portId'] : int.tryParse(map['portId']?.toString() ?? ''),
      poRemark: map['poRemark']?.toString(),
      transactionMobRefId: map['transactionMobRefId']?.toString(),
      items: map['items']?.toString(),
      grnNo: map['grnNo']?.toString(),
      grnRefNo: map['grnRefNo']?.toString(),
      poNo: map['poNo']?.toString(),
      mobRefId: map['mobRefId'] is int ? map['mobRefId'] : int.tryParse(map['mobRefId']?.toString() ?? ''),
      createdOnDate: map['createdOnDate']?.toString(),
      modifiedOnDate: map['modifiedOnDate']?.toString(),
      modifiedOn: map['modifiedOn']?.toString(),
      grnDate: map['grnDate']?.toString(),
      isFull: map['isFull']?.toString(),
      deliveryRef: map['deliveryRef']?.toString(),
      isBaggingComplete: map['isBaggingComplete']?.toString(),
      tag: map['tag']?.toString(),
      syncStatus: map['syncStatus']?.toString(),
      syncMessage: map['syncMessage']?.toString(),
      storageLocation: map['storageLocation']?.toString(),
      eta: map['eta']?.toString(),
      categoryId: map['categoryId'] is int ? map['categoryId'] : int.tryParse(map['categoryId']?.toString() ?? ''),
      categoryName: map['categoryName']?.toString(),
      receivedDate: map['receivedDate']?.toString(),
      status: map['status']?.toString(),
      deliveryStatusCode: map['deliveryStatusCode']?.toString(),
      countryCode: map['countryCode']?.toString(),
      countryName: map['countryName']?.toString(),
      packetSize: map['packetSize']?.toString(),
      weight: map['weight']?.toString(),
      actualVolume: map['actualVolume']?.toString(),
      partial: map['partial']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory BaggingTaggingPendingModel.fromJson(String source) =>
      BaggingTaggingPendingModel.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
    id,
    title,
    poId,
    poCode,
    portId,
    poRemark,
    transactionMobRefId,
    items,
    grnNo,
    grnRefNo,
    poNo,
    mobRefId,
    createdOnDate,
    modifiedOnDate,
    modifiedOn,
    grnDate,
    isFull,
    deliveryRef,
    isBaggingComplete,
    tag,
    syncStatus,
    syncMessage,
    storageLocation,
    eta,
    categoryId,
    categoryName,
    receivedDate,
    status,
    deliveryStatusCode,
    countryCode,
    countryName,
    packetSize,
    weight,
    actualVolume,
    partial,
  ];

  @override
  bool? get stringify => true;

  BaggingTaggingPendingEntity toEntity() => BaggingTaggingPendingEntity(
    id: id ?? 0,
    title: title ?? '',
    poId: poId ?? '',
    poCode: poCode ?? '',
    portId: portId ?? 0,
    poRemark: poRemark ?? '',
    transactionMobRefId: transactionMobRefId ?? '',
    items: items ?? '',
    grnNo: grnNo ?? '',
    grnRefNo: grnRefNo ?? '',
    poNo: poNo ?? '',
    mobRefId: mobRefId ?? 0,
    createdOnDate: createdOnDate ?? '',
    modifiedOnDate: modifiedOnDate ?? '',
    modifiedOn: modifiedOn ?? '',
    grnDate: grnDate ?? '',
    isFull: isFull ?? '',
    deliveryRef: deliveryRef ?? '',
    isBaggingComplete: isBaggingComplete ?? '',
    tag: tag ?? '',
    syncStatus: syncStatus ?? '',
    syncMessage: syncMessage ?? '',
    storageLocation: storageLocation ?? '',
    eta: eta ?? '',
    categoryId: categoryId ?? 0,
    categoryName: categoryName ?? '',
    receivedDate: receivedDate ?? '',
    status: status ?? '',
    deliveryStatusCode: deliveryStatusCode ?? '',
    countryCode: countryCode ?? '',
    countryName: countryName ?? '',
    packetSize: packetSize ?? '',
    weight: weight ?? '',
    actualVolume: actualVolume ?? '',
    partial: partial ?? '',
  );


  factory BaggingTaggingPendingModel.fromEntity(
      BaggingTaggingPendingEntity entity,
      ) {
    return BaggingTaggingPendingModel(
      id: entity.id,
      title: entity.title,
      poId: entity.poId,
      poCode: entity.poCode,
      portId: entity.portId,
      poRemark: entity.poRemark,
      transactionMobRefId: entity.transactionMobRefId,
      items: entity.items,
      grnNo: entity.grnNo,
      grnRefNo: entity.grnRefNo,
      poNo: entity.poNo,
      mobRefId: entity.mobRefId,
      createdOnDate: entity.createdOnDate,
      modifiedOnDate: entity.modifiedOnDate,
      modifiedOn: entity.modifiedOn,
      grnDate: entity.grnDate,
      isFull: entity.isFull,
      deliveryRef: entity.deliveryRef,
      isBaggingComplete: entity.isBaggingComplete,
      tag: entity.tag,
      syncStatus: entity.syncStatus,
      syncMessage: entity.syncMessage,
      storageLocation: entity.storageLocation,
      eta: entity.eta,
      categoryId: entity.categoryId,
      categoryName: entity.categoryName,
      receivedDate: entity.receivedDate,
      status: entity.status,
      deliveryStatusCode: entity.deliveryStatusCode,
      countryCode: entity.countryCode,
      countryName: entity.countryName,
      packetSize: entity.packetSize,
      weight: entity.weight,
      actualVolume: entity.actualVolume,
      partial: entity.partial,
    );
  }
}


