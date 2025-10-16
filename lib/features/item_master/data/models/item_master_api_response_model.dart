import 'package:equatable/equatable.dart';

import '../../../common_feature/data/model/fetch_imdg_class_model.dart';


class ItemMasterApiResponseModelPurchase extends Equatable {
  const ItemMasterApiResponseModelPurchase({
    required this.moduleCode,
    required this.entityName,
    required this.recordCount,
    required this.reportData,
    required this.entityValidation,
  });

  factory ItemMasterApiResponseModelPurchase.fromJson(Map<String, dynamic> map) {
    return ItemMasterApiResponseModelPurchase(
      moduleCode: map['moduleCode'] ?? '',
      entityName: map['entityName'] ?? '',
      recordCount: map['recordCount'] ?? 0,
      reportData: List<ItemMasterApiModelPurchase>.from(
        (map['reportData'] as List).map(
              (x) => ItemMasterApiModelPurchase.fromJson(x as Map<String, dynamic>),
        ),
      ),
      entityValidation: EntityValidation.fromMap(map['entityValidation']),
    );
  }

  final String moduleCode;
  final String entityName;
  final int recordCount;
  final List<ItemMasterApiModelPurchase>? reportData;
  final EntityValidation entityValidation;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'moduleCode': moduleCode,
      'entityName': entityName,
      'recordCount': recordCount,
      'reportData': reportData?.map((x) => x.toJson()).toList(),
      'entityValidation': entityValidation.toMap(),
    };
  }

  @override
  List<Object?> get props => [
    moduleCode,
    entityName,
    recordCount,
    reportData,
    entityValidation,
  ];

  @override
  bool? get stringify => true;
}

class ItemMasterApiModelPurchase extends Equatable {
  const ItemMasterApiModelPurchase({
    required this.groupId,
    required this.itemID,
    required this.itemId,
    required this.itemCode,
    required this.itemName,
    required this.itemDescription,
    required this.uomId,
    required this.uomCode,
    required this.uomName,
    required this.packagingUOM,
    required this.isActive,
    required this.categoryId,
    required this.categoryCode,
    required this.categoryName,
    required this.sectionId,
    required this.sectionCode,
    required this.sectionName,
    required this.subSectionId,
    required this.subsectionCode,
    required this.subsectionName,
    required this.partNumber,
    required this.itemLinkId,
    required this.propertiesId,
    required this.propertyVersionNo,
    required this.versionNo,
    required this.itemSpecification,
    required this.isExportControl,
    required this.isIhm,
    required this.isImdg,
    required this.usContent,
    required this.imdgClass,
    required this.md,
    required this.sdoc,
    required this.eccnNo,
    required this.hsCode,
    required this.countryOfOrigin,
    required this.packSize,
    required this.tbn,
    required this.density,
    required this.isAntiPiracy,
    required this.uomQuantity,
    required this.packagingUOMId,
    required this.reOrderQuantity
  });

  /// Factory to create model from JSON map
  factory ItemMasterApiModelPurchase.fromJson(Map<String, dynamic> map) {
    return ItemMasterApiModelPurchase(
      groupId: map['GroupId'] as int? ?? 0,
      itemID: map['ItemID'] as int? ?? 0,
      itemId: map['itemId'] as int? ?? 0,
      itemCode: map['ItemCode'] as String? ?? '',
      itemName: map['ItemName'] as String? ?? '',
      itemDescription: map['ItemDescription'] as String? ?? '',
      uomId: map['UomID'] as int? ?? 0,
      uomCode: map['UomCode'] as String? ?? '',
      uomName: map['UomName'] as String? ?? '',
      packagingUOM: map['PackagingUOM'] as String? ?? '',
      isActive: map['IsActive'] as bool? ?? false,
      categoryId: map['CategoryID'] as int? ?? 0,
      categoryCode: map['CategoryCode'] as String? ?? '',
      categoryName: map['CategoryName'] as String? ?? '',
      sectionId: map['SectionID'] as int? ?? 0,
      sectionCode: map['SectionCode'] as String? ?? '',
      sectionName: map['SectionName'] as String? ?? '',
      subSectionId: map['SubSectionID'] as int? ?? 0,
      subsectionCode: map['SubsectionCode'] as String? ?? '',
      subsectionName: map['SubsectionName'] as String? ?? '',
      partNumber: map['PartNumber'] as String? ?? '',
      itemLinkId: map['ItemLinkID'] as int? ?? 0,
      propertiesId: map['PropertiesID'] as int? ?? 0,
      propertyVersionNo: map['PropertyVersionNO'] as int? ?? 0,
      versionNo: map['VersionNo'] as int? ?? 0,
      itemSpecification: map['ItemSpecification'] as String? ?? '',
      isExportControl: map['IsExportControl'] as bool? ?? false,
      isIhm: map['IsIHM'] as bool? ?? false,
      isImdg: map['IsIMDG'] as bool? ?? false,
      usContent: map['UsContent'] as String? ?? '',
      imdgClass: map['IMDGClass'] as String? ?? '',
      md: map['MD'] as bool? ?? false,
      sdoc: map['Sdoc'] as bool? ?? false,
      eccnNo: map['EccnNo'] as String? ?? '',
      hsCode: map['HsCode'] as String? ?? '',
      countryOfOrigin: map['CountryOfOrgin'] as String? ?? '',
      packSize: (map['PackSize'] as num?)?.toDouble() ?? 0.0,
      tbn: map['TBN'] as String? ?? '',
      density: (map['Density'] as num?)?.toDouble() ?? 0.0,
      isAntiPiracy: map['IsAntiPiracy'] as bool? ?? false,
      uomQuantity: map['UOMQuantity'] as int? ?? 0,
      packagingUOMId: map['PackagingUOMID'] as int? ?? 0,
      reOrderQuantity: map['ReOrderQuantity'] as int? ?? 0
    );
  }

