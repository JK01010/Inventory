part of 'consumption_add_page_bloc.dart';

class ConsumptionAddPageState extends Equatable {
  const ConsumptionAddPageState({
    required this.consumptionFailures,
    required this.itemMasterList,
    required this.chooseItemList,
    required this.selectedChooseItems,
    required this.chooseItemText,
    required this.quantity,
    required this.actualQuantity,
    required this.umo,
    required this.remarks,
    required this.isItemSearchError,
    required this.isQuantityError,
    required this.isUmoError,
    required this.isRemarksError,
    required this.selectedStorageLocationId,
    required this.selectedItemId,
    required this.isCompletedFrom,
    required this.selectedStorageLocationCode,
    required this.isChooseStorageLocationError,
  });

  factory ConsumptionAddPageState.initial() {
    return ConsumptionAddPageState(
      itemMasterList: [],
      consumptionFailures: none(),
      chooseItemList: [],
      selectedChooseItems: [],
      chooseItemText: "",
      quantity: "",
      actualQuantity: "",
      umo: "",
      remarks: "",
      isItemSearchError: false,
      isQuantityError: false,
      isUmoError: false,
      isRemarksError: false,
      selectedStorageLocationId: 0,
      selectedItemId: 0,
      isCompletedFrom: "",
      selectedStorageLocationCode: "",
      isChooseStorageLocationError: false,
    );
  }

  final List<ItemMasterEntity> itemMasterList;
  final List<ChooseItemsConEntity> chooseItemList;
  final List<ChooseItemsConEntity> selectedChooseItems;
  final Option<ItemMasterFailures> consumptionFailures;
  final int selectedStorageLocationId;
  final int selectedItemId;
  final String chooseItemText;
  final String quantity;
  final String actualQuantity;
  final String umo;
  final String remarks;
  final bool isChooseStorageLocationError;
  final bool isItemSearchError;
  final bool isQuantityError;
  final bool isUmoError;
  final bool isRemarksError;
  final String isCompletedFrom;

  final String selectedStorageLocationCode;

  @override
  List<Object?> get props => [
    itemMasterList,
    consumptionFailures,
    chooseItemList,
    selectedChooseItems,
    chooseItemText,
    quantity,
    actualQuantity,
    umo,
    remarks,
    isItemSearchError,
    isQuantityError,
    isUmoError,
    isRemarksError,
    selectedStorageLocationId,
    isCompletedFrom,
    selectedStorageLocationCode,
    isChooseStorageLocationError,
  ];

  ConsumptionAddPageState copyWith({
    List<ItemMasterEntity>? itemMasterList,
    List<ChooseItemsConEntity>? chooseItemList,
    List<ChooseItemsConEntity>? selectedChooseItems,
    Option<ItemMasterFailures>? consumptionFailures,
    String? chooseItemText,
    String? quantity,
    String? actualQuantity,
    String? umo,
    String? remarks,
    bool? isItemSearchError,
    bool? isQuantityError,
    bool? isUmoError,
    bool? isRemarksError,
    int? selectedStorageLocationId,
    int? selectedItemId,
    String? isCompletedFrom,
    String? selectedStorageLocationCode,
    bool? isChooseStorageLocationError,
  }) {
    return ConsumptionAddPageState(
      itemMasterList: itemMasterList ?? this.itemMasterList,
      chooseItemList: chooseItemList ?? this.chooseItemList,
      selectedChooseItems: selectedChooseItems ?? this.selectedChooseItems,
      consumptionFailures: consumptionFailures ?? this.consumptionFailures,
      chooseItemText: chooseItemText ?? this.chooseItemText,
      quantity: quantity ?? this.quantity,
      actualQuantity: actualQuantity ?? this.actualQuantity,
      umo: umo ?? this.umo,
      remarks: remarks ?? this.remarks,
      isItemSearchError: isItemSearchError ?? this.isItemSearchError,
      isQuantityError: isQuantityError ?? this.isQuantityError,
      isUmoError: isUmoError ?? this.isUmoError,
      isRemarksError: isRemarksError ?? this.isRemarksError,
      selectedStorageLocationId:
      selectedStorageLocationId ?? this.selectedStorageLocationId,
      selectedItemId: selectedItemId ?? this.selectedItemId,
      isCompletedFrom: isCompletedFrom ?? this.isCompletedFrom,
      selectedStorageLocationCode:
          selectedStorageLocationCode ?? this.selectedStorageLocationCode,
      isChooseStorageLocationError:
          isChooseStorageLocationError ?? this.isChooseStorageLocationError,
    );
  }
}
