import 'package:sqflite/sqflite.dart';

class GoodsReceiptDetailLabelTable {
  static const tableName = 'purchase_order_items';

  static const String poDtId = "PODTID";
  static const String slNo = "SLNO";
  static const String partNumber = "PartNumber";
  static const String productName = "ProductName";
  static const String quantity = "Quantity";
  static const String productDescription = "ProductDescription";
  static const String articleNumber = "ArticleNumber";
  static const String drawingNumber = "DrawingNumber";
  static const String itemUom = "ItemUom";
  static const String packSize = "PackSize";
  static const String unitPrice = "UnitPrice";
  static const String imdgCode = "IMDGCode";
  static const String imdgName = "IMDGName";
  static const String remarksToVendor = "RemarksToVendor";
  static const String equipmentName = "EquipmentName";
  static const String itemCategoryId = "ItemCategoryID";
  static const String categoryName = "CategoryName";
  static const String itemSectionId = "ItemSectionID";
  static const String sectionName = "SectionName";
  static const String itemSubSectionId = "ItemSubSectionID";
  static const String subSectionName = "SubSectionName";
  static const String isMd = "IsMD";
  static const String isSDoc = "IsSDOC";
  static const String zeroDeclaration = "ZeroDeclaration";
  static const String ihmMaterialQty = "IHMMaterialQty";
  static const String rob = "ROB";
  static const String poHdId = "POHDID";
  static const String itemId = "ItemId";
  static const String itemVersionId = "ItemVersionID";
  static const String itemLinkId = "ItemLinkID";
  static const String parentItemVersionId = "ParentItemVersionID";
  static const String parentItemLinkId = "ParentItemLinkID";
  static const String receivedQty = "ReceivedQty";
  static const String convertedStockQty = "ConvertedStockQty";
  static const String newStockQty = "NewStockQty";
  static const String damagedQty = "DamagedQty";
  static const String reconditionedStockQty = "ReconditionedStockQty";
  static const String expiryDate = "ExpiryDate";
  static const String uomId = "uomId"; // stays lowercase
  static const String qualityId = "QualityID";
  static const String batchNo = "BatchNo";
  static const String remarks = "Remarks";
  static const String articleNo = "articleNo"; // stays lowercase
  static const String eccnNo = "EccnNo";
  static const String hsCode = "HSCode";
  static const String countryName = "CountryName";
  static const String isAntiPiracy = "isAntiPiracy"; // stays lowercase
  static const String isPyroTechnics = "isPyroTechnics"; // stays lowercase
  static const String imdgClassId = "iMDGClassID"; // same casing
  static const String className = "className"; // stays lowercase
  static const String partNo = "PARTNO";
  static const String exportControl = "ExportControl";
  static const String isIHM = "IsIHM";
  static const String isCritical = "IsCritical";
  static const String isImdg = "IsIMDG";
  static const String vessel = "Vessel";

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $poDtId INTEGER NOT NULL,
      $poHdId INTEGER NOT NULL,
      $slNo INTEGER NULL,
      $partNumber TEXT NULL,
      $productName TEXT NULL,
      $quantity REAL NULL,
      $productDescription TEXT NULL,
      $articleNumber TEXT NULL,
      $drawingNumber TEXT NULL,
      $itemUom TEXT NULL,
      $packSize REAL NULL,
      $unitPrice REAL NULL,
      $imdgCode TEXT NULL,
      $imdgName TEXT NULL,
      $remarksToVendor TEXT NULL,
      $equipmentName TEXT NULL,
      $itemCategoryId INTEGER NULL,
      $categoryName TEXT NULL,
      $itemSectionId INTEGER NULL,
      $sectionName TEXT NULL,
      $itemSubSectionId INTEGER NULL,
      $subSectionName TEXT NULL,
      $isMd TEXT NULL,
      $isSDoc TEXT NULL,
      $ihmMaterialQty REAL NULL,
      $rob INTEGER NULL,
      $itemId INTEGER,
      $itemVersionId INTEGER  NULL,
      $itemLinkId INTEGER  NULL,
      $parentItemVersionId INTEGER  NULL,
      $parentItemLinkId INTEGER  NULL,
      $receivedQty REAL  NULL,
      $convertedStockQty REAL  NULL,
      $newStockQty REAL  NULL,
      $reconditionedStockQty REAL  NULL,
      $expiryDate TEXT,
      $uomId INTEGER  NULL,
      $qualityId INTEGER  NULL,
      $batchNo TEXT  NULL,
      $remarks TEXT  NULL,
      $zeroDeclaration TEXT  NULL,
      $articleNo TEXT  NULL,
      $eccnNo TEXT,
      $hsCode TEXT,
      $countryName TEXT,
      $isAntiPiracy TEXT,
      $isPyroTechnics TEXT,
      $imdgClassId INTEGER,
      $className TEXT,
      $partNo TEXT,
      $exportControl TEXT,
      $isIHM TEXT,
      $isCritical TEXT,
      $isImdg TEXT,
      $vessel TEXT      
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