  /// Convert to JSON map
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'GroupId': groupId,
      'ItemID': itemID,
      'itemId': itemId,
      'ItemCode': itemCode,
      'ItemName': itemName,
      'ItemDescription': itemDescription,
      'UomID': uomId,
      'UomCode': uomCode,
      'UomName': uomName,
      'PackagingUOM': packagingUOM,
      'IsActive': isActive,
      'CategoryID': categoryId,
      'CategoryCode': categoryCode,
      'CategoryName': categoryName,
      'SectionID': sectionId,
      'SectionCode': sectionCode,
      'SectionName': sectionName,
      'SubSectionID': subSectionId,
      'SubsectionCode': subsectionCode,
      'SubsectionName': subsectionName,
      'PartNumber': partNumber,
      'ItemLinkID': itemLinkId,
      'PropertiesID': propertiesId,
      'PropertyVersionNO': propertyVersionNo,
      'VersionNo': versionNo,
      'ItemSpecification': itemSpecification,
      'IsExportControl': isExportControl,
      'IsIHM': isIhm,
      'IsIMDG': isImdg,
      'UsContent': usContent,
      'IMDGClass': imdgClass,
      'MD': md,
      'Sdoc': sdoc,
      'EccnNo': eccnNo,
      'HsCode': hsCode,
      'CountryOfOrgin': countryOfOrigin,
      'PackSize': packSize,
      'TBN': tbn,
      'Density': density,
      'IsAntiPiracy': isAntiPiracy,
      'UOMQuantity': uomQuantity,
      'PackagingUOMID': packagingUOMId,
      'ReOrderQuantity': reOrderQuantity
    };
  }

  // Fields
  final int groupId;
  final int itemID;
  final int itemId;
  final String itemCode;
  final String itemName;
  final String itemDescription;
  final int uomId;
  final String uomCode;
  final String uomName;
  final String packagingUOM;
  final bool isActive;
  final int categoryId;
  final String categoryCode;
  final String categoryName;
  final int sectionId;
  final String sectionCode;
  final String sectionName;
  final int subSectionId;
  final String subsectionCode;
  final String subsectionName;
  final String partNumber;
  final int itemLinkId;
  final int propertiesId;
  final int propertyVersionNo;
  final int versionNo;
  final String itemSpecification;
  final bool isExportControl;
  final bool isIhm;
  final bool isImdg;
  final String usContent;
  final String imdgClass;
  final bool md;
  final bool sdoc;
  final String eccnNo;
  final String hsCode;
  final String countryOfOrigin;
  final double packSize;
  final String tbn;
  final double density;
  final bool isAntiPiracy;
  final int uomQuantity;
  final int packagingUOMId;
  final int reOrderQuantity;

  @override
  List<Object?> get props => [
    groupId,
    itemID,
    itemCode,
    itemName,
    itemDescription,
    uomId,
    uomCode,
    uomName,
    packagingUOM,
    isActive,
    categoryId,
    categoryCode,
    categoryName,
    sectionId,
    sectionCode,
    sectionName,
    subSectionId,
    subsectionCode,
    subsectionName,
    partNumber,
    itemLinkId,
    propertiesId,
    propertyVersionNo,
    versionNo,
    itemSpecification,
    isExportControl,
    isIhm,
    isImdg,
    usContent,
    imdgClass,
    md,
    sdoc,
    eccnNo,
    hsCode,
    countryOfOrigin,
    packSize,
    tbn,
    density,
    isAntiPiracy,
    uomQuantity,
    packagingUOMId,
    reOrderQuantity
  ];

  @override
  bool? get stringify => true;
}


