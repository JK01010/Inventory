part of 'goods_receipt_label_bloc.dart';

class GoodsReceiptLabelEvent extends Equatable {
  const GoodsReceiptLabelEvent();

  @override
  List<Object?> get props => [];
}

class InsertGoodsReceiptsLabelEvent extends GoodsReceiptLabelEvent {}

class GetGoodsReceiptsLabelEventForPOId extends GoodsReceiptLabelEvent {
  GetGoodsReceiptsLabelEventForPOId(this.poId);

  String poId;
}

class UpdateGoodsReceiptDetailLabelListForDraftEvent
    extends GoodsReceiptLabelEvent {
  const UpdateGoodsReceiptDetailLabelListForDraftEvent(
    this.goodsReceiptPurchaseOrderLineItemEntityList,
  );

  final List<GoodsReceiptPurchaseOrderLineItemEntity>
  goodsReceiptPurchaseOrderLineItemEntityList;
}

class DeleteGoodsReceiptsLabelItemByIdEvent extends GoodsReceiptLabelEvent {
  DeleteGoodsReceiptsLabelItemByIdEvent(
    this.goodsReceiptPurchaseOrderLineItemEntity,
  );

  GoodsReceiptPurchaseOrderLineItemEntity
  goodsReceiptPurchaseOrderLineItemEntity;
}

class GetAllGRLabelItemListToCreateLabelEvent extends GoodsReceiptLabelEvent {
  const GetAllGRLabelItemListToCreateLabelEvent(this.poId);

  final int poId;
}

class UpdateCheckBoxSelectedStatusEvent extends GoodsReceiptLabelEvent {
  UpdateCheckBoxSelectedStatusEvent({
    required this.index,
    required this.isSelectedValue,
  });

  final int index;
  final bool isSelectedValue;
}

class AddItemsToUpdateCreateLabelItemsListForSelectedPOEvent
    extends GoodsReceiptLabelEvent {
  AddItemsToUpdateCreateLabelItemsListForSelectedPOEvent({
    required this.goodsReceiptPurchaseOrderLineItemEntityList,
    required this.poId,
  });

  final List<GoodsReceiptPurchaseOrderLineItemEntity>
  goodsReceiptPurchaseOrderLineItemEntityList;
  final int poId;
}

class GRNCreateLabelEvent extends GoodsReceiptLabelEvent {
  GRNCreateLabelEvent({required this.grnId, required this.itemIds});

  final int grnId;
  final List<int> itemIds;
}
