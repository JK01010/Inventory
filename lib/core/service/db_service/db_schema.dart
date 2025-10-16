import 'package:sqflite/sqflite.dart';

import 'tables/admin_structure.dart';
import 'tables/bagging_confirmation_list_table.dart';
import 'tables/bagging_item_details_table.dart';
import 'tables/bagging_tagging_pending_table.dart';
import 'tables/bagging_tagging_purchase_list_table.dart';
import 'tables/con_transaction_table.dart';
import 'tables/consumption_location_list_table.dart';
import 'tables/default_location_table.dart';
import 'tables/equipment_list_table.dart';
import 'tables/failed_common_api_meta_table.dart';
import 'tables/fetch_imdg_class_table.dart';
import 'tables/goods_receipt_detail_label_table.dart';
import 'tables/purchase_order_item_serial_numbers_table.dart';
import 'tables/purchase_order_packets_table.dart';
import 'tables/transaction_dt_table.dart';
import 'tables/grn_location_serial_mapping_table.dart';
import 'tables/ihm_attachments_table.dart';
import 'tables/item_category_config_table.dart';
import 'tables/item_category_table.dart';
import 'tables/item_group.dart';
import 'tables/item_master_table.dart';
import 'tables/item_rob_details_table.dart';
import 'tables/item_section_table.dart';
import 'tables/item_sub_section_table.dart';
import 'tables/items_attachments_table.dart';
import 'tables/packet_details_table.dart';
import 'tables/pending_po_split_location_table.dart';
import 'tables/po_attachments_table.dart';
import 'tables/ports_table.dart';
import 'tables/purchase_order_items_table.dart';
import 'tables/purchase_order_table.dart';
import 'tables/quality_table.dart';
import 'tables/rfid_listing_table.dart';
import 'tables/serial_number_table.dart';
import 'tables/split_location_table.dart';
import 'tables/stock_location_table.dart';
import 'tables/stock_update_table.dart';
import 'tables/storage_location_table.dart';
import 'tables/time_stamp_meta_table.dart';
import 'tables/transaction_table.dart';
import 'tables/user_table.dart';
import 'tables/vessel_specification_table.dart';

Future<void> onCreateSchema(Database db, int version) async {
  //Common Tables
  await db.execute(UserTable.createTableQuery);
  await db.execute(PacketDetailsTable.createTableQuery);
  await db.execute(PurchaseOrderTable.createTableQuery);
  await db.execute(TransactionTable.createTableQuery);
  // await db.execute(GoodsReceiptDetailLabelTable.createTableQuery);
  await db.execute(PurchaseOrderItemsTable.createTableQuery);
  await db.execute(ItemsAttachmentsTable.createTableQuery);
  await db.execute(PoAttachmentsTable.createTableQuery);
  await db.execute(IhmAttachmentsTable.createTableQuery);
  await db.execute(SerialNumberTable.createTableQuery);
  await db.execute(PortsTable.createTableQuery);
  await db.execute(EquipmentListTable.createTableQuery);
  await db.execute(ItemGroup.createTableQuery);
  //Goods Receipt
  /*  await db.execute(PendingPoTable.createTableQuery);
  await db.execute(GoodsReceiptPoDetailTable.createTableQuery);*/
  //Item Master
  await db.execute(ItemMasterTable.createTableQuery);
  await db.execute(RfIdListingTable.createTableQuery);
  //Consumption transaction
  await db.execute(ConTransactionTable.createTableQuery);

  await db.execute(QualityTable.createTableQuery);
  await db.execute(TransactionItemsTable.createTableQuery);
  await db.execute(StockLocationTable.createTableQuery);
  await db.execute(StorageLocationTable.createTableQuery);
  await db.execute(SplitLocationTable.createTableQuery);
  //Stock Update transaction
  await db.execute(StockUpdateTable.createTableQuery);
  //Bagging and Tagging
  await db.execute(BaggingItemDetailsTable.createTableQuery);
  //purchase HD
  await db.execute(BaggingTaggingPendingTable.createTableQuery);
  //confirmation
  await db.execute(BaggingConfirmationListTable.createTableQuery);
  //purchase DT
  await db.execute(BaggingTaggingPurchaseListTable.createTableQuery);
  //EquipmentList
  await db.execute(IMDGClassTable.createTableQuery);
  //ItemCategory
  await db.execute(ItemCategoryTable.createTableQuery);
  //ItemSection
  await db.execute(ItemSectionTable.createTableQuery);
  //ItemSubSection
  await db.execute(ItemSubSectionTable.createTableQuery);
  //location_list
  await db.execute(ConsumptionLocationListTable.createTableQuery);
  //Time stamp meta data
  await db.execute(TimeStampMetaTable.createTableQuery);
  //Failed api meta data
  await db.execute(FailedCommonApiMetaTable.createTableQuery);
  //Default location table
  await db.execute(DefaultLocationTable.createTableQuery);
  //GRN Location Serial Mapping Table
  await db.execute(GRNLocationSerialMappingTable.createTableQuery);
  //Item Category Config
  await db.execute(ItemCategoryConfigTable.createTableQuery);
  //ItemRobDetails
  await db.execute(ItemRobDetailsTable.createTableQuery);
  await db.execute(VesselTable.createTableQuery);
  await db.execute(PendingPoSplitLocationTable.createTableQuery);
  await db.execute(PurchaseOrderItemsSerialNumbersTable.createTableQuery);

  await db.execute(AdminStructureTable.createTableQuery);
  await db.execute(PurchaseOrderPacketsTable.createTableQuery);
}