class ItemMasterApiResponseModelPms extends Equatable {
  const ItemMasterApiResponseModelPms({
    required this.moduleCode,
    required this.entityName,
    required this.recordCount,
    required this.reportData,
    required this.entityValidation,
  });

  factory ItemMasterApiResponseModelPms.fromJson(Map<String, dynamic> map) {
    return ItemMasterApiResponseModelPms(
      moduleCode: map['moduleCode'] ?? '',
      entityName: map['entityName'] ?? '',
      recordCount: map['recordCount'] ?? 0,
      reportData: List<ItemMasterApiModelPMS>.from(
        (map['reportData'] as List).map(
              (x) => ItemMasterApiModelPMS.fromJson(x as Map<String, dynamic>),
        ),
      ),
      entityValidation: EntityValidation.fromMap(map['entityValidation']),
    );
  }

  final String moduleCode;
  final String entityName;
  final int recordCount;
  final List<ItemMasterApiModelPMS>? reportData;
  final EntityValidation entityValidation;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'moduleCode': moduleCode,
      'entityName': entityName,
      'recordCount': recordCount,
      'reportData': reportData?.map((x) => x.toJson()).toList(),
      'entityValidation': entityValidation.toMap(),
    };
  }

  @override
  List<Object?> get props => [
    moduleCode,
    entityName,
    recordCount,
    reportData,
    entityValidation,
  ];

  @override
  bool? get stringify => true;
}
class ItemMasterApiModelPMS extends Equatable {
  const ItemMasterApiModelPMS({
    required this.groupId,
    required this.itemID,
    required this.itemId,
    required this.itemCode,
    required this.itemName,
    required this.itemDescription,
    required this.uomId,
    required this.uomCode,
    required this.uomName,
    required this.packagingUOM,
    required this.isActive,
    required this.categoryId,
    required this.categoryCode,
    required this.categoryName,
    required this.sectionId,
    required this.sectionCode,
    required this.sectionName,
    required this.subSectionId,
    required this.subsectionCode,
    required this.subsectionName,
    required this.partNumber,
    required this.itemLinkId,
    required this.propertiesId,
    required this.propertyVersionNo,
    required this.versionNo,
    required this.itemSpecification,
    required this.isExportControl,
    required this.isIhm,
    required this.isImdg,
    required this.usContent,
    required this.imdgClass,
    required this.md,
    required this.sdoc,
    required this.eccnNo,
    required this.hsCode,
    required this.countryOfOrigin,
    required this.packSize,
    required this.tbn,
    required this.density,
    required this.isAntiPiracy,
    required this.uomQuantity,
    required this.packagingUOMId,
    required this.reOrderQuantity,
    required this.equipmentName,
    required this.equipmentCode,
    required this.spareId,
    required this.minStock,
    required this.maxStock,
    required this.drawingNumber,
    required this.unit,
    required this.articleNumber,
    required this.vesselEquipmentID,
    required this.parentEquipmentID,
    required this.parentEquipmentName,
    required this.parentEquipmentCode,
    required this.makerID,
    required this.makerName,
    required this.modelID,
    required this.model,
    required this.equipmentTypeID,
    required this.equipTypeName,
    required this.positionNumber,
    required this.specification,
    required this.isCritical,
    required this.vesselComponentID,
    required this.referenceID,
    required this.referenceTypeID,
    required this.referenceSubID,
  });

