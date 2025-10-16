part of 'bagging_tagging_purchase_list_bloc.dart';

class BaggingTaggingPurchaseListState extends Equatable {
  BaggingTaggingPurchaseListState({
    required this.baggingTaggingPurchaseList,
    required this.mainPurchaseList,
    required this.isLoading,
    required this.failureOption,
    required this.rfidIds,
    required this.isCompleteSelected,
    required this.isBaggingAutoSerialNumber,
    required this.autoSerialNumberList,
    required this.baggingTaggingPurchaseEntityList,
  });

  factory BaggingTaggingPurchaseListState.initial() =>
      BaggingTaggingPurchaseListState(
        baggingTaggingPurchaseList: [],
        mainPurchaseList: [],
        isLoading: false,
        failureOption: none(),
        rfidIds: [],
        isCompleteSelected: false,
        isBaggingAutoSerialNumber: false,
        autoSerialNumberList: [],
        baggingTaggingPurchaseEntityList: null,
      );

  final List<BaggingTaggingPurchaseListViewEntity> baggingTaggingPurchaseList;
  final List<BaggingTaggingPurchaseListViewEntity> mainPurchaseList;
  final bool isLoading;
  final Option<BaggingAndTaggingFailures> failureOption;
  final List<String> rfidIds;
  final bool isCompleteSelected;
  bool? isBaggingAutoSerialNumber = false;
  final List<String> autoSerialNumberList;
  BaggingTaggingPurchaseListViewEntity? baggingTaggingPurchaseEntityList;

  @override
  List<Object?> get props => [
    baggingTaggingPurchaseList,
    mainPurchaseList,
    isLoading,
    failureOption,
    rfidIds,
    isCompleteSelected,
    isBaggingAutoSerialNumber,
    autoSerialNumberList,
    baggingTaggingPurchaseEntityList,
  ];

  BaggingTaggingPurchaseListState copyWith({
    List<BaggingTaggingPurchaseListViewEntity>? baggingTaggingPurchaseList,
    List<BaggingTaggingPurchaseListViewEntity>? mainPurchaseList,
    bool? isLoading,
    Option<BaggingAndTaggingFailures>? failureOption,
    List<String>? rfidIds,
    bool? isCompleteSelected,
    bool? isBaggingAutoSerialNumber,
    List<String>? autoSerialNumberList,
    BaggingTaggingPurchaseListViewEntity? baggingTaggingPurchaseEntityList,
  }) {
    return BaggingTaggingPurchaseListState(
      baggingTaggingPurchaseList:
          baggingTaggingPurchaseList ?? this.baggingTaggingPurchaseList,
      mainPurchaseList: mainPurchaseList ?? this.mainPurchaseList,
      isLoading: isLoading ?? this.isLoading,
      failureOption: failureOption ?? this.failureOption,
      rfidIds: rfidIds ?? this.rfidIds,
      isCompleteSelected: isCompleteSelected ?? this.isCompleteSelected,
      isBaggingAutoSerialNumber:
          isBaggingAutoSerialNumber ?? this.isBaggingAutoSerialNumber,
      autoSerialNumberList: autoSerialNumberList ?? this.autoSerialNumberList,
      baggingTaggingPurchaseEntityList:
          baggingTaggingPurchaseEntityList ??
          this.baggingTaggingPurchaseEntityList,
    );
  }
}
