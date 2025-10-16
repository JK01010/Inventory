import 'package:equatable/equatable.dart';

import '../../../../common_feature/domain/entities/fetch_imdg_class_entity.dart';
import '../../../../common_feature/domain/entities/item_entity.dart';
import '../../../domain/entities/split_location_entity.dart';
import '../../../purchase_order/domain/entity/purchase_order_entity.dart';
import '../../domain/entity/serial_number_entity.dart';

sealed class PurchaseOrderItemDetailBlocEvent extends Equatable {
  const PurchaseOrderItemDetailBlocEvent();

  @override
  List<Object> get props => [];
}

class SetInitialDataEvent extends PurchaseOrderItemDetailBlocEvent {
  const SetInitialDataEvent({
    required this.purchaseOrderEntity,
    required this.itemEntity,
  });

  final PurchaseOrderEntity purchaseOrderEntity;
  final ItemEntity itemEntity;
}

class AddSplitLocationEvent extends PurchaseOrderItemDetailBlocEvent {
  const AddSplitLocationEvent({required this.itemTypeId});

  final int itemTypeId;
}

class SplitLocationChangeEvent extends PurchaseOrderItemDetailBlocEvent {
  const SplitLocationChangeEvent({
    required this.data,
    required this.splitLocationEntity,
  });

  final Map<String, dynamic> data;
  final SplitLocationEntity splitLocationEntity;
}

class SplitLocationQuantityChangeEvent
    extends PurchaseOrderItemDetailBlocEvent {
  const SplitLocationQuantityChangeEvent({
    required this.newQuantity,
    required this.splitLocationEntity,
  });

  final String newQuantity;
  final SplitLocationEntity splitLocationEntity;
}

class PurchaseOrderItemQualityChangeEvent
    extends PurchaseOrderItemDetailBlocEvent {
  const PurchaseOrderItemQualityChangeEvent({required this.newQuality});

  final int newQuality;
}

class PurchaseOrderItemImdgClassChangeEvent
    extends PurchaseOrderItemDetailBlocEvent {
  const PurchaseOrderItemImdgClassChangeEvent({required this.imdgClassEntity});

  final ImdgClassEntity imdgClassEntity;
}

class SavePurchaseOrderItemDetailEvent
    extends PurchaseOrderItemDetailBlocEvent {
  const SavePurchaseOrderItemDetailEvent();
}

class GenerateSerialNumbersEvent extends PurchaseOrderItemDetailBlocEvent {
  const GenerateSerialNumbersEvent({
    required this.splitLocationEntity,
    required this.quantity,
  });

  final SplitLocationEntity splitLocationEntity;
  final double quantity;
}

class SaveSerialNumbersEvent extends PurchaseOrderItemDetailBlocEvent {
  const SaveSerialNumbersEvent({
    required this.splitLocationEntity,
    required this.updatedSerialNumbers,
  });

  final SplitLocationEntity splitLocationEntity;
  final List<SerialNumberEntity> updatedSerialNumbers;
}

class PurchaseOrderItemDetailTextFieldChangeEvent
    extends PurchaseOrderItemDetailBlocEvent {
  const PurchaseOrderItemDetailTextFieldChangeEvent({
    required this.newValue,
    required this.purchaseOrderItemDetailTextFieldType,
  });

  final String newValue;
  final PurchaseOrderItemDetailTextFieldType
  purchaseOrderItemDetailTextFieldType;
}

enum PurchaseOrderItemDetailTextFieldType {
  receivedQty,
  damagedQty,
  newStockQty,
  reconditionedQty,
  expiryDate,
  remarks,
}
