import 'dart:convert';

class GoodsReceiptDTModel {
  final int? id;
  final int? grnhdid;
  final int? itemId;
  final int? itemVersionId;
  final int? itemLinkId;
  final int? parentItemId;
  final int? parentItemVersionId;
  final int? parentItemLinkId;
  final int? receivedQty;
  final int? convertedStockQty;
  final int? newStock;
  final int? damagedOrWrongSupply;
  final int? reconditionedStock;
  final dynamic expiryDate;
  final int? uomid;
  final int? qualityId;
  final String? batchNo;
  final String? remarks;
  final int? versionIdentifier;
  final int? orgId;
  final String? operationType;
  final bool? isIhm;
  final int? bagTagLocationId;
  final bool? isBagTagRequired;
  final bool? isBagTagItem;
  final int? podtid;
  final int? defaultLocationId;
  final int? sortOrder;
  final String? itemStatusCode;
  final int? actualReceivedQty;
  final int? conversionFactor;

  GoodsReceiptDTModel({
    this.id,
    this.grnhdid,
    this.itemId,
    this.itemVersionId,
    this.itemLinkId,
    this.parentItemId,
    this.parentItemVersionId,
    this.parentItemLinkId,
    this.receivedQty,
    this.convertedStockQty,
    this.newStock,
    this.damagedOrWrongSupply,
    this.reconditionedStock,
    this.expiryDate,
    this.uomid,
    this.qualityId,
    this.batchNo,
    this.remarks,
    this.versionIdentifier,
    this.orgId,
    this.operationType,
    this.isIhm,
    this.bagTagLocationId,
    this.isBagTagRequired,
    this.isBagTagItem,
    this.podtid,
    this.defaultLocationId,
    this.sortOrder,
    this.itemStatusCode,
    this.actualReceivedQty,
    this.conversionFactor,
  });

  GoodsReceiptDTModel copyWith({
    int? id,
    int? grnhdid,
    int? itemId,
    int? itemVersionId,
    int? itemLinkId,
    int? parentItemId,
    int? parentItemVersionId,
    int? parentItemLinkId,
    int? receivedQty,
    int? convertedStockQty,
    int? newStock,
    int? damagedOrWrongSupply,
    int? reconditionedStock,
    dynamic expiryDate,
    int? uomid,
    int? qualityId,
    String? batchNo,
    String? remarks,
    int? versionIdentifier,
    int? orgId,
    String? operationType,
    bool? isIhm,
    int? bagTagLocationId,
    bool? isBagTagRequired,
    bool? isBagTagItem,
    int? podtid,
    int? defaultLocationId,
    int? sortOrder,
    String? itemStatusCode,
    int? actualReceivedQty,
    int? conversionFactor,
  }) =>
      GoodsReceiptDTModel(
        id: id ?? this.id,
        grnhdid: grnhdid ?? this.grnhdid,
        itemId: itemId ?? this.itemId,
        itemVersionId: itemVersionId ?? this.itemVersionId,
        itemLinkId: itemLinkId ?? this.itemLinkId,
        parentItemId: parentItemId ?? this.parentItemId,
        parentItemVersionId: parentItemVersionId ?? this.parentItemVersionId,
        parentItemLinkId: parentItemLinkId ?? this.parentItemLinkId,
        receivedQty: receivedQty ?? this.receivedQty,
        convertedStockQty: convertedStockQty ?? this.convertedStockQty,
        newStock: newStock ?? this.newStock,
        damagedOrWrongSupply: damagedOrWrongSupply ?? this.damagedOrWrongSupply,
        reconditionedStock: reconditionedStock ?? this.reconditionedStock,
        expiryDate: expiryDate ?? this.expiryDate,
        uomid: uomid ?? this.uomid,
        qualityId: qualityId ?? this.qualityId,
        batchNo: batchNo ?? this.batchNo,
        remarks: remarks ?? this.remarks,
        versionIdentifier: versionIdentifier ?? this.versionIdentifier,
        orgId: orgId ?? this.orgId,
        operationType: operationType ?? this.operationType,
        isIhm: isIhm ?? this.isIhm,
        bagTagLocationId: bagTagLocationId ?? this.bagTagLocationId,
        isBagTagRequired: isBagTagRequired ?? this.isBagTagRequired,
        isBagTagItem: isBagTagItem ?? this.isBagTagItem,
        podtid: podtid ?? this.podtid,
        defaultLocationId: defaultLocationId ?? this.defaultLocationId,
        sortOrder: sortOrder ?? this.sortOrder,
        itemStatusCode: itemStatusCode ?? this.itemStatusCode,
        actualReceivedQty: actualReceivedQty ?? this.actualReceivedQty,
        conversionFactor: conversionFactor ?? this.conversionFactor,
      );

  factory GoodsReceiptDTModel.fromRawJson(String str) => GoodsReceiptDTModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GoodsReceiptDTModel.fromJson(Map<String, dynamic> json) => GoodsReceiptDTModel(
    id: json["id"],
    grnhdid: json["grnhdid"],
    itemId: json["itemID"],
    itemVersionId: json["itemVersionID"],
    itemLinkId: json["itemLinkID"],
    parentItemId: json["parentItemID"],
    parentItemVersionId: json["parentItemVersionID"],
    parentItemLinkId: json["parentItemLinkID"],
    receivedQty: json["receivedQty"],
    convertedStockQty: json["convertedStockQty"],
    newStock: json["newStock"],
    damagedOrWrongSupply: json["damagedOrWrongSupply"],
    reconditionedStock: json["reconditionedStock"],
    expiryDate: json["expiryDate"],
    uomid: json["uomid"],
    qualityId: json["qualityID"],
    batchNo: json["batchNo"],
    remarks: json["remarks"],
    versionIdentifier: json["versionIdentifier"],
    orgId: json["orgID"],
    operationType: json["operationType"],
    isIhm: json["isIhm"],
    bagTagLocationId: json["bagTagLocationId"],
    isBagTagRequired: json["isBagTagRequired"],
    isBagTagItem: json["isBagTagItem"],
    podtid: json["podtid"],
    defaultLocationId: json["defaultLocationId"],
    sortOrder: json["sortOrder"],
    itemStatusCode: json["itemStatusCode"],
    actualReceivedQty: json["actualReceivedQty"],
    conversionFactor: json["conversionFactor"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "grnhdid": grnhdid,
    "itemID": itemId,
    "itemVersionID": itemVersionId,
    "itemLinkID": itemLinkId,
    "parentItemID": parentItemId,
    "parentItemVersionID": parentItemVersionId,
    "parentItemLinkID": parentItemLinkId,
    "receivedQty": receivedQty,
    "convertedStockQty": convertedStockQty,
    "newStock": newStock,
    "damagedOrWrongSupply": damagedOrWrongSupply,
    "reconditionedStock": reconditionedStock,
    "expiryDate": expiryDate,
    "uomid": uomid,
    "qualityID": qualityId,
    "batchNo": batchNo,
    "remarks": remarks,
    "versionIdentifier": versionIdentifier,
    "orgID": orgId,
    "operationType": operationType,
    "isIhm": isIhm,
    "bagTagLocationId": bagTagLocationId,
    "isBagTagRequired": isBagTagRequired,
    "isBagTagItem": isBagTagItem,
    "podtid": podtid,
    "defaultLocationId": defaultLocationId,
    "sortOrder": sortOrder,
    "itemStatusCode": itemStatusCode,
    "actualReceivedQty": actualReceivedQty,
    "conversionFactor": conversionFactor,
  };
}