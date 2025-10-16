import 'package:sqflite/sqflite.dart';

class TransactionItemsTable {
  static const tableName = 'GR_Transaction_DT';

  static const String poId = "poID";
  static const String poNo = "poNo";
  static const String grnId = "grnID";
  static const String grnDtId = "GRNDTID";
  static const String grnNo = "grnNo";
  static const String itemId = "ItemID";
  static const String itemVersionId = "ItemVersionID";
  static const String itemLinkId = "ItemLinkID";
  static const String parentItemId = "ParentItemID";
  static const String parentItemVersionId = "ParentItemVersionID";
  static const String parentItemLinkId = "ParentItemLinkID";
  static const String receivedQty = "ReceivedQty";
  static const String convertedStockQty = "ConvertedStockQty";
  static const String newStock = "NewStock";
  static const String damagedOrWrongSupply = "DamagedOrwrongSupply";
  static const String reconditionedStock = "ReconditionedStock";
  static const String expiryDate = "ExpiryDate";
  static const String uomId = "UOMID";
  static const String qualityId = "QualityID";
  static const String batchNo = "BatchNo";
  static const String remarks = "Remarks";
  static const String isMd = "IsMD";
  static const String isSdoc = "IsSDOC";
  static const String zeroDeclaration = "ZeroDeclaration";
  static const String ihmMaterialQty = "IHMMaterialQty";
  static const String articleNo = "articleNo";
  static const String productName = "productName";
  static const String productDescription = "ProductDescription";
  static const String eccnNo = "EccnNo";
  static const String hsCode = "HSCode";
  static const String countryName = "CountryName";
  static const String isAntiPiracy = "isAntiPiracy";
  static const String isPyroTechnics = "isPyroTechnics";
  static const String imdgClassId = "iMDGClassID";
  static const String className = "className";
  static const String partNo = "PARTNO";
  static const String categoryName = "CategoryName";
  static const String itemCategoryId = "ItemCategoryID";
  static const String itemSectionId = "ItemSectionID";
  static const String sectionName = "SectionName";
  static const String itemSubSectionId = "ItemSubSectionID";
  static const String subSectionName = "SubSectionName";
  static const String itemUom = "ItemUom";
  static const String isExportControl = "IsExportControl";
  static const String isIhm = "IsIHM";
  static const String isCritical = "IsCritical";
  static const String isImdg = "IsIMDG";
  static const String vessel = "Vessel";
  static const String poQuantity = "POQuantity";
  static const String isBagTagItem = "isBagTagItem";
  static const String drawingPositionNumber = "DrawingPositionNumber";
  static const String drawingNumber = "DrawingNumber";
  static const String unitPrice = "UnitPrice";
  static const String equipmentId = "EquipmentID";
  static const String equipmentName = "EquipmentName";
  static const String podtId = "PODTID";
  static const String isConfirmed = "isConfirmed";

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $poId INTEGER,
      $poNo TEXT,
      $grnId INTEGER,
      $grnDtId INTEGER,
      $grnNo TEXT,
      $itemId INTEGER,
      $itemVersionId INTEGER,
      $itemLinkId INTEGER,
      $parentItemId INTEGER ,
      $parentItemVersionId INTEGER,
      $parentItemLinkId INTEGER,
      $receivedQty REAL,
      $convertedStockQty REAL,
      $newStock REAL,
      $damagedOrWrongSupply REAL,
      $reconditionedStock REAL,
      $expiryDate TEXT,
      $uomId INTEGER,
      $qualityId INTEGER,
      $batchNo TEXT,
      $remarks TEXT,
      $isMd INTEGER,
      $isSdoc INTEGER,
      $zeroDeclaration INTEGER,
      $ihmMaterialQty REAL,
      $articleNo TEXT,
      $productName TEXT,
      $productDescription TEXT,
      $eccnNo TEXT,
      $hsCode TEXT,
      $countryName TEXT,
      $isAntiPiracy INTEGER,
      $isPyroTechnics INTEGER,
      $imdgClassId INTEGER,
      $className TEXT,
      $partNo TEXT,
      $categoryName TEXT,
      $itemCategoryId INTEGER,
      $itemSectionId INTEGER,
      $sectionName TEXT,
      $itemSubSectionId INTEGER,
      $subSectionName TEXT,
      $itemUom TEXT,
      $isExportControl INTEGER,
      $isIhm INTEGER,
      $isCritical INTEGER,
      $isImdg INTEGER,
      $vessel TEXT,
      $poQuantity REAL,
      $isBagTagItem INTEGER,
      $drawingPositionNumber TEXT,
      $drawingNumber TEXT,
      $unitPrice REAL,
      $equipmentId INTEGER,
      $equipmentName TEXT,
      $podtId INTEGER,
      $isConfirmed INTEGER
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
