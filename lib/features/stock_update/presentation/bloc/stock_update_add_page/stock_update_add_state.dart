part of 'stock_update_add_bloc.dart';

class StockUpdateAddState extends Equatable {
  const StockUpdateAddState({
    required this.stockUpdateFailures,
    required this.itemMasterList,
    required this.chooseItemList,
    required this.selectedChooseItems,

    required this.chooseItemText,
    required this.quantity,
    required this.newStock,
    required this.reconditionStock,
    required this.uomName,
    required this.adjNewStock,
    required this.adjReconditionedStock,
    required this.totalRob,
    required this.remarks,
    required this.isItemSearchError,
    required this.isQuantityError,
    // required this.isActualQuantityError,
    required this.isUmoError,
    required this.isRemarksError,
    required this.selectedStorageLocationId,
    required this.selectedItemId,
    required this.isCompletedFrom,
    required this.selectedStorageLocationCode,

  });

  factory StockUpdateAddState.initial() {
    return StockUpdateAddState(
      itemMasterList: [],
      stockUpdateFailures: none(),
      chooseItemList: [],
      selectedChooseItems: [],

      chooseItemText: "",
      quantity: "",
      newStock: "",
      reconditionStock: "",
      uomName: "",
      adjNewStock: "",
      adjReconditionedStock: "",
      totalRob: "",
      remarks: "",

      isItemSearchError: false,
      isQuantityError: false,
      // isActualQuantityError: false,
      isUmoError: false,
      isRemarksError: false,
      selectedStorageLocationId: 0,
      selectedItemId: 0,
      isCompletedFrom: "",
      selectedStorageLocationCode: "",

    );
  }

  final List<ItemMasterEntity> itemMasterList;
  final List<ChooseItemsEntity> chooseItemList;
  final List<ChooseItemsEntity> selectedChooseItems;
  final Option<ItemMasterFailures> stockUpdateFailures;

  final int selectedStorageLocationId;
  final int selectedItemId;

  final String chooseItemText;
  final String quantity;
  final String newStock;
  final String reconditionStock;
  final String uomName;
  final String adjNewStock;
  final String adjReconditionedStock;
  final String totalRob;
  final String remarks;

  final bool isItemSearchError;
  final bool isQuantityError;

  // final bool isActualQuantityError;
  final bool isUmoError;
  final bool isRemarksError;
  final String isCompletedFrom;
  final String selectedStorageLocationCode;

  @override
  List<Object?> get props => [
    itemMasterList,
    stockUpdateFailures,
    chooseItemList,
    selectedChooseItems,

    chooseItemText,
    quantity,
    newStock,
    reconditionStock,
    adjNewStock,
    adjReconditionedStock,
    totalRob,
    remarks,



    isItemSearchError,
    isQuantityError,
    // isActualQuantityError,
    isUmoError,
    isRemarksError,
    selectedStorageLocationId,
    selectedItemId,
    selectedStorageLocationCode,
    isCompletedFrom,
  ];

  StockUpdateAddState copyWith({
    List<ItemMasterEntity>? itemMasterList,
    List<ChooseItemsEntity>? chooseItemList,
    List<ChooseItemsEntity>? selectedChooseItems,
    Option<ItemMasterFailures>? stockUpdateFailures,

    String? chooseItemText,
    String? quantity,
    String? newStock,

    String? adjNewStock,
    String? adjReconditionedStock,
    String? reconditionStock,
    String? uomName,
    String? totalRob,
    String? remarks,

    bool? isItemSearchError,
    bool? isQuantityError,
    // bool? isActualQuantityError,
    bool? isUmoError,
    bool? isRemarksError,

    int? selectedStorageLocationId,
    int? selectedItemId,
    String? isCompletedFrom,
    String? selectedStorageLocationCode,
  }) {
    return StockUpdateAddState(
      itemMasterList: itemMasterList ?? this.itemMasterList,
      chooseItemList: chooseItemList ?? this.chooseItemList,
      selectedChooseItems: selectedChooseItems ?? this.selectedChooseItems,
      stockUpdateFailures: stockUpdateFailures ?? this.stockUpdateFailures,
      chooseItemText: chooseItemText ?? this.chooseItemText,
      quantity: quantity ?? this.quantity,
      newStock: newStock ?? this.newStock,
      reconditionStock: reconditionStock ?? this.reconditionStock,
      adjNewStock: adjNewStock ?? this.adjNewStock,
      adjReconditionedStock: adjReconditionedStock ?? this.adjReconditionedStock,
      uomName: uomName ?? this.uomName,
      totalRob: totalRob ?? this.totalRob,
      remarks: remarks ?? this.remarks,
      isItemSearchError: isItemSearchError ?? this.isItemSearchError,
      isQuantityError: isQuantityError ?? this.isQuantityError,
      // isActualQuantityError: isActualQuantityError ?? this.isActualQuantityError,
      isUmoError: isUmoError ?? this.isUmoError,
      isRemarksError: isRemarksError ?? this.isRemarksError,
      selectedStorageLocationId:
          selectedStorageLocationId ?? this.selectedStorageLocationId,
      selectedItemId: selectedItemId ?? this.selectedItemId,
      isCompletedFrom: isCompletedFrom ?? this.isCompletedFrom,
      selectedStorageLocationCode:
          selectedStorageLocationCode ?? this.selectedStorageLocationCode,
    );
  }
}
