part of 'bagging_tagging_purchase_pending_details_bloc.dart';

class BaggingTaggingPurchasePendingDetailsEvent extends Equatable {
  const BaggingTaggingPurchasePendingDetailsEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetBaggingTaggingPendingByIdEvent
    extends BaggingTaggingPurchasePendingDetailsEvent {
  GetBaggingTaggingPendingByIdEvent(this.transactionId);

  int transactionId;
}

class SetPendingInitalDataEvent
    extends BaggingTaggingPurchasePendingDetailsEvent {
  const SetPendingInitalDataEvent({
    required this.goodsReceiptsTransactionEntity,
  });

  final GoodsReceiptsTransactionEntity goodsReceiptsTransactionEntity;
}

class SaveBaggingAndTagging extends BaggingTaggingPurchasePendingDetailsEvent {
  const SaveBaggingAndTagging({required this.id});

  final int id;
}
