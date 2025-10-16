class AppErrorCodes {
  //Error code format will be: [SOURCE]-[MODULE]-[TYPE]-[CODE]

  // Goods Receipts (GRN)
  static const String grnFetchFailed = 'API-GRN-DAT-001';
  static const String grnInvalidResponse = 'API-GRN-SRV-001';
  static const String grnDbSaveError = 'DB-GRN-WRT-001';
  static const String grnDbFetchError = 'DB-GRN-DAT-001';
  static const String grnDbUpdateError = 'DB-GRN-WRT-002';
  static const String grnTransactionFetchFailed = 'API-GRN-DAT-002';
  static const String grnMediaFetchFailed = 'FILE-GRN-MEDIA-001';
  static const String grnPoLineItemsFetchFailed = 'API-POL-DAT-001';

  // Bagging & Tagging (BTG)
  static const String tagInvalidBarcode = 'LOG-BTG-VLD-001';
  static const String tagUploadFailed = 'API-BTG-UPL-001';
  static const String bagTagnDbWriteFail = 'DB-BTG-WRT-001';
  static const String bagTagnPurchaseItemDetailsDbWriteFail = 'DB-BTG-WRT-002';
  static const String bagTagnPurchaseItemListDbWriteFail = 'DB-BTG-WRT-003';
  static const String bagTagConfirmListDbWriteFail = 'DB-BTG-WRT-004';
  static const String bagTagItemDetailFail = 'API-BTG-DAT-001';
  static const String bagTagPurchaseItemDetailFail = 'API-BTG-DAT-002';
  static const String bagTagPurchaseItemListDetailFail = 'API-BTG-DAT-003';
  static const String bagTagConfirmListDetailFail = 'API-BTG-DAT-004';

  // Consumption (CON)
  static const String consumptionFetchFailed = 'API-CON-DAT-001';
  static const String consumptionDbWriteFail = 'DB-CON-WRT-001';

  static const String consumptionDbSaveError = 'DB-CON-SAVE_TRANSACTION-001';
  static const String consumptionSaveFailed = 'API-CON-SAVE_TRANSACTION-001';

  // static const String consumptionDbWriteFai= 'DB-CON-WRT-001';

  // Stock Update (STU)
  static const String stockUpdateAuthError = 'API-STU-AUTH-001';
  static const String stockUpdateDbError = 'DB-STU-WRT-001';

  // Item Master (ITM)
  static const String itemMasterLoadFail = 'API-ITM-DAT-001';
  static const String itemMasterInvalidItem = 'LOG-ITM-VLD-001';

  // Equipment List(EQP)
  static const String equipmentListDbWriteFail = 'DB-EQP-WRT-001';
  static const String equipmentListLoadFail = 'API-EQP-DAT-001';

  // FetchIMDG(FDG)
  static const String fetchImdgListDbWriteFail = 'DB-FDG-WRT-001';
  static const String fetchImdgListLoadFail = 'API-FDG-DAT-001';

  // ItemCategory(ICY)
  static const String fetchItemCategoryDbWriteFail = 'DB-ICY-WRT-001';
  static const String fetchItemCategoryLoadFail = 'API-ICY-DAT-001';

  // ItemSection(ISN)
  static const String fetchItemSectionDbWriteFail = 'DB-ISN-WRT-001';
  static const String fetchItemSectionLoadFail = 'API-ISN-DAT-001';

  // ItemSubSection(ISS)
  static const String fetchItemSubSectionDbWriteFail = 'DB-ISS-WRT-001';
  static const String fetchItemSubSectionLoadFail = 'API-ISS-DAT-001';

  // Storage Location List(STR)
  static const String storageLocationListDbWriteFail = 'DB-STR-WRT-001';
  static const String storageLocationListLoadFail = 'API-STR-DAT-001';

  // Fetch IMDG Class List(IMDG Class)
  static const String imdgClassesListDbWriteFail = 'DB-IMDG-WRT-001';
  static const String imdgClassesListLoadFail = 'API-IMDG-DAT-001';

  static const String purchaseOrderListFetchFailed = 'DB-POL-DAT-001';
  static const String purchaseOrderListApiFetchFailed = 'API-POL-DAT-001';
}
