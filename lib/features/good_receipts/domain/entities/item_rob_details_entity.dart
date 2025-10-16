class ItemRobDetailsEntity {
  final int? storageLocationId;
  final String? storageLocation;
  final String? storageLocationHierarchy;
  final int? referenceId;
  final int? referenceSubId;
  final int? referenceTypeId;
  final int? itemId;
  final int? itemLinkId;
  final String? inventoryDate;
  final String? expiryDate;
  final double? totalROB;
  final double? newStock;
  final double? reconditionedStock;
  final double? receivedQty;

  const ItemRobDetailsEntity({
    this.storageLocationId,
    this.storageLocation,
    this.storageLocationHierarchy,
    this.referenceId,
    this.referenceSubId,
    this.referenceTypeId,
    this.itemId,
    this.itemLinkId,
    this.inventoryDate,
    this.expiryDate,
    this.totalROB,
    this.newStock,
    this.reconditionedStock,
    this.receivedQty,
  });

  ItemRobDetailsEntity copyWith({
    int? storageLocationId,
    String? storageLocation,
    String? storageLocationHierarchy,
    int? referenceId,
    int? referenceSubId,
    int? referenceTypeId,
    int? itemId,
    int? itemLinkId,
    String? inventoryDate,
    String? expiryDate,
    double? totalROB,
    double? newStock,
    double? reconditionedStock,
    double? receivedQty,
  }) {
    return ItemRobDetailsEntity(
      storageLocationId: storageLocationId ?? this.storageLocationId,
      storageLocation: storageLocation ?? this.storageLocation,
      storageLocationHierarchy:
      storageLocationHierarchy ?? this.storageLocationHierarchy,
      referenceId: referenceId ?? this.referenceId,
      referenceSubId: referenceSubId ?? this.referenceSubId,
      referenceTypeId: referenceTypeId ?? this.referenceTypeId,
      itemId: itemId ?? this.itemId,
      itemLinkId: itemLinkId ?? this.itemLinkId,
      inventoryDate: inventoryDate ?? this.inventoryDate,
      expiryDate: expiryDate ?? this.expiryDate,
      totalROB: totalROB ?? this.totalROB,
      newStock: newStock ?? this.newStock,
      reconditionedStock: reconditionedStock ?? this.reconditionedStock,
      receivedQty: receivedQty ?? this.receivedQty,
    );
  }
}
