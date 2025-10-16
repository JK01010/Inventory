import 'package:sqflite/sqflite.dart';

class PurchaseOrderItemsTable {
  static const tableName = 'purchase_order_items';

  static const String poDtId = "PODTID";
  static const String slNo = "SLNO";
  static const String partNumber = "PartNumber";
  static const String productName = "ProductName";
  static const String uomId = "uomId"; // stays lowercase
  static const String packSize = "PackSize";
  static const String quantity = "Quantity";
  static const String rob = "ROB";
  static const String productDescription = "ProductDescription";
  static const String unitPrice = "UnitPrice";
  static const String contractPrice = "ContractPrice";
  static const String discountPercentage = "DiscountPercentage";
  static const String discount = "Discount";
  static const String vatId = "VATID";
  static const String vatPercentage = "VATPercentage";
  static const String accountId = "AccountID";
  static const String accountCode = "AccountCode";
  static const String accountName = "AccountName";
  static const String subAccountId = "SubAccountID";
  static const String subAccountCode = "SubAccountCode";
  static const String subAccountName = "SubAccountName";
  static const String analysisCodeId = "AnalysisCodeID";
  static const String analysisCode = "AnalysisCode";
  static const String analysisName = "AnalysisName";
  static const String leadDays = "LeadDays";
  static const String vendorDeliveryDate = "VendorDeliveryDate";
  static const String remarksToVendor = "RemarksToVendor";
  static const String isMd = "IsMD";
  static const String isSDoc = "IsSDOC";
  static const String zeroDeclaration = "ZeroDeclaration";
  static const String ihmMaterialQty = "IHMMaterialQty";
  static const String eccnNo = "EccnNo";
  static const String hsCode = "HSCode";
  static const String countryName = "CountryName";
  static const String partNo = "PARTNO";
  static const String categoryName = "CategoryName";
  static const String itemCategoryId = "ItemCategoryID";
  static const String itemSectionId = "ItemSectionID";
  static const String sectionName = "SectionName";
  static const String itemSubSectionId = "ItemSubSectionID";
  static const String subSectionName = "SubSectionName";
  static const String vessel = "Vessel";
  static const String entity = "Entity";
  static const String entityId = "EntityID";
  static const String poHdId = "POHDID";
  static const String exchangeRateVesselCurrency = "ExchangeRateVesselCurrency";
  static const String exchangeRateGroupCurrency = "ExchangeRateGroupCurrency";
  static const String budgetDate = "BudgetDate";
  static const String invoiceStatus = "InvoiceStatus";
  static const String totalPoCurrency = "TotalPOCurrency";
  static const String totalBaseCurrency = "TotalBaseCurrency";
  static const String totalReportingCurrency = "TotalReportingCurrency";
  static const String itemId = "ItemId";
  static const String articleNumber = "ArticleNumber";
  static const String itemUom = "ItemUom";
  static const String packUom = "PackUOM";
  static const String serviceDescription = "ServiceDescription";
  static const String equipmentName = "EquipmentName";
  static const String equipmentDescription = "EquipmentDescription";
  static const String equipmentModelNumber = "EquipmentModelNumber";
  static const String equipmentSerialNo = "EquimentSerialNo";
  static const String equipmentManufacturer = "EquipmentManufacturer";
  static const String deliveryCode = "DeliveryCode";
  static const String deliveryTypeName = "DeliveryTypeName";
  static const String uniqueItemReference = "UniqueItemReference";
  static const String isDeleted = "IsDeleted";
  static const String itemLinkId = "ItemLinkID";
  static const String itemVersionId = "ItemVersionID";
  static const String parentId = "ParentID";
  static const String parentItemLinkId = "ParentItemLinkID";
  static const String parentItemVersionId = "ParentItemVersionID";
  static const String imdgCode = "IMDGCode";
  static const String imdgName = "IMDGName";
  static const String exportControl = "ExportControl";
  static const String drawingNumber = "DrawingNumber";
  static const String receivedQty = "ReceivedQty";
  static const String damagedQty = "DamagedQty";
  static const String newStockQty = "NewStockQty";
  static const String reconditionedStockQty = "ReconditionedStockQty";
  static const String qualityId = "QualityID";
  static const String expiryDate = "ExpiryDate";
  static const String batchNo = "BatchNo";
  static const String remarks = "Remarks";
  static const String isSync = "isSync";

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $poDtId INTEGER,
      $slNo INTEGER,
      $partNumber TEXT,
      $productName TEXT,
      $uomId INTEGER,
      $packSize REAL,
      $quantity REAL,
      $rob INTEGER,
      $productDescription TEXT,
      $unitPrice REAL,
      $contractPrice REAL,
      $discountPercentage REAL,
      $discount REAL,
      $vatId INTEGER,
      $vatPercentage REAL,
      $accountId INTEGER,
      $accountCode TEXT,
      $accountName TEXT,
      $subAccountId INTEGER,
      $subAccountCode TEXT,
      $subAccountName TEXT,
      $analysisCodeId INTEGER,
      $analysisCode TEXT,
      $analysisName TEXT,
      $leadDays REAL,
      $vendorDeliveryDate TEXT,
      $remarksToVendor TEXT,
      $isMd INTEGER,
      $isSDoc INTEGER,
      $zeroDeclaration INTEGER,
      $ihmMaterialQty REAL,
      $eccnNo TEXT,
      $hsCode TEXT,
      $countryName TEXT,
      $partNo TEXT,
      $categoryName TEXT,
      $itemCategoryId INTEGER,
      $itemSectionId INTEGER,
      $sectionName TEXT,
      $itemSubSectionId INTEGER,
      $subSectionName TEXT,
      $vessel TEXT,
      $entity TEXT,
      $entityId INTEGER,
      $poHdId INTEGER,
      $exchangeRateVesselCurrency REAL,
      $exchangeRateGroupCurrency REAL,
      $budgetDate TEXT,
      $invoiceStatus TEXT,
      $totalPoCurrency REAL,
      $totalBaseCurrency REAL,
      $totalReportingCurrency REAL,
      $itemId INTEGER,
      $articleNumber TEXT,
      $itemUom TEXT,
      $packUom TEXT,
      $serviceDescription TEXT,
      $equipmentName TEXT,
      $equipmentDescription TEXT,
      $equipmentModelNumber TEXT,
      $equipmentSerialNo TEXT,
      $equipmentManufacturer TEXT,
      $deliveryCode TEXT,
      $deliveryTypeName TEXT,
      $uniqueItemReference TEXT,
      $isDeleted INTEGER,
      $itemLinkId INTEGER,
      $itemVersionId INTEGER,
      $parentId INTEGER,
      $parentItemLinkId INTEGER,
      $parentItemVersionId INTEGER,
      $imdgCode TEXT,
      $imdgName TEXT,
      $exportControl TEXT,
      $drawingNumber TEXT,
      $receivedQty REAL,
      $damagedQty REAL,
      $newStockQty REAL,
      $reconditionedStockQty REAL,
      $qualityId INTEGER,
      $expiryDate TEXT,
      $batchNo TEXT,
      $remarks TEXT,
      $isSync INTEGER
           
    )
  ''';

  static Future<void> onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      // Sample migration: add new column
      await db.execute("ALTER TABLE $tableName ADD COLUMN email TEXT");
    }
  }
}
