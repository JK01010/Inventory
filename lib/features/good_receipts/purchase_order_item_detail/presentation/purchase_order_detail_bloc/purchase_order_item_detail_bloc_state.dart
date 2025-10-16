import 'package:equatable/equatable.dart';

import '../../../../common_feature/domain/entities/fetch_imdg_class_entity.dart';
import '../../../../common_feature/domain/entities/item_entity.dart';
import '../../../domain/entities/split_location_entity.dart';
import '../../../purchase_order/domain/entity/purchase_order_entity.dart';
import '../../domain/entity/serial_number_entity.dart';

class PurchaseOrderItemDetailBlocState extends Equatable {
  const PurchaseOrderItemDetailBlocState({
    required this.isLoading,
    required this.purchaseOrderData,
    required this.itemEntity,
    required this.isSaveSuccess,
    required this.splitLocationEntity,
    required this.imdgClassList,
    required this.validationError,
    required this.validationMessage,
    required this.allSerialNumbers,
    required this.isGeneratingSerialNumber,
  });

  factory PurchaseOrderItemDetailBlocState.initial() {
    return PurchaseOrderItemDetailBlocState(
      isLoading: true,
      purchaseOrderData: PurchaseOrderEntity.initial(),
      itemEntity: ItemEntity.initial(),
      isSaveSuccess: false,
      splitLocationEntity: [],
      imdgClassList: [],
      validationError: false,
      validationMessage: "",
      allSerialNumbers: [],
      isGeneratingSerialNumber: false,
    );
  }

  final bool isLoading;
  final PurchaseOrderEntity purchaseOrderData;
  final ItemEntity itemEntity;
  final bool isSaveSuccess;
  final List<SplitLocationEntity> splitLocationEntity;
  final List<ImdgClassEntity> imdgClassList;
  final bool validationError;
  final String validationMessage;
  final List<SerialNumberEntity> allSerialNumbers;
  final bool isGeneratingSerialNumber;

  @override
  List<Object?> get props => [
    isLoading,
    purchaseOrderData,
    itemEntity,
    isSaveSuccess,
    splitLocationEntity,
    imdgClassList,
    validationError,
    validationMessage,
    allSerialNumbers,
    isGeneratingSerialNumber,
  ];

  PurchaseOrderItemDetailBlocState copyWith({
    bool? isLoading,
    ItemEntity? itemEntity,
    PurchaseOrderEntity? purchaseOrderData,
    bool? isSaveSuccess,
    List<SplitLocationEntity>? splitLocationEntity,
    List<ImdgClassEntity>? imdgClassList,
    bool? validationError,
    String? validationMessage,
    List<SerialNumberEntity>? allSerialNumbers,
    bool? isGeneratingSerialNumber,
  }) {
    return PurchaseOrderItemDetailBlocState(
      isLoading: isLoading ?? this.isLoading,
      purchaseOrderData: purchaseOrderData ?? this.purchaseOrderData,
      itemEntity: itemEntity ?? this.itemEntity,
      isSaveSuccess: isSaveSuccess ?? this.isSaveSuccess,
      splitLocationEntity: splitLocationEntity ?? this.splitLocationEntity,
      imdgClassList: imdgClassList ?? this.imdgClassList,
      validationError: validationError ?? this.validationError,
      validationMessage: validationMessage ?? this.validationMessage,
      allSerialNumbers: allSerialNumbers ?? this.allSerialNumbers,
      isGeneratingSerialNumber:
          isGeneratingSerialNumber ?? this.isGeneratingSerialNumber,
    );
  }
}
