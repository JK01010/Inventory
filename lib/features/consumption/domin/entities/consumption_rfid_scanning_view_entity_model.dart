class ConsumptionRfidListingViewEntity {
  ConsumptionRfidListingViewEntity({
    required this.itemId,
    required this.itemName,
    required this.itemCode,
    required this.rfidId,
    required this.rob,
    required this.articleNo,
    required this.storageLocation,
    required this.equipmentFlag,
    required this.installedOnLocation,

    this.isSelected,
    required this.defaultStorageLocationId,
    this.robTextController,
    this.newStockController,
    this.reconditionStockController,
    this.showErrorConsumedQty,
    this.showErrorConsumedQtyRob,
    this.remarkController,
    this.isLocationSelected,
    this.isEquipmentSelected,
    this.selectedEquipmentName,
    this.selectedEquipmentId,
    this.selectedLocationName,
    this.selectedLocationId,
    required this.ihm,
    required this.mdRequired,
    required this.sDocRequired,
    required this.zeroDeclaration,
    required this.newStock,
    required this.reconditionStock,
  });

  final int itemId;
  final String itemName;
  final String itemCode;
  final String rfidId;
  final int rob;
  final String articleNo;
  final String storageLocation;
  final String installedOnLocation;
  final String equipmentFlag;
  final int defaultStorageLocationId;
  final int ihm;
  final int mdRequired;
  final int sDocRequired;
  final int zeroDeclaration;
  final int newStock;
  final int reconditionStock;

  bool? isSelected;
  String? remarkController;
  String? robTextController;
  String? newStockController;
  String? reconditionStockController;
  bool? showErrorConsumedQty;
  bool? showErrorConsumedQtyRob;

  bool? isLocationSelected;
  bool? isEquipmentSelected;

  String? selectedEquipmentName;
  int? selectedEquipmentId;
  String? selectedLocationName;
  int? selectedLocationId;

  ConsumptionRfidListingViewEntity copyWith({
    int? itemId,
    String? itemName,
    String? itemCode,
    String? rfidId,
    int? rob,
    String? articleNo,
    String? storageLocation,
    String? installedOnLocation,
    String? equipmentFlag,
    bool? isSelected,
    int? defaultStorageLocationId,
    bool? showErrorConsumedQty = false,
    bool? showErrorConsumedQtyRob = false,
    String? remarkController,
    String? robTextController,
    String? newStockController,
    String? reconditionStockController,
    bool? isLocationSelected,
    bool? isEquipmentSelected,
    String? selectedEquipmentName,
    int? selectedEquipmentId,
    String? selectedLocationName,
    int? selectedLocationId,
    int? ihm,
    int? mdRequired,
    int? sDocRequired,
    int? zeroDeclaration,
    int? newStock,
    int? reconditionStock
  }) {
    return ConsumptionRfidListingViewEntity(
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      itemCode: itemCode ?? this.itemCode,
      rfidId: rfidId ?? this.rfidId,
      rob: rob ?? this.rob,
      articleNo: articleNo ?? this.articleNo,
      storageLocation: storageLocation ?? this.storageLocation,
      equipmentFlag: equipmentFlag ?? this.equipmentFlag,
      installedOnLocation: installedOnLocation ?? this.installedOnLocation,
      isSelected: isSelected ?? this.isSelected,
      defaultStorageLocationId:
          defaultStorageLocationId ?? this.defaultStorageLocationId,
      showErrorConsumedQty: showErrorConsumedQty ?? this.showErrorConsumedQty,
      showErrorConsumedQtyRob:
          showErrorConsumedQtyRob ?? this.showErrorConsumedQtyRob,
      remarkController: remarkController ?? this.remarkController,
      robTextController:
          robTextController ?? this.robTextController,
      isLocationSelected: isLocationSelected ?? this.isLocationSelected,
      isEquipmentSelected: isEquipmentSelected ?? this.isEquipmentSelected,
      selectedEquipmentName:
          selectedEquipmentName ?? this.selectedEquipmentName,
      selectedEquipmentId: selectedEquipmentId ?? this.selectedEquipmentId,
      selectedLocationName: selectedLocationName ?? this.selectedLocationName,
      selectedLocationId: selectedLocationId ?? this.selectedLocationId,
      ihm: ihm ?? this.ihm,
      mdRequired: mdRequired ?? this.mdRequired,
      sDocRequired: sDocRequired ?? this.sDocRequired,
      zeroDeclaration: zeroDeclaration ?? this.zeroDeclaration,
      newStock: newStock ?? this.newStock,
      reconditionStock: reconditionStock ?? this.reconditionStock,
      newStockController: newStockController ?? this.newStockController,
      reconditionStockController:
          reconditionStockController ?? this.reconditionStockController
    );
  }
}
