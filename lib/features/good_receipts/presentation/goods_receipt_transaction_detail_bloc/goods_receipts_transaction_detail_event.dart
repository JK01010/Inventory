part of 'goods_receipts_transaction_detail_bloc.dart';

class GoodsReceiptsTransactionDetailEvent extends Equatable {
  const GoodsReceiptsTransactionDetailEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetPOItemListForSelectedGRNTransactionEvent
    extends GoodsReceiptsTransactionDetailEvent {
  GetPOItemListForSelectedGRNTransactionEvent(this.poId);

  int poId;
}

class GetGoodsReceiptsTransactionByIdEvent
    extends GoodsReceiptsTransactionDetailEvent {
  GetGoodsReceiptsTransactionByIdEvent(this.transactionId);

  int transactionId;
}
