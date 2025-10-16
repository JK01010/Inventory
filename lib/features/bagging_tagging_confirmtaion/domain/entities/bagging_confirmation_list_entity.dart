import 'package:equatable/equatable.dart';

class BaggingConfirmationListResponse {
  BaggingConfirmationListResponse({required this.baggingConfirmationListEntity});

  final List<BaggingConfirmationListEntity> baggingConfirmationListEntity;
}

class BaggingConfirmationListEntity extends Equatable{
   BaggingConfirmationListEntity({
    required this.id,
    required this.poId,
    required this.poCode,
    required this.transactionId,
    required this.grnNo,
    required this.status,
    required this.syncStatus,
    required this.syncMessage,
    required this.storageLocationCount,
    required this.storageLocationId,
    this.isSelected = false
  }
);
  final int id;
  final String poId;
  final String poCode;
  final String transactionId;
  final String grnNo;
  final String status;
  final String syncStatus;
  final String syncMessage;
  final int storageLocationCount;
  final int storageLocationId;
  bool isSelected;

  @override
  // TODO: implement props
  List<Object?> get props =>[
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
    isSelected
  ];
  @override
  bool? get stringify => true;

   BaggingConfirmationListEntity copyWith({
     int? id,
     String? poId,
     String? poCode,
     String? transactionId,
     String? grnNo,
     String? status,
     String? syncStatus,
     String? syncMessage,
     int? storageLocationCount,
     int? storageLocationId,
     bool? isSelected,
   }) {
     return BaggingConfirmationListEntity(
       id: id ?? this.id,
       poId: poId ?? this.poId,
       poCode: poCode ?? this.poCode,
       transactionId: transactionId ?? this.transactionId,
       grnNo: grnNo ?? this.grnNo,
       status: status ?? this.status,
       syncStatus: syncStatus ?? this.syncStatus,
       syncMessage: syncMessage ?? this.syncMessage,
       storageLocationCount: storageLocationCount ?? this.storageLocationCount,
       storageLocationId: storageLocationId ?? this.storageLocationId,
       isSelected: isSelected ?? this.isSelected,
     );
   }

}
