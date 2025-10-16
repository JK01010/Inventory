class GoodsItem {
  GoodsItem({
    required this.name,
    required this.serialNo,
    required this.poQty,
    required this.receivedQty,
    required this.damageQty,
    required this.storeLocation,
    this.isBadCondition = false,
    this.isGroupTagged = false,
  });
  final String name;
  final int serialNo;
  final int poQty;
  final int receivedQty;
  final int damageQty;
  final String storeLocation;
  final bool isBadCondition;
  final bool isGroupTagged;
}
