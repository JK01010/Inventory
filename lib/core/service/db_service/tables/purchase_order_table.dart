import 'package:sqflite/sqflite.dart';

class PurchaseOrderTable {
  static const tableName = 'Purchase_HD';

  static const String grnId = "GrnId";
  static const String poCode = "POCode";
  static const String poHdId = "POHDID";
  static const String requisitionCategory = "RequisitionCategory";
  static const String vendorName = "VendorName";
  static const String title = "Title";
  static const String priority = "Priority";
  static const String vendorDeliveryDate = "VendorDeliveryDate";
  static const String vendorReference = "VendorReference";
  static const String budgetDate = "BudgetDate";
  static const String entity = "Entity";
  static const String currency = "Currency";
  static const String payment = "Payment";
  static const String paymentTerms = "PaymentTerms";
  static const String remarksToVendor = "RemarksToVendor";
  static const String paymentDueAfterDays = "PaymentDueAfterDays";
  static const String createdBy = "CreatedBy";
  static const String postInvoicePO = "PostInvoicePO";
  static const String exportControl = "ExportControl";
  static const String exportControlBlock = "ExportControlBlock";
  static const String remarksFromVendor = "RemarksFromVendor";
  static const String deliveryTo = "DeliveryTo";
  static const String placeOfProcurement = "PlaceOfProcurement";
  static const String leadDays = "LeadDays";
  static const String deliveryTerms = "DeliveryTerms";
  static const String deliveryPort = "DeliveryPort";
  static const String wareHouseName = "WareHouseName";
  static const String poCreatedOn = "POCreatedOn";
  static const String vessel = "Vessel";
  static const String portCode = "PortCode";
  static const String portCountryName = "PortCountryName";
  static const String portCountryCode = "PortCountryCode";
  static const String totalAmount = "TotalAmount";
  static const String totalAmountBaseCurrency = "TotalAmountBaseCurrency";
  static const String totalAmountReportingCurrency =
      "TotalAmountReportingCurrency";
  static const String headerDiscount = "HeaderDiscount";
  static const String vesselIMO = "VesselIMO";
  static const String vesselCode = "VesselCode";
  static const String priorityCode = "PriorityCode";
  static const String deliveryTermsCode = "DeliveryTermsCode";
  static const String reqCategoryCode = "ReqCategoryCode";
  static const String currencyCode = "CurrencyCode";
  static const String vendorEmail = "VendorEmail";
  static const String vendorShortName = "VendorShortName";
  static const String shipservQuoteId = "ShipservQuoteId";
  static const String siteId = "SiteId";
  static const String vendorID = "VendorID";
  static const String supplierZipCode = "SupplierZipCode";
  static const String referenceTypeID = "ReferenceTypeID";
  static const String referenceID = "ReferenceID";
  static const String referenceSubID = "ReferenceSubID";
  static const String requisitionCategoryId = "RequisitionCategoryId";
  static const String buyerName = "BuyerName";
  static const String revisionNo = "RevisionNo";
  static const String recSparesToBring = "RecSparesToBring";
  static const String serviceDescription = "ServiceDescription";
  static const String roleCode = "RoleCode";
  static const String portID = "PortID";
  static const String deliveryToID = "DeliveryToID";

  static String createTableQuery = '''
    CREATE TABLE $tableName (
        $poCode TEXT NULL,
        $poHdId INTEGER PRIMARY KEY,
        $grnId INTEGER NULL,
        $requisitionCategory TEXT NULL,
        $vendorName TEXT NULL,
        $title TEXT NULL,
        $priority TEXT NULL,
        $vendorDeliveryDate TEXT NULL,
        $vendorReference TEXT NULL,
        $budgetDate TEXT NULL,
        $entity TEXT NULL,
        $currency TEXT NULL,
        $payment TEXT NULL,
        $paymentTerms TEXT NULL,
        $remarksToVendor TEXT NULL,
        $paymentDueAfterDays REAL NULL,
        $createdBy TEXT NULL,
        $postInvoicePO INTEGER NULL,
        $exportControl INTEGER NULL,
        $exportControlBlock INTEGER NULL,
        $remarksFromVendor TEXT NULL,
        $deliveryTo TEXT NULL,
        $placeOfProcurement TEXT NULL,
        $leadDays REAL NULL,
        $deliveryTerms TEXT NULL,
        $deliveryPort TEXT NULL,
        $wareHouseName TEXT NULL,
        $poCreatedOn TEXT NULL,
        $vessel TEXT NULL,
        $portCode TEXT NULL,
        $portCountryName TEXT NULL,
        $portCountryCode TEXT NULL,
        $totalAmount REAL NULL,
        $totalAmountBaseCurrency REAL NULL,
        $totalAmountReportingCurrency REAL NULL,
        $headerDiscount REAL NULL,
        $vesselIMO TEXT NULL,
        $vesselCode TEXT NULL,
        $priorityCode TEXT NULL,
        $deliveryTermsCode TEXT NULL,
        $reqCategoryCode TEXT NULL,
        $currencyCode TEXT NULL,
        $vendorEmail TEXT NULL,
        $vendorShortName TEXT NULL,
        $shipservQuoteId INTEGER NULL,
        $siteId INTEGER NULL,
        $vendorID INTEGER NULL,
        $supplierZipCode TEXT NULL,
        $referenceTypeID INTEGER NULL,
        $referenceID INTEGER NULL,
        $referenceSubID INTEGER NULL,
        $requisitionCategoryId INTEGER NULL,
        $buyerName TEXT NULL,
        $revisionNo INTEGER NULL,
        $recSparesToBring TEXT NULL,
        $serviceDescription TEXT NULL,
        $roleCode TEXT NULL,
        $portID INTEGER NULL,
        $deliveryToID INTEGER NULL
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
