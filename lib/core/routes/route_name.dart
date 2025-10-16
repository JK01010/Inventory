enum AppRoute {
  login('/login'),
  goodsReceipts('/goodsReceipts'),
  goodsReceiptsDetail('/goodsReceiptsDetail'),
  dashboard('/dashboard'),
  baggingTaggingListing('/baggingTaggingListing'),
  numberOfReceipts('/numberOfReceipts'),
  printRfidPage('/printRfidPage'),
  baggingPrintRfidPage('/baggingPrintRfidPage'),
  createLabelPage('/createLabelPage'),
  profile('/profile'),
  baggingTaggingDetails('/baggingTaggingDetails'),
  goodsDetailsPage('/goodsDetailsPage'),
  goodsReceiptsSearch('/goodsReceiptSearch'),
  transactionSearch('/transactionSearch'),
  baggingTaggingConfirmationScanning('/baggingTaggingConfirmationScanning'),
  profileSyncStatusPage('/profileSyncStatusPage'),
  chooseStorageLocationPage('/chooseStorageLocationPage'),
  baggingPendingSearch('/baggingPendingSearch'),
  baggingConfirmationSearch('/baggingConfirmationSearch'),
  itemMaster('/itemMaster'),
  addManually('/addManually'),
  goodsReceiptTransactionItemDetailPage(
    '/goodsReceiptTransactionItemDetailPage',
  ),
  attachmentsListingWidgetPage('/attachmentsListingWidgetPage'),
  consumptionTransaction('/consumptionTransaction'),
  consumptionAdd('/consumptionAdd'),
  consumption('/consumption'),
  consumptionRFIDScan('/consumptionAddScan'),
  viewRfidListViewing('/viewRfidListViewing'),
  itemMasterViewRfidListViewing('/itemMasterViewRfidListViewing'),
  viewRfidListDetailsPage('/viewRfidListDetailsPage'),
  addManuallyItemListingPage('/addManuallyItemListingPage'),
  createLabelDetailsPage('/createLabelDetailsPage'),

  // chooseStorageLocation('/chooseStorageLocation');

  // consumptionRFIDScan('/consumptionAddScan'),

  stockUpdateTransaction('/stockUpdateTransaction'),
  stockUpdateAdd('/stockUpdateAdd'),
  stockUpdate('/stockUpdate'),
  stockUpdateRFIDScan('/stockUpdateRFIDScan'),
  consumptionSearchEquipmentListPage('/consumptionSearchEquipmentListPage'),
  consumptionSearchLocationListPage('/consumptionSearchLocationListPage'),
  searchConsumptionTransactionPage('/searchConsumptionTransactionPage'),
  searchConsumptionTrnRfidListingPage('/searchConsumptionTrnRfidListingPage'),
  searchStockUpdateRfidListingPage('/searchStockUpdateRfidListingPage'),
  searchConsumptionItemUpdatePage('/searchConsumptionItemUpdatePage'),
  searchStockUpdatePage('/searchStockUpdatePage'),
  searchStockUpdateTransactionPage('/searchStockUpdateTransactionPage'),
  searchItemPage('/searchItemPage'),
  baggingConfirmationStorageDetailsPage(
    '/baggingConfirmationStorageDetailsPage',
  ),
  profileDetailPage('/profileDetailPage'),
  barcodeScannerPage('/barcodeScannerPage'),
  purchaseOrderDetailPage('/purchaseOrderDetailPage'),
  purchaseOrderItemDetailPage('/purchaseOrderItemDetailPage'),
  transactionDetailPage('/transactionDetailPage'),
  transactionItemDetailPage('/transactionItemDetailPage'),
  splashScreen('/splashScreen');

  // chooseStorageLocation('/chooseStorageLocation'),

  const AppRoute(this.path);

  final String path;
}
