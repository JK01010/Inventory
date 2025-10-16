part of 'goods_receipts_po_bloc.dart';

sealed class GoodsReceiptsPoEvent extends Equatable {
  const GoodsReceiptsPoEvent();

  @override
  List<Object> get props => [];
}



class GetGoodsReceiptDetailEventById extends GoodsReceiptsPoEvent {
  const GetGoodsReceiptDetailEventById(this.pendingOrderId);

  final String pendingOrderId;

  @override
  List<Object> get props => [pendingOrderId];
}

class UpdateGoodsReceiptDetailForDraftEvent extends GoodsReceiptsPoEvent {
  const UpdateGoodsReceiptDetailForDraftEvent(this.purchaseOrderHDEntity);

  final PurchaseOrderHDEntity purchaseOrderHDEntity;
}

class ChangeReceivedDate extends GoodsReceiptsPoEvent {
  const ChangeReceivedDate({required this.receivedDate, required this.index});

  final String receivedDate;
  final int index;

  @override
  List<Object> get props => [receivedDate];
}

class GoodsReceiptsPoGetAllPoLineItemsDataEvent extends GoodsReceiptsPoEvent {}

class SaveOrDraftGoodsReceiptEvent extends GoodsReceiptsPoEvent {
  const SaveOrDraftGoodsReceiptEvent({
    required this.purchaseOrderHDEntity,
    required this.statusType,
  });

  final PurchaseOrderHDEntity purchaseOrderHDEntity;
  final String statusType;
}
