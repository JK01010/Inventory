import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/di/service_locator.dart';
import '../core/service/barcode_scanner/presentation/bloc/barcode_bloc.dart';
import '../core/service/rfid/rfid_bloc.dart';
import '../core/service/speech_to_text/presentation/speech_to_text_bloc/speech_to_text_bloc.dart';
import '../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_confirmation_list/bagging_confirmation_list_bloc.dart';
import '../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_packet_list/bagging_packet_list_bloc.dart';
import '../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_confirmation_bloc/bagging_tagging_confirmation_bloc.dart';
import '../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_confirmation_search_bloc/bagging_confirmation_search_bloc.dart';
import '../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_item_details_bloc/bagging_item_details_bloc.dart';
import '../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_item_section/bagging_item_section_bloc.dart';
import '../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_item_sub_section/bagging_item_sub_section_bloc.dart';
import '../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_listing/bagging_tagging_list_bloc.dart';
import '../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_pending_search_bloc/bagging_pending_search_bloc.dart';
import '../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_purchase_list/bagging_tagging_purchase_list_bloc.dart';
import '../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_purchase_pending_bloc/bagging_tagging_purchase_pending_bloc.dart';
import '../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_purchase_pending_details_bloc/bagging_tagging_purchase_pending_details_bloc.dart';
import '../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_split_location_bloc/bagging_tagging_split_location_bloc.dart';
import '../features/bagging_tagging_confirmtaion/presentation/bloc/fetch_imdg_class_bloc/fetch_imdg_class_bloc.dart';
import '../features/consumption/presentation/bloc/consumption_add_page_bloc/consumption_add_page_bloc.dart';
import '../features/consumption/presentation/bloc/consumption_item_update_page_bloc/consumption_item_update_bloc.dart';
import '../features/consumption/presentation/bloc/consumption_location_bloc/consumption_location_bloc.dart';
import '../features/consumption/presentation/bloc/consumption_rfid_scanning_bloc/consumption_rfid_scanning_bloc.dart';
import '../features/consumption/presentation/bloc/consumption_transaction_bloc/consumption_transaction_bloc.dart';
import '../features/consumption/presentation/bloc/consumption_transaction_bloc/consumption_transaction_event.dart';
import '../features/dashboard/presentation/dashboard_bloc/dashboard_bloc.dart';
import '../features/good_receipts/presentation/goods_receipt_attachment_bloc/goods_receipt_attachment_bloc.dart';
import '../features/good_receipts/presentation/goods_receipt_detail_create_label_bloc/goods_receipt_create_label_bloc.dart';
import '../features/good_receipts/presentation/goods_receipt_detail_label_bloc/goods_receipt_label_bloc.dart';
import '../features/good_receipts/presentation/goods_receipt_label_attachment_bloc/goods_receipt_label_attachment_item_bloc.dart';
import '../features/good_receipts/presentation/goods_receipt_label_ihm_attachment_bloc/goods_receipt_label_ihm_attachment_bloc.dart';
import '../features/good_receipts/presentation/goods_receipt_packet_detail_bloc/goods_receipt_packet_detail_bloc.dart';
import '../features/good_receipts/presentation/goods_receipt_split_location_bloc/goods_receipt_split_location_bloc.dart';
import '../features/good_receipts/presentation/goods_receipt_transaction_detail_bloc/goods_receipts_transaction_detail_bloc.dart';
import '../features/good_receipts/presentation/goods_receipts_po_bloc/goods_receipts_po_bloc.dart';
import '../features/good_receipts/presentation/quality_bloc/quality_bloc.dart';
import '../features/good_receipts/presentation/storage_location_bloc/storage_location_bloc.dart';
import '../features/good_receipts/purchase_order/presentation/bloc/purchase_order_bloc/purchase_order_bloc.dart';
import '../features/good_receipts/purchase_order/presentation/bloc/purchase_order_filter_bloc/purchase_order_filter_bloc.dart';
import '../features/good_receipts/purchase_order_detail/presentation/purchase_order_detail_bloc/purchase_order_detail_bloc.dart';
import '../features/good_receipts/purchase_order_item_detail/presentation/purchase_order_detail_bloc/purchase_order_item_detail_bloc.dart';
import '../features/good_receipts/transaction/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import '../features/good_receipts/transaction/presentation/bloc/transaction_filter_bloc/transaction_filter_bloc.dart';
import '../features/good_receipts/transaction_detail/presentation/bloc/transaction_detail_bloc.dart';
import '../features/good_receipts/transaction_item_detail/presentation/bloc/transaction_item_detail_bloc.dart';
import '../features/item_master/presentation/bloc/item_master_listing_bloc/item_master_bloc.dart';
import '../features/item_master/presentation/bloc/rfid_view_bloc/rfid_view_bloc.dart';
import '../features/login/presentation/login_bloc/login_bloc.dart';
import '../features/packets/add_packets_sheet/presentation/bloc/add_packets_sheet_bloc.dart';
import '../features/profile/presentation/profile_bloc/profile_bloc.dart';
import '../features/serial_numbers_sheet/presentation/bloc/serial_numbers_listing_bloc.dart';
import '../features/splash/presentation/splash_bloc/bloc/splash_bloc.dart';
import '../features/stock_update/presentation/bloc/stock_update_add_page/stock_update_add_bloc.dart';
import '../features/stock_update/presentation/bloc/stock_update_page_bloc/stock_update_page_bloc.dart';
import '../features/stock_update/presentation/bloc/stock_update_rfid_scanning_bloc/stock_update_rfid_scanning_bloc.dart';
import '../features/stock_update/presentation/bloc/stock_update_transaction_listing_bloc/stock_update_transaction_listing_bloc.dart';
import '../features/theme/theme_bloc.dart';

