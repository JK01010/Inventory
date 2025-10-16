part of 'bagging_tagging_split_location_bloc.dart';

sealed class BaggingTaggingSplitLocationEvent extends Equatable {
  const BaggingTaggingSplitLocationEvent();

  @override
  List<Object?> get props => [];
}

class FetchSplitStorageLocationByPurchaseItemDetailEntity
    extends BaggingTaggingSplitLocationEvent {
  FetchSplitStorageLocationByPurchaseItemDetailEntity(
    this.baggingTaggingPurchaseItemDetailEntity,
  );

  GoodsReceiptPurchaseItemDetailEntity baggingTaggingPurchaseItemDetailEntity;
}

class AddEmptySplitStorageLocationWidgetEvent
    extends BaggingTaggingSplitLocationEvent {
  const AddEmptySplitStorageLocationWidgetEvent(
    this.poId,
    this.poDtId,
    this.itemId,
    this.itemType,
  );

  final int poId;
  final int poDtId;
  final int itemId;
  final String itemType;
}

class UpdateSplitLocationEntityWithSelectedLocationEvent
    extends BaggingTaggingSplitLocationEvent {
  UpdateSplitLocationEntityWithSelectedLocationEvent(this.splitLocationEntity);

  SplitLocationEntity splitLocationEntity;
}

class OnChangeSplitLocationQuantityEvent
    extends BaggingTaggingSplitLocationEvent {
  OnChangeSplitLocationQuantityEvent(this.quantity, this.splitLocationEntity);

  int quantity;
  SplitLocationEntity splitLocationEntity;
}

class UpdateSplitLocationInTableOnLabelDetailEvent
    extends BaggingTaggingSplitLocationEvent {
  UpdateSplitLocationInTableOnLabelDetailEvent(this.splitLocationEntityList);

  List<SplitLocationEntity> splitLocationEntityList;
}

