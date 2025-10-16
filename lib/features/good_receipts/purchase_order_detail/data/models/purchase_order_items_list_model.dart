import 'dart:convert';

import '../../../../common_feature/domain/entities/item_entity.dart';

PurchaseOrderItemsResponseModel purchaseOrderItemsResponseModelFromJson(
  String str,
) => PurchaseOrderItemsResponseModel.fromJson(json.decode(str));

String purchaseOrderItemsResponseModelToJson(
  PurchaseOrderItemsResponseModel data,
) => json.encode(data.toJson());

class PurchaseOrderItemsResponseModel {
  PurchaseOrderItemsResponseModel({
    this.moduleCode,
    this.entityName,
    this.reportData,
    this.recordCount,
    this.entityValidation,
  });

  factory PurchaseOrderItemsResponseModel.fromJson(Map<String, dynamic> json) =>
      PurchaseOrderItemsResponseModel(
        moduleCode: json["moduleCode"],
        entityName: json["entityName"],
        reportData:
            json["reportData"] == null
                ? []
                : List<PurchaseOrderItemsData>.from(
                  json["reportData"]!.map(
                    (x) => PurchaseOrderItemsData.fromJson(x),
                  ),
                ),
        recordCount: json["recordCount"],
        entityValidation:
            json["entityValidation"] == null
                ? null
                : EntityValidation.fromJson(json["entityValidation"]),
      );
  String? moduleCode;
  String? entityName;
  List<PurchaseOrderItemsData>? reportData;
  int? recordCount;
  EntityValidation? entityValidation;

  Map<String, dynamic> toJson() => {
    "moduleCode": moduleCode,
    "entityName": entityName,
    "reportData":
        reportData == null
            ? []
            : List<dynamic>.from(reportData!.map((x) => x.toJson())),
    "recordCount": recordCount,
    "entityValidation": entityValidation?.toJson(),
  };
}

class EntityValidation {
  EntityValidation({this.status, this.validationMessages});

  factory EntityValidation.fromJson(Map<String, dynamic> json) =>
      EntityValidation(
        status: json["status"],
        validationMessages:
            json["validationMessages"] == null
                ? []
                : List<dynamic>.from(json["validationMessages"]!.map((x) => x)),
      );
  bool? status;
  List<dynamic>? validationMessages;

  Map<String, dynamic> toJson() => {
    "status": status,
    "validationMessages":
        validationMessages == null
            ? []
            : List<dynamic>.from(validationMessages!.map((x) => x)),
  };
}

class PurchaseOrderItemsData {
  PurchaseOrderItemsData({
    this.poDtId,
    this.slNo,
    this.partNumber,
    this.productName,
    this.uomId,
    this.packSize,
    this.quantity,
    this.rob,
    this.productDescription,
    this.unitPrice,
    this.contractPrice,
    this.discountPercentage,
    this.discount,
    this.vatId,
    this.vatPercentage,
    this.accountId,
    this.accountCode,
    this.accountName,
    this.subAccountId,
    this.subAccountCode,
    this.subAccountName,
    this.analysisCodeId,
    this.analysisCode,
    this.analysisName,
    this.leadDays,
    this.vendorDeliveryDate,
    this.remarksToVendor,
    this.isMd,
    this.isSdoc,
    this.zeroDeclaration,
    this.ihmMaterialQty,
    this.eccnNo,
    this.hsCode,
    this.countryName,
    this.partNo,
    this.categoryName,
    this.itemCategoryId,
    this.itemSectionId,
    this.sectionName,
    this.itemSubSectionId,
    this.subSectionName,
    this.vessel,
    this.entity,
    this.entityId,
    this.poHdId,
    this.exchangeRateVesselCurrency,
    this.exchangeRateGroupCurrency,
    this.budgetDate,
    this.invoiceStatus,
    this.totalPoCurrency,
    this.totalBaseCurrency,
    this.totalReportingCurrency,
    this.itemId,
    this.articleNumber,
    this.itemUom,
    this.packUom,
    this.serviceDescription,
    this.equipmentName,
    this.equipmentDescription,
    this.equipmentModelNumber,
    this.equipmentSerialNo,
    this.equipmentManufacturer,
    this.deliveryCode,
    this.deliveryTypeName,
    this.uniqueItemReference,
    this.isDeleted,
    this.itemLinkId,
    this.itemVersionId,
    this.parentId,
    this.parentItemLinkId,
    this.parentItemVersionId,
    this.imdgCode,
    this.imdgName,
    this.exportControl,
    this.drawingNumber,
    this.receivedQuantity,
    this.damagedQuantity,
    this.newStockQuantity,
    this.reconditionedQuantity,
    this.expiryDate,
    this.qualityId,
    this.batchNo,
    this.remarks,
    this.isSync = 1,
  });

