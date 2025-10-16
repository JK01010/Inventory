part of 'goods_receipt_split_location_bloc.dart';

sealed class GoodsReceiptSplitLocationEvent extends Equatable {
  const GoodsReceiptSplitLocationEvent();

  @override
  List<Object?> get props => [];
}

class FetchSplitStorageLocationByPurchaseItemDetailEntity
    extends GoodsReceiptSplitLocationEvent {
  FetchSplitStorageLocationByPurchaseItemDetailEntity(
    this.goodsReceiptPurchaseOrderLineItemEntity,
  );

  GoodsReceiptPurchaseOrderLineItemEntity
  goodsReceiptPurchaseOrderLineItemEntity;
}

class AddEmptySplitStorageLocationWidgetEvent
    extends GoodsReceiptSplitLocationEvent {
  const AddEmptySplitStorageLocationWidgetEvent(
    this.poId,
    this.poDtId,
    this.itemId,
    this.typeId,
  );

  final int poId;
  final int poDtId;
  final int itemId;
  final int typeId;
}

class UpdateSplitLocationEntityWithSelectedLocationEvent
    extends GoodsReceiptSplitLocationEvent {
  UpdateSplitLocationEntityWithSelectedLocationEvent(this.splitLocationEntity);

  SplitLocationEntity splitLocationEntity;
}

class OnChangeSplitLocationQuantityEvent
    extends GoodsReceiptSplitLocationEvent {
  OnChangeSplitLocationQuantityEvent({
    required this.quantity,
    required this.splitLocationEntity,
    required this.cursorPosition,
  });

  double quantity;
  SplitLocationEntity splitLocationEntity;
  int cursorPosition;
}

class UpdateSplitLocationInTableOnLabelDetailEvent
    extends GoodsReceiptSplitLocationEvent {
  UpdateSplitLocationInTableOnLabelDetailEvent(this.splitLocationEntityList);

  List<SplitLocationEntity> splitLocationEntityList;
}

class DeleteSplitStorageLocationItemByIdEvent
    extends GoodsReceiptSplitLocationEvent {
  DeleteSplitStorageLocationItemByIdEvent(
    this.splitLocationEntity,
    this.goodsReceiptPurchaseOrderLineItemEntity,
  );

  SplitLocationEntity splitLocationEntity;
  GoodsReceiptPurchaseOrderLineItemEntity
  goodsReceiptPurchaseOrderLineItemEntity;
}

class PendingPoSplitLocationUpdateToDbEvent
    extends GoodsReceiptSplitLocationEvent {
  const PendingPoSplitLocationUpdateToDbEvent({
    required this.splitLocationEntityList,
  });

  final List<SplitLocationEntity> splitLocationEntityList;
}

class FetchPendingPoSplitLocationDataEvent
    extends GoodsReceiptSplitLocationEvent {
  const FetchPendingPoSplitLocationDataEvent({
    required this.poHdId,
    required this.poDtId,
  });

  final int poHdId;
  final int poDtId;
}

class TransactionItemSplitLocationEvent extends GoodsReceiptSplitLocationEvent {
  const TransactionItemSplitLocationEvent({
    required this.grnHdId,
    required this.grnDtId,
  });

  final int grnHdId;
  final int grnDtId;
}
