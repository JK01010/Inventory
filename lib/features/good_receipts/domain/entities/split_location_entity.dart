import 'package:equatable/equatable.dart';

import '../../purchase_order_item_detail/domain/entity/serial_number_entity.dart';

class SplitLocationEntity extends Equatable {
  factory SplitLocationEntity.initial() {
    return SplitLocationEntity(
      id: -1,
      itemId: -1,
      locationId: -1,
      poId: -1,
      robQty: -1,
      poDtId: -1,
      quantityType: '',
      transactionId: '',
      locationName: '',
      grnHdId: -1,
      grnDtId: -1,
      code: '',
      description: '',
      parentItemId: -1,
      typeId: -1,
      quantity: -1,
      parentId: -1,
      isActive: true,
      locationHierarchy: '',
      cursorPosition: 0,
      serialNumbers: []
    );
  }

  SplitLocationEntity({
    required this.id,
    required this.itemId,
    required this.locationId,
    required this.poId,
    required this.robQty,
    required this.poDtId,
    required this.quantityType,
    required this.transactionId,
    required this.locationName,
    this.cursorPosition,
    required this.grnHdId,
    required this.grnDtId,
    required this.code,
    required this.description,
    required this.parentItemId,
    required this.typeId,
    required this.quantity,
    required this.parentId,
    required this.isActive,
    required this.locationHierarchy,
    required this.serialNumbers
  });

  int id;
  int itemId;
  int locationId;
  int poId;
  int robQty;
  int poDtId;
  String quantityType;
  String transactionId;
  String locationName;
  int? cursorPosition = 0;
  int grnHdId;
  int grnDtId;
  String code;
  String description;
  int parentItemId;
  int typeId;
  double quantity;
  int parentId;
  bool isActive;
  String locationHierarchy;
  List<SerialNumberEntity> serialNumbers;

  @override
  List<Object?> get props => [
    id,
    itemId,
    locationId,
    poId,
    robQty,
    poDtId,
    quantityType,
    transactionId,
    locationName,
    cursorPosition,
    grnHdId,
    grnDtId,
    code,
    description,
    parentItemId,
    typeId,
    quantity,
    parentId,
    isActive,
    locationHierarchy,
  ];

  SplitLocationEntity copyWith({
    int? id,
    int? itemId,
    int? locationId,
    int? poId,
    int? robQty,
    int? poDtId,
    String? quantityType,
    String? transactionId,
    String? locationName,
    int? cursorPosition,
    int? grnHdId,
    int? grnDtId,
    String? code,
    String? description,
    int? parentItemId,
    int? typeId,
    double? quantity,
    int? parentId,
    bool? isActive,
    String? locationHierarchy,
    List<SerialNumberEntity>? serialNumbers,
  }) {
    return SplitLocationEntity(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      locationId: locationId ?? this.locationId,
      poId: poId ?? this.poId,
      robQty: robQty ?? this.robQty,
      poDtId: poDtId ?? this.poDtId,
      quantityType: quantityType ?? this.quantityType,
      transactionId: transactionId ?? this.transactionId,
      locationName: locationName ?? this.locationName,
      cursorPosition: cursorPosition ?? this.cursorPosition,
      grnHdId: grnHdId ?? this.grnHdId,
      grnDtId: grnDtId ?? this.grnDtId,
      code: code ?? this.code,
      description: description ?? this.description,
      parentItemId: parentItemId ?? this.parentItemId,
      typeId: typeId ?? this.typeId,
      quantity: quantity ?? this.quantity,
      parentId: parentId ?? this.parentId,
      isActive: isActive ?? this.isActive,
      locationHierarchy: locationHierarchy ?? this.locationHierarchy,
      serialNumbers: serialNumbers ?? this.serialNumbers,
    );
  }
}