  factory PurchaseOrderItemsData.fromJson(Map<String, dynamic> json) =>
      PurchaseOrderItemsData(
        poDtId: json["PODTID"],
        slNo: json["SLNO"],
        partNumber: json["PartNumber"],
        productName: json["ProductName"],
        uomId: json["uomId"],
        packSize: json["PackSize"],
        quantity: json["Quantity"],
        rob: json["ROB"],
        productDescription: json["ProductDescription"],
        unitPrice: json["UnitPrice"],
        contractPrice: json["ContractPrice"],
        discountPercentage: json["DiscountPercentage"],
        discount: json["Discount"],
        vatId: json["VATID"],
        vatPercentage: json["VATPercentage"],
        accountId: json["AccountID"],
        accountCode: json["AccountCode"],
        accountName: json["AccountName"],
        subAccountId: json["SubAccountID"],
        subAccountCode: json["SubAccountCode"],
        subAccountName: json["SubAccountName"],
        analysisCodeId: json["AnalysisCodeID"],
        analysisCode: json["AnalysisCode"],
        analysisName: json["AnalysisName"],
        leadDays: json["LeadDays"],
        vendorDeliveryDate:
            json["VendorDeliveryDate"] == null
                ? null
                : DateTime.parse(json["VendorDeliveryDate"]),
        remarksToVendor: json["RemarksToVendor"],
        isMd:
            json["IsMD"] != null
                ? json["IsMD"].runtimeType == bool
                    ? json["IsMD"]
                    : json["IsMD"] == 1
                    ? true
                    : false
                : false,
        isSdoc:
            json["IsSDOC"] != null
                ? json["IsSDOC"].runtimeType == bool
                    ? json["IsSDOC"]
                    : json["IsSDOC"] == 1
                    ? true
                    : false
                : false,
        zeroDeclaration:
            json["ZeroDeclaration"] != null
                ? json["ZeroDeclaration"].runtimeType == bool
                    ? json["ZeroDeclaration"]
                    : json["ZeroDeclaration"] == 1
                    ? true
                    : false
                : false,
        ihmMaterialQty: json["IHMMaterialQty"],
        eccnNo: json["EccnNo"],
        hsCode: json["HSCode"],
        countryName: json["CountryName"],
        partNo: json["PARTNO"],
        categoryName: json["CategoryName"],
        itemCategoryId: json["ItemCategoryID"],
        itemSectionId: json["ItemSectionID"],
        sectionName: json["SectionName"],
        itemSubSectionId: json["ItemSubSectionID"],
        subSectionName: json["SubSectionName"],
        vessel: json["Vessel"],
        entity: json["Entity"],
        entityId: json["EntityID"],
        poHdId: json["POHDID"],
        exchangeRateVesselCurrency: json["ExchangeRateVesselCurrency"],
        exchangeRateGroupCurrency: json["ExchangeRateGroupCurrency"],
        budgetDate:
            json["BudgetDate"] == null
                ? null
                : DateTime.parse(json["BudgetDate"]),
        invoiceStatus: json["InvoiceStatus"],
        totalPoCurrency: json["TotalPOCurrency"],
        totalBaseCurrency: json["TotalBaseCurrency"],
        totalReportingCurrency: json["TotalReportingCurrency"],
        itemId: json["ItemId"],
        articleNumber: json["ArticleNumber"],
        itemUom: json["ItemUom"],
        packUom: json["PackUOM"],
        serviceDescription: json["ServiceDescription"],
        equipmentName: json["EquipmentName"],
        equipmentDescription: json["EquipmentDescription"],
        equipmentModelNumber: json["EquipmentModelNumber"],
        equipmentSerialNo: json["EquimentSerialNo"],
        equipmentManufacturer: json["EquipmentManufacturer"],
        deliveryCode: json["DeliveryCode"],
        deliveryTypeName: json["DeliveryTypeName"],
        uniqueItemReference: json["UniqueItemReference"],
        isDeleted:
            json["IsDeleted"] != null
                ? json["IsDeleted"].runtimeType == bool
                    ? json["IsDeleted"]
                    : json["IsDeleted"] == 1
                    ? true
                    : false
                : false,
        itemLinkId: json["ItemLinkID"],
        itemVersionId: json["ItemVersionID"],
        parentId: json["ParentID"],
        parentItemLinkId: json["ParentItemLinkID"],
        parentItemVersionId: json["ParentItemVersionID"],
        imdgCode: json["IMDGCode"],
        imdgName: json["IMDGName"],
        exportControl: json["ExportControl"],
        drawingNumber: json["DrawingNumber"],
        receivedQuantity: json["ReceivedQty"],
        damagedQuantity: json["DamagedQty"],
        newStockQuantity: json["NewStockQty"],
        reconditionedQuantity: json["ReconditionedStockQty"],
        expiryDate: json['ExpiryDate'],
        qualityId: json['QualityID'],
        batchNo: json['BatchNo'],
        remarks: json['Remarks'],
        isSync: json["isSync"] ?? 1,
      );
  int? poDtId;
  int? slNo;
  String? partNumber;
  String? productName;
  int? uomId;
  double? packSize;
  double? quantity;
  int? rob;
  String? productDescription;
  double? unitPrice;
  double? contractPrice;
  double? discountPercentage;
  double? discount;
  int? vatId;
  double? vatPercentage;
  int? accountId;
  String? accountCode;
  String? accountName;
  int? subAccountId;
  String? subAccountCode;
  String? subAccountName;
  dynamic analysisCodeId;
  dynamic analysisCode;
  dynamic analysisName;
  double? leadDays;
  DateTime? vendorDeliveryDate;
  String? remarksToVendor;
  bool? isMd;
  bool? isSdoc;
  bool? zeroDeclaration;
  double? ihmMaterialQty;
  String? eccnNo;
  String? hsCode;
  String? countryName;
  String? partNo;
  String? categoryName;
  int? itemCategoryId;
  int? itemSectionId;
  String? sectionName;
  int? itemSubSectionId;
  String? subSectionName;
  String? vessel;
  String? entity;
  int? entityId;
  int? poHdId;
  double? exchangeRateVesselCurrency;
  double? exchangeRateGroupCurrency;
  DateTime? budgetDate;
  dynamic invoiceStatus;
  double? totalPoCurrency;
  double? totalBaseCurrency;
  double? totalReportingCurrency;
  int? itemId;
  String? articleNumber;
  String? itemUom;
  String? packUom;
  String? serviceDescription;
  dynamic equipmentName;
  dynamic equipmentDescription;
  dynamic equipmentModelNumber;
  dynamic equipmentSerialNo;
  dynamic equipmentManufacturer;
  dynamic deliveryCode;
  dynamic deliveryTypeName;
  String? uniqueItemReference;
  bool? isDeleted;
  int? itemLinkId;
  int? itemVersionId;
  int? parentId;
  int? parentItemLinkId;
  int? parentItemVersionId;
  String? imdgCode;
  String? imdgName;
  String? exportControl;
  dynamic drawingNumber;
  double? receivedQuantity;
  double? damagedQuantity;
  double? newStockQuantity;
  double? reconditionedQuantity;
  String? expiryDate;
  int? qualityId;
  String? batchNo;
  final int isSync;
  String? remarks;

