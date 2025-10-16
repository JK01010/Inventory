import 'package:equatable/equatable.dart';

class PurchaseDetailsResponse {
  PurchaseDetailsResponse({required this.purchaseDetailsEntity});

  final List<PurchaseDetailsEntity> purchaseDetailsEntity;
}

class PurchaseDetailsEntity extends Equatable {
  const PurchaseDetailsEntity({
    required this.purchaseName,
    required this.orderNo,
    required this.country,
    required this.deliveryReference,
    required this.receivedDate,
    required this.weight,
    required this.actualVolume,
    required this.numberOfPackets,
    required this.partial,
    required this.baggingTaggingCompleted,
  });

  final String purchaseName;
  final String orderNo;
  final String country;
  final String deliveryReference;
  final String receivedDate;
  final String weight;
  final String actualVolume;
  final String numberOfPackets;
  final String partial;
  final String baggingTaggingCompleted;

  @override
  List<Object?> get props => [
    purchaseName,
    orderNo,
    country,
    deliveryReference,
    receivedDate,
    weight,
    actualVolume,
    numberOfPackets,
    partial,
    baggingTaggingCompleted,
  ];

  bool? get stringify => true;
}
