part of 'goods_receipt_create_label_bloc.dart';

class GoodsReceiptCreateLabelEvent extends Equatable {
  const GoodsReceiptCreateLabelEvent();

  @override
  List<Object?> get props => [];
}

class GoodsReceiptGetLabelDetailById extends GoodsReceiptCreateLabelEvent {
  const GoodsReceiptGetLabelDetailById(this.dtId, this.hdId, this.itemId);

  final int dtId;
  final int hdId;
  final int itemId;

  @override
  List<Object> get props => [itemId];
}

class GoodsReceiptCreateLabelSaveEvent extends GoodsReceiptCreateLabelEvent {
  const GoodsReceiptCreateLabelSaveEvent(
    this.goodsReceiptPurchaseOrderLineItemEntity,
  );

  final GoodsReceiptPurchaseOrderLineItemEntity
  goodsReceiptPurchaseOrderLineItemEntity;
}

class OnDamagedQtyUpdateEvent extends GoodsReceiptCreateLabelEvent {
  const OnDamagedQtyUpdateEvent(this.damagedOrWrongSupply);

  final double damagedOrWrongSupply;
}

class OnReceivedQtyUpdateEvent extends GoodsReceiptCreateLabelEvent {
  const OnReceivedQtyUpdateEvent(this.receivedQty);

  final double receivedQty;
}

class OnNewStockUpdateEvent extends GoodsReceiptCreateLabelEvent {
  const OnNewStockUpdateEvent(this.newStock);

  final double newStock;
}

class OnReConditionedStockUpdateEvent extends GoodsReceiptCreateLabelEvent {
  const OnReConditionedStockUpdateEvent(this.reconditionedStock);

  final double reconditionedStock;
}

class OnQualityUpdateEvent extends GoodsReceiptCreateLabelEvent {
  const OnQualityUpdateEvent(this.qualityId);

  final int qualityId;
}

class OnExpiryDateUpdateEvent extends GoodsReceiptCreateLabelEvent {
  const OnExpiryDateUpdateEvent(this.expiryDate);

  final String expiryDate;
}

class OnBatchNoUpdateEvent extends GoodsReceiptCreateLabelEvent {
  const OnBatchNoUpdateEvent(this.batchNo);

  final String batchNo;
}

class OnSerialNoUpdateEvent extends GoodsReceiptCreateLabelEvent {
  const OnSerialNoUpdateEvent(this.articleNo);

  final String articleNo;
}

class OnImdgClassIdUpdateEvent extends GoodsReceiptCreateLabelEvent {
  const OnImdgClassIdUpdateEvent(this.fetchImdgClassEntity);

  final ImdgClassEntity fetchImdgClassEntity;
}

class OnRemarksUpdateEvent extends GoodsReceiptCreateLabelEvent {
  const OnRemarksUpdateEvent(this.remarks);

  final String remarks;
}

class OnDefaultStorageLocationEvent extends GoodsReceiptCreateLabelEvent {
  const OnDefaultStorageLocationEvent(
    this.storageLocationEntity,
  ); //TODO: Need to create a field for DefaultStorageLocation

  final StorageLocationEntity storageLocationEntity;
}

class FetchAllStorageLocationsEvent extends GoodsReceiptCreateLabelEvent {}

class FetchAllImdgClassEvent extends GoodsReceiptCreateLabelEvent {}

class GenerateAutoNumberCheckboxEvent extends GoodsReceiptCreateLabelEvent {
  GenerateAutoNumberCheckboxEvent(this.isAutoGenerateNumberEnabled);

  bool isAutoGenerateNumberEnabled;
}

class FetchGRNLocationMappingAPIEvent extends GoodsReceiptCreateLabelEvent {
  const FetchGRNLocationMappingAPIEvent();

  @override
  List<Object> get props => [];
}

// class FetchGRNLocationSerialMappingAPIEvent
//     extends GoodsReceiptCreateLabelEvent {
//   const FetchGRNLocationSerialMappingAPIEvent();
//
//   @override
//   List<Object> get props => [];
// }

class FetchItemRobDetailsEvent extends GoodsReceiptCreateLabelEvent {
  final int itemId;

  const FetchItemRobDetailsEvent({required this.itemId});
}

class GetItemDetailEvent extends GoodsReceiptCreateLabelEvent {
  const GetItemDetailEvent({
    required this.getGoodsReceiptPurchaseOrderLineItemEntity,
  });

  final GoodsReceiptPurchaseOrderLineItemEntity
  getGoodsReceiptPurchaseOrderLineItemEntity;
}

class RestInitialData extends GoodsReceiptCreateLabelEvent {
}
