part of 'bagging_tagging_purchase_list_bloc.dart';

sealed class BaggingTaggingPurchaseListEvent extends Equatable {
  const BaggingTaggingPurchaseListEvent();

  @override
  List<Object> get props => [];
}

class BaggingTaggingPurchaseListInsertDataEvent
    extends BaggingTaggingPurchaseListEvent {}

class BaggingTaggingPurchaseListGetAllDataEvent
    extends BaggingTaggingPurchaseListEvent {
  const BaggingTaggingPurchaseListGetAllDataEvent({required this.poHDId});

  final String poHDId;
}

class BaggingTaggingRFIDViewEvent extends BaggingTaggingPurchaseListEvent {
  const BaggingTaggingRFIDViewEvent({required this.itemId});

  final int itemId;
}

class IsCheckBoxSelectedEvent extends BaggingTaggingPurchaseListEvent {
  IsCheckBoxSelectedEvent({required this.index, required this.isSelectedValue});

  final int index;
  final bool isSelectedValue;
}

class IsAllItemsSelectEvent extends BaggingTaggingPurchaseListEvent {
  const IsAllItemsSelectEvent({required this.isSelected});

  final bool isSelected;
}

class BaggingTaggingPurchaseInitialEvent
    extends BaggingTaggingPurchaseListEvent {}

//serial number
class OnBaggingSerialNoUpdateEvent extends BaggingTaggingPurchaseListEvent {
  const OnBaggingSerialNoUpdateEvent(this.articleNo);

  final dynamic articleNo;
}

class BaggingAutoGenerateNumberCheckboxEvent
    extends BaggingTaggingPurchaseListEvent {
  BaggingAutoGenerateNumberCheckboxEvent(
    this.isBaggingAutoGenerateNumberEnabled,
  );

  final bool isBaggingAutoGenerateNumberEnabled;
}
