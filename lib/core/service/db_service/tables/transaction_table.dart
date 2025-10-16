import 'package:sqflite/sqflite.dart';

class TransactionTable {
  static const tableName = 'GR_Transaction_HD';

  static const String grnId = "GrnId";
  static const String receiptNo = "ReceiptNo";
  static const String receiptDate = "ReceiptDate";
  static const String poNo = "PoNo";
  static const String poId = "PoId";
  static const String insights = "Insights";
  static const String reqCategoryID = "ReqCategoryID";
  static const String category = "Category";
  static const String priority = "Priority";
  static const String priorityID = "PriorityID";
  static const String vendorID = "VendorID";
  static const String vendorName = "VendorName";
  static const String delivryDate = "DelivryDate";
  static const String deliveryToID = "DeliveryToID";
  static const String dlvryTO = "DlvryTO";
  static const String pOtitle = "POtitle";
  static const String totalNOofprudcts = "TotalNOofprudcts";
  static const String plannedNoOfPdcts = "PlannedNoOfPdcts";
  static const String entityID = "EntityID";
  static const String entity = "Entity";
  static const String remarksForVendor = "RemarksForVendor";
  static const String pocost = "pocost";
  static const String weight = "Weight";
  static const String actualvolume = "Actualvolume";
  static const String currencyName = "CurrencyName";
  static const String noOfPackets = "NoOfPackets";
  static const String presentProperties = "PresentProperties";
  static const String deliveryToLocationID = "DeliveryToLocationID";
  static const String deliveryToLocation = "DeliveryToLocation";
  static const String totalAmountReportingCurrency =
      "TotalAmountReportingCurrency";
  static const String poRemarks = "PoRemarks";
  static const String isBaggingCompleted = "IsBaggingCompleted";
  static const String modifiedOn = "ModifiedOn";
  static const String portID = "PortID";
  static const String isFull = "IsFull";
  static const String syncStatus = "SyncStatus";
  static const String deliveryReference = "DeliveryReference";
  static const String isBaggingTaggingApplicable = "IsBaggingTaggingApplicable";
  static const String workFlowId = "WorkFlowID";
  static const String workFlowStatusId = "WorkFlowStatusID";
  static const String podtId = "podtid";
  static const String isConfirmed = "isConfirmed";

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $grnId INTEGER PRIMARY KEY,
      $receiptNo TEXT,
      $receiptDate TEXT,
      $poNo TEXT,
      $poId INTEGER,
      $insights TEXT,
      $reqCategoryID INTEGER,
      $category TEXT,
      $priorityID INTEGER,
      $priority TEXT,
      $vendorID INTEGER,
      $vendorName TEXT,
      $delivryDate TEXT,
      $deliveryToID INTEGER,
      $dlvryTO TEXT,
      $pOtitle TEXT,
      $totalNOofprudcts INTEGER,
      $plannedNoOfPdcts INTEGER,
      $entityID INTEGER,
      $entity TEXT,
      $remarksForVendor TEXT,
      $pocost REAL,
      $weight REAL,
      $actualvolume REAL,
      $currencyName TEXT,
      $noOfPackets INTEGER,
      $presentProperties TEXT,
      $deliveryToLocationID INTEGER,
      $deliveryToLocation TEXT,
      $totalAmountReportingCurrency REAL,
      $poRemarks TEXT,
      $isBaggingCompleted INTEGER,
      $modifiedOn TEXT,
      $portID INTEGER,
      $isFull INTEGER,
      $syncStatus INTEGER,
      $deliveryReference TEXT,
      $isBaggingTaggingApplicable INTEGER,
      $workFlowId INTEGER,
      $workFlowStatusId INTEGER,
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
