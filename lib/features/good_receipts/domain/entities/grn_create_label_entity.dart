class GRNCreateLabelEntity {
  final int itemId;
  final String articleCode;
  final String itemName;
  final int uomId;
  final String uom;
  final String partNumber;
  final String drawingNumber;
  final String drawingPositionNumber;
  final String receiptDate;
  final int storageLocationId;
  final String storageLocationName;
  final String serialNumber;
  final int grnHdId;

  const GRNCreateLabelEntity({
    required this.itemId,
    required this.articleCode,
    required this.itemName,
    required this.uomId,
    required this.uom,
    required this.partNumber,
    required this.drawingNumber,
    required this.drawingPositionNumber,
    required this.receiptDate,
    required this.storageLocationId,
    required this.storageLocationName,
    required this.serialNumber,
    required this.grnHdId,
  });
}