  /// Factory to create model from JSON map
  factory ItemMasterApiModelPMS.fromJson(Map<String, dynamic> map) {
    return ItemMasterApiModelPMS(
      groupId: map['GroupId'] as int? ?? 0,
      itemID: map['ItemID'] as int? ?? 0,
      itemId: map['itemId'] as int? ?? 0,
      itemCode: map['ItemCode'] as String? ?? '',
      itemName: map['ItemName'] as String? ?? '',
      itemDescription: map['ItemDescription'] as String? ?? '',
      uomId: map['UomID'] as int? ?? 0,
      uomCode: map['UomCode'] as String? ?? '',
      uomName: map['UomName'] as String? ?? '',
      packagingUOM: map['PackagingUOM'] as String? ?? '',
      isActive: map['IsActive'] as bool? ?? false,
      categoryId: map['CategoryID'] as int? ?? 0,
      categoryCode: map['CategoryCode'] as String? ?? '',
      categoryName: map['CategoryName'] as String? ?? '',
      sectionId: map['SectionID'] as int? ?? 0,
      sectionCode: map['SectionCode'] as String? ?? '',
      sectionName: map['SectionName'] as String? ?? '',
      subSectionId: map['SubSectionID'] as int? ?? 0,
      subsectionCode: map['SubsectionCode'] as String? ?? '',
      subsectionName: map['SubsectionName'] as String? ?? '',
      partNumber: map['PartNumber'] as String? ?? '',
      itemLinkId: map['ItemLinkID'] as int? ?? 0,
      propertiesId: map['PropertiesID'] as int? ?? 0,
      propertyVersionNo: map['PropertyVersionNO'] as int? ?? 0,
      versionNo: map['VersionNo'] as int? ?? 0,
      itemSpecification: map['ItemSpecification'] as String? ?? '',
      isExportControl: map['IsExportControl'] as bool? ?? false,
      isIhm: map['IsIHM'] as bool? ?? false,
      isImdg: map['IsIMDG'] as bool? ?? false,
      usContent: map['UsContent'] as String? ?? '',
      imdgClass: map['IMDGClass'] as String? ?? '',
      md: map['MD'] as bool? ?? false,
      sdoc: map['Sdoc'] as bool? ?? false,
      eccnNo: map['EccnNo'] as String? ?? '',
      hsCode: map['HsCode'] as String? ?? '',
      countryOfOrigin: map['CountryOfOrgin'] as String? ?? '',
      packSize: (map['PackSize'] as num?)?.toDouble() ?? 0.0,
      tbn: map['TBN'] as String? ?? '',
      density: (map['Density'] as num?)?.toDouble() ?? 0.0,
      isAntiPiracy: map['IsAntiPiracy'] as bool? ?? false,
      uomQuantity: map['UOMQuantity'] as int? ?? 0,
      packagingUOMId: map['PackagingUOMID'] as int? ?? 0,
      reOrderQuantity: map['ReOrderQuantity'] as int? ?? 0,
      equipmentName: map['equipmentName'] as String? ?? '',
      equipmentCode: map['equipmentCode'] as String? ?? '',
      spareId: map['spareID'] as int? ?? 0,
      minStock: map['minStock'] as int? ?? 0,
      maxStock: map['maxStock'] as int? ?? 0,
      drawingNumber: map['drawingNumber'] as String? ?? '',
      unit: map['unit'] as String? ?? '',
      articleNumber: map['articleNumber'] as String? ?? '',
      vesselEquipmentID: map['vesselEquipmentID'] as int? ?? 0,
      parentEquipmentID: map['parentEquipmentID'] as int? ?? 0,
      parentEquipmentName: map['parentEquipmentName'] as String? ?? '',
      parentEquipmentCode: map['parentEquipmentCode'] as String? ?? '',
      makerID: map['makerID'] as int? ?? 0,
      makerName: map['makerName'] as String? ?? '',
      modelID: map['modelID'] as int? ?? 0,
      model: map['model'] as String? ?? '',
      equipmentTypeID: map['equipmentTypeID'] as int? ?? 0,
      equipTypeName: map['equipTypeName'] as String? ?? '',
      positionNumber: map['positionNumber'] as String? ?? '',
      specification: map['specification'] as String? ?? '',
      isCritical: map['isCritical'] as bool? ?? false,
      vesselComponentID: map['vesselComponentID'] as int? ?? 0,
      referenceID: map['referenceID'] as int? ?? 0,
      referenceTypeID: map['referenceTypeID'] as int? ?? 0,
      referenceSubID: map['referenceSubID'] as int? ?? 0,
    );
  }

