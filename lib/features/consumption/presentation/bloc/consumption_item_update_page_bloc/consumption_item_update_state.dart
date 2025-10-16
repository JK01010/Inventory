part of 'consumption_item_update_bloc.dart';

class ConsumptionItemUpdateState extends Equatable {
  const ConsumptionItemUpdateState({
    required this.isLoading,
    required this.itemMasterFailures,
    required this.equipmentListEntity,
    required this.allEquipmentListEntity,
    required this.selectedEquipmentName,
    required this.selectedEquipmentId,
    required this.selectedRfidItemList,
    required this.showErrorConsumedQty,
    required this.showErrorConsumedQtyRob,
    required this.isSaveCompleted,
    required this.breadCrumbList,
    required this.equipmentSaveEnabled,
    required this.selectedMainList,
    required this.consumptionFailures,
    required this.allLocationEntity,
    required this.locationListEntity,
    required this.locationBreadCrumbList,
    required this.selectedLocationName,
    required this.selectedLocationId,
    required this.locationSaveEnabled,
  });

  factory ConsumptionItemUpdateState.initial() => ConsumptionItemUpdateState(
    equipmentListEntity: [],
    isLoading: false,
    itemMasterFailures: none(),
    allEquipmentListEntity: [],
    showErrorConsumedQty: false,
    showErrorConsumedQtyRob: false,
    isSaveCompleted: false,
    selectedEquipmentName: '',
    selectedEquipmentId: 0,
    selectedRfidItemList: [],
    breadCrumbList: [],
    equipmentSaveEnabled: false,
    selectedMainList: [],
    consumptionFailures: none(),
    allLocationEntity: [],
    locationListEntity: [],
    locationBreadCrumbList: [],
    selectedLocationName: '',
    selectedLocationId: 0,
    locationSaveEnabled: false,
  );

  final List<EquipmentListEntity> equipmentListEntity;
  final List<EquipmentListEntity> allEquipmentListEntity;
  final List<EquipmentListEntity> breadCrumbList;

  final List<ConsumptionLocationEntity> locationListEntity;
  final List<ConsumptionLocationEntity> allLocationEntity;
  final List<ConsumptionLocationEntity> locationBreadCrumbList;

  final bool isLoading;
  final Option<ItemMasterFailures> itemMasterFailures;
  final Option<ConsumptionFailures> consumptionFailures;

  //filtering the equipment list
  final String? selectedEquipmentName;
  final int? selectedEquipmentId;

  final String? selectedLocationName;
  final int? selectedLocationId;

  final List<ConsumptionRfidListingViewEntity> selectedRfidItemList;
  final List<ConsumptionRfidListingViewEntity> selectedMainList;
  final bool showErrorConsumedQty;
  final bool showErrorConsumedQtyRob;
  final bool isSaveCompleted;

  final bool equipmentSaveEnabled;
  final bool locationSaveEnabled;


  @override
  List<Object?> get props => [
    itemMasterFailures,
    isLoading,
    equipmentListEntity,
    allEquipmentListEntity,
    selectedRfidItemList,
    showErrorConsumedQty,
    showErrorConsumedQtyRob,
    isSaveCompleted,
    selectedEquipmentName,
    selectedEquipmentId,
    selectedRfidItemList,
    breadCrumbList,
    equipmentSaveEnabled,
    selectedMainList,
    consumptionFailures,
    allLocationEntity,
    locationListEntity,
    locationBreadCrumbList,
    locationSaveEnabled,
    selectedLocationName,
    selectedLocationId,
  ];

  ConsumptionItemUpdateState copyWith({
    List<EquipmentListEntity>? equipmentListEntity,
    bool? isLoading,
    Option<ItemMasterFailures>? itemMasterFailures,
    List<EquipmentListEntity>? allEquipmentListEntity,

    String? selectedEquipmentName,
    int? selectedEquipmentId,

    List<ConsumptionRfidListingViewEntity>? selectedRfidItemList,
    bool? showErrorConsumedQty,
    bool? showErrorConsumedQtyRob,
    bool? isSaveCompleted,
    List<EquipmentListEntity>? breadCrumbList,
    bool? equipmentSaveEnabled,
    List<ConsumptionRfidListingViewEntity>? selectedMainList,
    Option<ConsumptionFailures>? consumptionFailures,
    List<ConsumptionLocationEntity>? allLocationEntity,
    List<ConsumptionLocationEntity>? locationListEntity,
    List<ConsumptionLocationEntity>? locationBreadCrumbList,
    bool? locationSaveEnabled,
    String? selectedLocationName,
    int? selectedLocationId,
  }) {
    return ConsumptionItemUpdateState(
      equipmentListEntity: equipmentListEntity ?? this.equipmentListEntity,
      isLoading: isLoading ?? this.isLoading,
      itemMasterFailures: itemMasterFailures ?? this.itemMasterFailures,
      allEquipmentListEntity:
          allEquipmentListEntity ?? this.allEquipmentListEntity,
      selectedEquipmentName:
          selectedEquipmentName ?? this.selectedEquipmentName,
      selectedEquipmentId: selectedEquipmentId ?? this.selectedEquipmentId,
      selectedRfidItemList: selectedRfidItemList ?? this.selectedRfidItemList,
      showErrorConsumedQty: showErrorConsumedQty ?? this.showErrorConsumedQty,
      showErrorConsumedQtyRob:
          showErrorConsumedQtyRob ?? this.showErrorConsumedQtyRob,
      isSaveCompleted: isSaveCompleted ?? this.isSaveCompleted,
      breadCrumbList: breadCrumbList ?? this.breadCrumbList,
      equipmentSaveEnabled:
          equipmentSaveEnabled ?? this.equipmentSaveEnabled,
      selectedMainList: selectedMainList ?? this.selectedMainList,
      consumptionFailures: consumptionFailures ?? this.consumptionFailures,
      allLocationEntity: allLocationEntity ?? this.allLocationEntity,
      locationListEntity: locationListEntity ?? this.locationListEntity,
      locationBreadCrumbList:
          locationBreadCrumbList ?? this.locationBreadCrumbList,
      locationSaveEnabled: locationSaveEnabled ?? this.locationSaveEnabled,
      selectedLocationName:
          selectedLocationName ?? this.selectedLocationName,
      selectedLocationId: selectedLocationId ?? this.selectedLocationId,
    );
  }
}
