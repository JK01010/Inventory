class StockUpdateRfidListingViewEntity {
  StockUpdateRfidListingViewEntity({
    required this.itemId,
    required this.itemName,
    required this.itemCode,
    required this.rfidId,
    required this.rob,
    required this.articleNo,
    required this.storageLocation,
    required this.installedOnLocation,
    required this.defaultStorageLocationId,
    required this.ihm,
    required this.mdRequired,
    required this.sDocRequired,
    required this.zeroDeclaration,
    required this.newStock,
    required this.reconditionStock,


    this.newStockController,
    this.reconditionStockController,

    this.showErrorConsumedQty,

    this.remarkController,
    this.isSelected,
  });

  final int itemId;
  final String itemName;
  final String itemCode;
  final String rfidId;
  final int rob;
  final String articleNo;
  final String storageLocation;
  final String installedOnLocation;
  final int ihm;
  final int mdRequired;
  final int sDocRequired;
  final int zeroDeclaration;

  final int newStock;
  final int reconditionStock;

  bool? isSelected;
  String? remarkController;
  String? newStockController;
  String? reconditionStockController;

  bool? showErrorConsumedQty;

  final int defaultStorageLocationId;

  StockUpdateRfidListingViewEntity copyWith({
    int? itemId,
    String? itemName,
    String? itemCode,
    String? rfidId,
    int? rob,
    String? articleNo,
    String? storageLocation,
    String? installedOnLocation,
    String? remarkController,
    String? newStockController,
    String? reconditionStockController,
    int? newStock,
    int? reconditionStock,

    bool? showErrorConsumedQty = false,
    int? defaultStorageLocationId,
    bool? isSelected,
    int? ihm,
    int? mdRequired,
    int? sDocRequired,
    int? zeroDeclaration,
  }) {
    return StockUpdateRfidListingViewEntity(
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      itemCode: itemCode ?? this.itemCode,
      rfidId: rfidId ?? this.rfidId,
      rob: rob ?? this.rob,
      articleNo: articleNo ?? this.articleNo,
      storageLocation: storageLocation ?? this.storageLocation,
      installedOnLocation: installedOnLocation ?? this.installedOnLocation,
      defaultStorageLocationId:
          defaultStorageLocationId ?? this.defaultStorageLocationId,
      showErrorConsumedQty: showErrorConsumedQty ?? this.showErrorConsumedQty,

      remarkController: remarkController ?? this.remarkController,
      newStockController: newStockController ?? this.newStockController,
      reconditionStockController:reconditionStockController ?? this.reconditionStockController,
      isSelected: isSelected ?? this.isSelected,
      ihm: ihm ?? this.ihm,
      mdRequired: mdRequired ?? this.mdRequired,
      sDocRequired: sDocRequired ?? this.sDocRequired,
      zeroDeclaration: zeroDeclaration ?? this.zeroDeclaration,
      newStock: newStock ?? this.newStock,
      reconditionStock: reconditionStock ?? this.reconditionStock,

    );
  }
}