Future<void> onUpgradeSchema(
  Database db,
  int oldVersion,
  int newVersion,
) async {
  await UserTable.onUpgrade(db, oldVersion, newVersion);
  await PacketDetailsTable.onUpgrade(db, oldVersion, newVersion);
  await PurchaseOrderTable.onUpgrade(db, oldVersion, newVersion);
  await TransactionTable.onUpgrade(db, oldVersion, newVersion);
  await GoodsReceiptDetailLabelTable.onUpgrade(db, oldVersion, newVersion);
  await ItemsAttachmentsTable.onUpgrade(db, oldVersion, newVersion);
  await PoAttachmentsTable.onUpgrade(db, oldVersion, newVersion);
  await IhmAttachmentsTable.onUpgrade(db, oldVersion, newVersion);
  await ConTransactionTable.onUpgrade(db, oldVersion, newVersion);
  await QualityTable.onUpgrade(db, oldVersion, newVersion);
  await TransactionItemsTable.onUpgrade(db, oldVersion, newVersion);
  await StockLocationTable.onUpgrade(db, oldVersion, newVersion);
  await StorageLocationTable.onUpgrade(db, oldVersion, newVersion);
  await SplitLocationTable.onUpgrade(db, oldVersion, newVersion);
  await BaggingItemDetailsTable.onUpgrade(db, oldVersion, newVersion);
  await BaggingTaggingPendingTable.onUpgrade(db, oldVersion, newVersion);
  await BaggingConfirmationListTable.onUpgrade(db, oldVersion, newVersion);
  await EquipmentListTable.onUpgrade(db, oldVersion, newVersion);
  await IMDGClassTable.onUpgrade(db, oldVersion, newVersion);
  await ItemCategoryTable.onUpgrade(db, oldVersion, newVersion);
  await ItemSectionTable.onUpgrade(db, oldVersion, newVersion);
  await ItemSubSectionTable.onUpgrade(db, oldVersion, newVersion);
  await BaggingTaggingPurchaseListTable.onUpgrade(db, oldVersion, newVersion);
  await ConsumptionLocationListTable.onUpgrade(db, oldVersion, newVersion);
  await TimeStampMetaTable.onUpgrade(db, oldVersion, newVersion);
  await FailedCommonApiMetaTable.onUpgrade(db, oldVersion, newVersion);
  await DefaultLocationTable.onUpgrade(db, oldVersion, newVersion);
  await GRNLocationSerialMappingTable.onUpgrade(db, oldVersion, newVersion);
  // call other table upgrade methods
}