  Map<String, dynamic> toJson() => {
    "PODTID": poDtId,
    "SLNO": slNo,
    "PartNumber": partNumber,
    "ProductName": productName,
    "uomId": uomId,
    "PackSize": packSize,
    "Quantity": quantity,
    "ROB": rob,
    "ProductDescription": productDescription,
    "UnitPrice": unitPrice,
    "ContractPrice": contractPrice,
    "DiscountPercentage": discountPercentage,
    "Discount": discount,
    "VATID": vatId,
    "VATPercentage": vatPercentage,
    "AccountID": accountId,
    "AccountCode": accountCode,
    "AccountName": accountName,
    "SubAccountID": subAccountId,
    "SubAccountCode": subAccountCode,
    "SubAccountName": subAccountName,
    "AnalysisCodeID": analysisCodeId,
    "AnalysisCode": analysisCode,
    "AnalysisName": analysisName,
    "LeadDays": leadDays,
    "VendorDeliveryDate": vendorDeliveryDate?.toIso8601String(),
    "RemarksToVendor": remarksToVendor,
    "IsMD": isMd == true ? 1 : 0,
    "IsSDOC": isSdoc == true ? 1 : 0,
    "ZeroDeclaration": zeroDeclaration == true ? 1 : 0,
    "IHMMaterialQty": ihmMaterialQty,
    "EccnNo": eccnNo,
    "HSCode": hsCode,
    "CountryName": countryName,
    "PARTNO": partNo,
    "CategoryName": categoryName,
    "ItemCategoryID": itemCategoryId,
    "ItemSectionID": itemSectionId,
    "SectionName": sectionName,
    "ItemSubSectionID": itemSubSectionId,
    "SubSectionName": subSectionName,
    "Vessel": vessel,
    "Entity": entity,
    "EntityID": entityId,
    "POHDID": poHdId,
    "ExchangeRateVesselCurrency": exchangeRateVesselCurrency,
    "ExchangeRateGroupCurrency": exchangeRateGroupCurrency,
    "BudgetDate": budgetDate?.toIso8601String(),
    "InvoiceStatus": invoiceStatus,
    "TotalPOCurrency": totalPoCurrency,
    "TotalBaseCurrency": totalBaseCurrency,
    "TotalReportingCurrency": totalReportingCurrency,
    "ItemId": itemId,
    "ArticleNumber": articleNumber,
    "ItemUom": itemUom,
    "PackUOM": packUom,
    "ServiceDescription": serviceDescription,
    "EquipmentName": equipmentName,
    "EquipmentDescription": equipmentDescription,
    "EquipmentModelNumber": equipmentModelNumber,
    "EquimentSerialNo": equipmentSerialNo,
    "EquipmentManufacturer": equipmentManufacturer,
    "DeliveryCode": deliveryCode,
    "DeliveryTypeName": deliveryTypeName,
    "UniqueItemReference": uniqueItemReference,
    "IsDeleted": isDeleted == true ? 1 : 0,
    "ItemLinkID": itemLinkId,
    "ItemVersionID": itemVersionId,
    "ParentID": parentId,
    "ParentItemLinkID": parentItemLinkId,
    "ParentItemVersionID": parentItemVersionId,
    "IMDGCode": imdgCode,
    "IMDGName": imdgName,
    "ExportControl": exportControl,
    "DrawingNumber": drawingNumber,
    "ReceivedQty": receivedQuantity,
    "DamagedQty": damagedQuantity,
    "NewStockQty": newStockQuantity,
    "ReconditionedStockQty": reconditionedQuantity,
    "QualityID": qualityId,
    "ExpiryDate": expiryDate,
    "BatchNo": batchNo,
    "isSync": isSync,
  };