final appBlocProviders = [
  BlocProvider<ThemeBloc>(create: (context) => sl<ThemeBloc>()),
  BlocProvider<LoginBloc>(create: (context) => sl<LoginBloc>()),
  BlocProvider<GoodsReceiptsPoBloc>(
    create: (context) => sl<GoodsReceiptsPoBloc>(),
  ),

  BlocProvider<BaggingItemDetailsBloc>(
    create:
        (context) =>
            sl<BaggingItemDetailsBloc>()
              ..add(BaggingItemDetailsInsertDataEvent()),
  ),

  BlocProvider<BaggingTaggingListBloc>(
    create:
        (context) =>
            sl<BaggingTaggingListBloc>()
              ..add(BaggingTaggingListInsertDataEvent()),
  ),
  BlocProvider<BaggingConfirmationListBloc>(
    create:
        (context) =>
            sl<BaggingConfirmationListBloc>()
              ..add(BaggingConfirmationListInsertDataEvent()),
  ),

  BlocProvider<BaggingItemDetailsBloc>(
    create: (context) => sl<BaggingItemDetailsBloc>(),
  ),

  BlocProvider<GoodsReceiptAttachmentBloc>(
    create: (context) => sl<GoodsReceiptAttachmentBloc>(),
    // ..add(InsertGoodsReceiptsAttachmentEvent()),
  ),
  BlocProvider<TransactionBloc>(create: (context) => sl<TransactionBloc>()),
  BlocProvider<GoodsReceiptLabelBloc>(
    create:
        (context) =>
            sl<
              GoodsReceiptLabelBloc
            >() /*..add(InsertGoodsReceiptsLabelEvent())*/,
  ),

  BlocProvider<RfidBloc>(create: (context) => sl<RfidBloc>()),

  //itemMaster
  BlocProvider<ItemMasterBloc>(create: (context) => sl<ItemMasterBloc>()),
  BlocProvider<RfidViewBloc>(
    create:
        (context) =>
            sl<RfidViewBloc>()..add(ItemMasterRfidListingInsertEvent()),
  ),

  //Consumption
  BlocProvider<ConsumptionTransactionBloc>(
    create:
        (context) =>
            sl<ConsumptionTransactionBloc>()
              ..add(ConsumptionTransactionInsertDataEvent()),
  ),
  BlocProvider<ConsumptionRfidScanningBloc>(
    create: (context) => sl<ConsumptionRfidScanningBloc>(),
  ),
  BlocProvider<GoodsReceiptCreateLabelBloc>(
    create: (context) => sl<GoodsReceiptCreateLabelBloc>(),
  ),
  BlocProvider<GoodsReceiptLabelAttachmentItemBloc>(
    create: (context) => sl<GoodsReceiptLabelAttachmentItemBloc>(),
  ),
  BlocProvider<GoodsReceiptLabelIhmAttachmentBloc>(
    create: (context) => sl<GoodsReceiptLabelIhmAttachmentBloc>(),
  ),
  BlocProvider<GoodsReceiptsTransactionDetailBloc>(
    create: (context) => sl<GoodsReceiptsTransactionDetailBloc>(),
  ),
  BlocProvider<StorageLocationBloc>(
    create:
        (context) =>
            sl<StorageLocationBloc>() /*..add(InsertStorageLocationEvent()),*/,
  ),
  BlocProvider<GoodsReceiptSplitLocationBloc>(
    create: (context) => sl<GoodsReceiptSplitLocationBloc>(),
  ),
  BlocProvider<ConsumptionAddPageBloc>(
    create: (context) => sl<ConsumptionAddPageBloc>(),
  ),
  BlocProvider<GoodsReceiptPacketDetailBloc>(
    create: (context) => sl<GoodsReceiptPacketDetailBloc>(),
  ),
  //ItemMaster
  BlocProvider<StockUpdateTransactionListingBloc>(
    create:
        (context) =>
            sl<StockUpdateTransactionListingBloc>()
              ..add(StockUpdateTransactionListingInsertEvent()),
  ),

  BlocProvider<StockUpdateRfidScanningBloc>(
    create: (context) => sl<StockUpdateRfidScanningBloc>(),
  ),
  BlocProvider<StockUpdatePageBloc>(
    create: (context) => sl<StockUpdatePageBloc>(),
  ),
  BlocProvider<StockUpdateAddBloc>(
    create: (context) => sl<StockUpdateAddBloc>(),
  ),
  BlocProvider<ConsumptionItemUpdateBloc>(
    create:
        (context) =>
            sl<ConsumptionItemUpdateBloc>()
              ..add(EquipmentListInsertDataEvent()),
  ),
  BlocProvider<FetchImdgClassBloc>(
    create:
        (context) =>
            sl<FetchImdgClassBloc>()..add(ImdgClassEventInsertDataEvent()),
  ),

  BlocProvider<BaggingItemSectionBloc>(
    create:
        (context) =>
            sl<BaggingItemSectionBloc>()..add(ItemSectionInsertDataEvent()),
  ),
  BlocProvider<BaggingItemSubSectionBloc>(
    create:
        (context) =>
            sl<BaggingItemSubSectionBloc>()
              ..add(ItemSubSectionInsertDataEvent()),
  ),
  BlocProvider<BaggingTaggingPurchaseListBloc>(
    create:
        (context) =>
            sl<BaggingTaggingPurchaseListBloc>()
              ..add(BaggingTaggingPurchaseListInsertDataEvent()),
  ),
  BlocProvider<QualityBloc>(create: (context) => sl<QualityBloc>()),
  BlocProvider<ConsumptionLocationBloc>(
    create:
        (context) =>
            sl<ConsumptionLocationBloc>()..add(InsertLocationDataEvent()),
  ),
  BlocProvider<BaggingPacketListBloc>(
    create: (context) => sl<BaggingPacketListBloc>(),
  ),
  //   BlocProvider<PurchaseOrderFilterBloc>(
  //   create: (context) => sl<PurchaseOrderFilterBloc>(),
  // ),
  BlocProvider<PurchaseOrderFilterBloc>(
    create: (context) => sl<PurchaseOrderFilterBloc>(),
  ),
  BlocProvider<TransactionFilterBloc>(
    create: (context) => sl<TransactionFilterBloc>(),
  ),

  BlocProvider<BaggingTaggingSplitLocationBloc>(
    create: (context) => sl<BaggingTaggingSplitLocationBloc>(),
  ),
  BlocProvider<BaggingPendingSearchBloc>(
    create: (context) => sl<BaggingPendingSearchBloc>(),
  ),
  BlocProvider<BaggingConfirmationSearchBloc>(
    create: (context) => sl<BaggingConfirmationSearchBloc>(),
  ),

  BlocProvider<SpeechToTextBloc>(create: (context) => sl<SpeechToTextBloc>()),

  BlocProvider<ProfileBloc>(create: (context) => sl<ProfileBloc>()),
  BlocProvider<DashboardBloc>(create: (context) => sl<DashboardBloc>()),

  BlocProvider<BarcodeBloc>(create: (context) => sl<BarcodeBloc>()),

  BlocProvider<SplashBloc>(create: (context) => sl<SplashBloc>()),
  BlocProvider<BaggingTaggingPurchasePendingBloc>(
    create: (context) => sl<BaggingTaggingPurchasePendingBloc>(),
  ),
  BlocProvider<BaggingTaggingPurchasePendingDetailsBloc>(
    create: (context) => sl<BaggingTaggingPurchasePendingDetailsBloc>(),
  ),
  BlocProvider<BaggingTaggingConfirmationBloc>(
    create: (context) => sl<BaggingTaggingConfirmationBloc>(),
  ),
  BlocProvider<PurchaseOrderBloc>(create: (context) => sl<PurchaseOrderBloc>()),
  BlocProvider<PurchaseOrderDetailBloc>(
    create: (context) => sl<PurchaseOrderDetailBloc>(),
  ),
  BlocProvider<PurchaseOrderItemDetailBloc>(
    create: (context) => sl<PurchaseOrderItemDetailBloc>(),
  ),
  BlocProvider<TransactionDetailBloc>(
    create: (context) => sl<TransactionDetailBloc>(),
  ),
  BlocProvider<TransactionItemDetailBloc>(
    create: (context) => sl<TransactionItemDetailBloc>(),
  ),
  BlocProvider<SerialNumbersListingBloc>(
    create: (context) => sl<SerialNumbersListingBloc>(),
  ),
  BlocProvider<AddPacketsSheetBloc>(
    create: (context) => sl<AddPacketsSheetBloc>(),
  ),
];
