import 'package:equatable/equatable.dart';


class PendingListModel {
  PendingListModel({
    required this.poNumber,
    required this.grnNumber,
    required this.category,
    required this.title,
    required this.tag,
    required this.color,
    required this.bgColor,
    required this.isSynced,
  });
  final String poNumber;
  final String grnNumber;
  final String category;
  final String title;
  final String tag;
  final int color;
  final int bgColor;
  final String isSynced;
}

class BaggingTaggingPendingResponse {
  BaggingTaggingPendingResponse({required this.baggingTaggingList});

  final List<BaggingTaggingPendingEntity> baggingTaggingList;
}

class BaggingTaggingPendingEntity extends Equatable {
  const BaggingTaggingPendingEntity({
    required this.id,
    required this.title,
    required this.poId,
    required this.poCode,
    required this.portId,
    required this.poRemark,
    required this.transactionMobRefId,
    required this.items,
    required this.grnNo,
    required this.grnRefNo,
    required this.poNo,
    required this.mobRefId,
    required this.createdOnDate,
    required this.modifiedOnDate,
    required this.modifiedOn,
    required this.grnDate,
    required this.isFull,
    required this.deliveryRef,
    required this.isBaggingComplete,
    required this.tag,
    required this.syncStatus,
    required this.syncMessage,
    required this.storageLocation,
    required this.eta,
    required this.categoryId,
    required this.categoryName,
    required this.receivedDate,
    required this.status,
    required this.deliveryStatusCode,
    required this.countryCode,
    required this.countryName,
    required this.packetSize,
    required this.weight,
    required this.actualVolume,
    required this.partial,
  });

  final int id;
  final String title;
  final String poId;
  final String poCode;
  final int portId;
  final String poRemark;
  final String transactionMobRefId;
  final String items;
  final String grnNo;
  final String grnRefNo;
  final String poNo;
  final int mobRefId;
  final String createdOnDate;
  final String modifiedOnDate;
  final String modifiedOn;
  final String grnDate;
  final String isFull;
  final String deliveryRef;
  final String isBaggingComplete;
  final String tag;
  final String syncStatus;
  final String syncMessage;
  final String storageLocation;
  final String eta;
  final int categoryId;
  final String categoryName;
  final String receivedDate;
  final String status;
  final String deliveryStatusCode;
  final String countryCode;
  final String countryName;
  final String packetSize;
  final String weight;
  final String actualVolume;
  final String partial;

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
}