  ItemEntity toEntity() {
    return ItemEntity(
      poDtId: poDtId ?? -1,
      serialNumber: slNo ?? -1,
      expiryDate: expiryDate ?? '',
      partNumber: partNumber ?? '',
      productName: productName ?? '',
      packSize: packSize ?? -1,
      drawingNumber: drawingNumber ?? '',
      uom: itemUom ?? '',
      poQuantity: quantity ?? -1,
      unitPrice: unitPrice ?? -1,
      totalAcceptedQuantity: quantity ?? -1,
      returnQuantity: 0,
      imdgClass: imdgCode ?? '',
      remarksFromVendor: remarksToVendor ?? '',
      equipment: equipmentName ?? '',
      itemCategory: categoryName ?? '',
      itemSection: sectionName ?? '',
      itemSubSection: subSectionName ?? '',
      newStockQuantity: newStockQuantity ?? -1,
      reconditionedStock: reconditionedQuantity ?? -1,
      damagedQuantity: damagedQuantity ?? -1,
      batchNumber: batchNo ?? '',
      quality: '',
      remarks: remarks ?? '',
      defaultStorageLocation: '',
      itemId: itemId ?? -1,
      itemLinkId: itemLinkId ?? -1,
      articleNumber: articleNumber ?? '',
      grnId: -1,
      grnDtId: -1,
      poHdId: poHdId ?? -1,
      receivedQuantity: receivedQuantity ?? -1,
      qualityId: qualityId ?? -1,
      isMd: isMd ?? false,
      isSDoc: isSdoc ?? false,
      zeroDeclaration: zeroDeclaration ?? false,
      ihmMaterialQty: ihmMaterialQty ?? -1,
      rob: rob ?? -1,
      itemVersionId: itemVersionId ?? -1,
      parentItemId: parentId ?? -1,
      parentItemVersionId: parentItemVersionId ?? -1,
      parentItemLinkId: parentItemLinkId ?? -1,
      uomId: uomId ?? -1,
      productDescription: productDescription ?? '',
      eccnNo: eccnNo ?? '',
      hsCode: hsCode ?? '',
      countryName: countryName ?? '',
      isAntiPiracy: false,
      isPyroTechnics: false,
      imdgClassId: -1,
      itemCategoryId: itemCategoryId ?? -1,
      itemSectionId: itemSectionId ?? -1,
      itemSubSectionId: itemSubSectionId ?? -1,
      //ToDo
      isExportControl: exportControl == "YES" ? true : false,
      isIhm: false,
      isCritical: false,
      isImdg: false,
      vessel: vessel ?? '',
      isBagTagItem: false,
      drawingPositionNumber: '',
      equipmentId: -1,
      itemUom: itemUom ?? '',
    );
  }
}
