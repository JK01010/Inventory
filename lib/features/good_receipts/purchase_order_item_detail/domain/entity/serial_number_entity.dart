import 'package:equatable/equatable.dart';

class SerialNumberEntity extends Equatable {
  const SerialNumberEntity({
    required this.serialNumberId,
    required this.serialNumber,
    required this.poHdId,
    required this.poDtId,
    required this.grnId,
    required this.grnDtId,
    required this.typeId,
    required this.isManuallyEdited,
    required this.splitLocationId,
  });

  factory SerialNumberEntity.initial() {
    return SerialNumberEntity(
      serialNumber: '',
      serialNumberId: -1,
      poHdId: -1,
      poDtId: -1,
      grnId: -1,
      grnDtId: -1,
      typeId: -1,
      isManuallyEdited: false,
      splitLocationId: -1,
    );
  }

  final int serialNumberId;
  final String serialNumber;
  final int poHdId;
  final int poDtId;
  final int grnId;
  final int grnDtId;
  final int typeId;
  final bool isManuallyEdited;
  final int splitLocationId;

  @override
  List<Object?> get props => [
    serialNumberId,
    serialNumber,
    poHdId,
    poDtId,
    grnId,
    grnDtId,
    typeId,
    isManuallyEdited,
    splitLocationId,
  ];

  SerialNumberEntity copyWith({
    int? serialNumberId,
    String? serialNumber,
    int? poHdId,
    int? poDtId,
    int? grnId,
    int? grnDtId,
    int? typeId,
    bool? isManuallyEdited,
    int? splitLocationId,
  }) {
    return SerialNumberEntity(
      serialNumberId: serialNumberId ?? this.serialNumberId,
      serialNumber: serialNumber ?? this.serialNumber,
      poHdId: poHdId ?? this.poHdId,
      poDtId: poDtId ?? this.poDtId,
      grnId: grnId ?? this.grnId,
      grnDtId: grnDtId ?? this.grnDtId,
      typeId: typeId ?? this.typeId,
      isManuallyEdited: isManuallyEdited ?? this.isManuallyEdited,
      splitLocationId: splitLocationId ?? this.splitLocationId,
    );
  }

  @override
  String toString() {
    return 'Serial numbers : {serialNumberId : $serialNumberId, serialNumber : $serialNumber, poHdId : $poHdId, poDtId : $poDtId, grnId : $grnId, grnDtId : $grnDtId, typeId : $typeId, isManuallyEdited : $isManuallyEdited}';
  }
}