  /// Convert to JSON map
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'GroupId': groupId,
      'ItemID': itemID,
      'itemId': itemId,
      'ItemCode': itemCode,
      'ItemName': itemName,
      'ItemDescription': itemDescription,
      'UomID': uomId,
      'UomCode': uomCode,
      'UomName': uomName,
      'PackagingUOM': packagingUOM,
      'IsActive': isActive,
      'CategoryID': categoryId,
      'CategoryCode': categoryCode,
      'CategoryName': categoryName,
      'SectionID': sectionId,
      'SectionCode': sectionCode,
      'SectionName': sectionName,
      'SubSectionID': subSectionId,
      'SubsectionCode': subsectionCode,
      'SubsectionName': subsectionName,
      'PartNumber': partNumber,
      'ItemLinkID': itemLinkId,
      'PropertiesID': propertiesId,
      'PropertyVersionNO': propertyVersionNo,
      'VersionNo': versionNo,
      'ItemSpecification': itemSpecification,
      'IsExportControl': isExportControl,
      'IsIHM': isIhm,
      'IsIMDG': isImdg,
      'UsContent': usContent,
      'IMDGClass': imdgClass,
      'MD': md,
      'Sdoc': sdoc,
      'EccnNo': eccnNo,
      'HsCode': hsCode,
      'CountryOfOrgin': countryOfOrigin,
      'PackSize': packSize,
      'TBN': tbn,
      'Density': density,
      'IsAntiPiracy': isAntiPiracy,
      'UOMQuantity': uomQuantity,
      'PackagingUOMID': packagingUOMId,
      'ReOrderQuantity': reOrderQuantity,
      'equipmentName': equipmentName,
      'equipmentCode': equipmentCode,
      'spareID': spareId,
      'minStock': minStock,
      'maxStock': maxStock,
      'drawingNumber': drawingNumber,
      'unit': unit,
      'articleNumber': articleNumber,
      'vesselEquipmentID': vesselEquipmentID,
      'parentEquipmentID': parentEquipmentID,
      'parentEquipmentName': parentEquipmentName,
      'parentEquipmentCode': parentEquipmentCode,
      'makerID': makerID,
      'makerName': makerName,
      'modelID': modelID,
      'model': model,
      'equipmentTypeID': equipmentTypeID,
      'equipTypeName': equipTypeName,
      'positionNumber': positionNumber,
      'specification': specification,
      'isCritical': isCritical,
      'vesselComponentID': vesselComponentID,
      'referenceID': referenceID,
      'referenceTypeID': referenceTypeID,
      'referenceSubID': referenceSubID,
    };
  }

  // Fields
  final int groupId;
  final int itemID;
  final int itemId;
  final String itemCode;
  final String itemName;
  final String itemDescription;
  final int uomId;
  final String uomCode;
  final String uomName;
  final String packagingUOM;
  final bool isActive;
  final int categoryId;
  final String categoryCode;
  final String categoryName;
  final int sectionId;
  final String sectionCode;
  final String sectionName;
  final int subSectionId;
  final String subsectionCode;
  final String subsectionName;
  final String partNumber;
  final int itemLinkId;
  final int propertiesId;
  final int propertyVersionNo;
  final int versionNo;
  final String itemSpecification;
  final bool isExportControl;
  final bool isIhm;
  final bool isImdg;
  final String usContent;
  final String imdgClass;
  final bool md;
  final bool sdoc;
  final String eccnNo;
  final String hsCode;
  final String countryOfOrigin;
  final double packSize;
  final String tbn;
  final double density;
  final bool isAntiPiracy;
  final int uomQuantity;
  final int packagingUOMId;
  final int reOrderQuantity;
  final String equipmentName;
  final String equipmentCode;
  final int spareId;
  final int minStock;
  final int maxStock;
  final String drawingNumber;
  final String unit;
  final String articleNumber;
  final int vesselEquipmentID;
  final int parentEquipmentID;
  final String parentEquipmentName;
  final String parentEquipmentCode;
  final int makerID;
  final String makerName;
  final int modelID;
  final String model;
  final int equipmentTypeID;
  final String equipTypeName;
  final String positionNumber;
  final String specification;
  final bool isCritical;
  final int vesselComponentID;
  final int referenceID;
  final int referenceTypeID;
  final int referenceSubID;

  @override
  List<Object?> get props => [
    groupId,
    itemID,
    itemId,
    itemCode,
    itemName,
    itemDescription,
    uomId,
    uomCode,
    uomName,
    packagingUOM,
    isActive,
    categoryId,
    categoryCode,
    categoryName,
    sectionId,
    sectionCode,
    sectionName,
    subSectionId,
    subsectionCode,
    subsectionName,
    partNumber,
    itemLinkId,
    propertiesId,
    propertyVersionNo,
    versionNo,
    itemSpecification,
    isExportControl,
    isIhm,
    isImdg,
    usContent,
    imdgClass,
    md,
    sdoc,
    eccnNo,
    hsCode,
    countryOfOrigin,
    packSize,
    tbn,
    density,
    isAntiPiracy,
    uomQuantity,
    packagingUOMId,
    reOrderQuantity,
    equipmentName,
    equipmentCode,
    spareId,
    minStock,
    maxStock,
    drawingNumber,
    unit,
    articleNumber,
    vesselEquipmentID,
    parentEquipmentID,
    parentEquipmentName,
    parentEquipmentCode,
    makerID,
    makerName,
    modelID,
    model,
    equipmentTypeID,
    equipTypeName,
    positionNumber,
    specification,
    isCritical,
    vesselComponentID,
    referenceID,
    referenceTypeID,
    referenceSubID,
  ];

  @override
  bool? get stringify => true;
}


