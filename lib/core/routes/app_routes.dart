import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_confirmation_search_bloc/bagging_confirmation_search_bloc.dart';
import '../../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_pending_search_bloc/bagging_pending_search_bloc.dart';
import '../../features/bagging_tagging_confirmtaion/presentation/page/bag_tag_listing_page.dart';
import '../../features/bagging_tagging_confirmtaion/presentation/page/bagging_tagging_confirm_scanning_page.dart';
import '../../features/bagging_tagging_confirmtaion/presentation/page/bagging_tagging_details_page.dart';
import '../../features/bagging_tagging_confirmtaion/presentation/page/choose_storage_location_page.dart';
import '../../features/bagging_tagging_confirmtaion/presentation/page/goods_details_page.dart';
import '../../features/bagging_tagging_confirmtaion/presentation/widgets/bagging_confirmation_search_page_widget.dart';
import '../../features/bagging_tagging_confirmtaion/presentation/widgets/bagging_confirmation_storage_details_page.dart';
import '../../features/bagging_tagging_confirmtaion/presentation/widgets/bagging_pending_search_widget.dart';
import '../../features/bagging_tagging_confirmtaion/presentation/widgets/bagging_print_rfid_page.dart';
import '../../features/bagging_tagging_confirmtaion/presentation/widgets/view_rfid_list_details_page.dart';
import '../../features/bagging_tagging_confirmtaion/presentation/widgets/view_rfid_list_viewing_widget.dart';
import '../../features/common_feature/domain/entities/item_entity.dart';
import '../../features/consumption/domin/entities/consumption_rfid_scanning_view_entity_model.dart';
import '../../features/consumption/presentation/pages/consumption_add_page.dart';
import '../../features/consumption/presentation/pages/consumption_item_update_page.dart';
import '../../features/consumption/presentation/pages/consumption_rfid_scanning_page.dart';
import '../../features/consumption/presentation/pages/consumption_transaction_listing_page.dart';
import '../../features/consumption/presentation/pages/search_pages/consumption_item_update_search_page.dart';
import '../../features/consumption/presentation/pages/search_pages/consumption_transaction_rfid_scanning_search_page.dart';
import '../../features/consumption/presentation/pages/search_pages/consumption_transaction_search_page.dart';
import '../../features/consumption/presentation/pages/search_pages/search_equipment_list_page.dart';
import '../../features/consumption/presentation/pages/search_pages/search_location_list_page.dart';
import '../../features/dashboard/presentation/page/dashboard_page.dart';
import '../../features/good_receipts/data/models/attachments_arguments_model.dart';
import '../../features/good_receipts/domain/entities/goods_receipt_purchase_item_detail_entity.dart';
import '../../features/good_receipts/domain/entities/goods_receipt_transaction_entity.dart';
import '../../features/good_receipts/presentation/add_manual_page.dart';
import '../../features/good_receipts/presentation/create_label_page.dart';
import '../../features/good_receipts/presentation/goods_receipts_detail_page.dart';
import '../../features/good_receipts/presentation/goods_receipts_page.dart';
import '../../features/good_receipts/presentation/print_rfid_page.dart';
import '../../features/good_receipts/presentation/widgets/add_manually_item_listing_page.dart';
import '../../features/good_receipts/presentation/widgets/attachments_listing_widget.dart';
import '../../features/good_receipts/presentation/widgets/create_label_details_page.dart';
import '../../features/good_receipts/presentation/widgets/goods_receipt_transaction_item_detail_page.dart';
import '../../features/good_receipts/presentation/widgets/number_of_packets_widget.dart';
import '../../features/good_receipts/purchase_order/domain/entity/purchase_order_entity.dart';
import '../../features/good_receipts/purchase_order/presentation/bloc/purchase_order_search_bloc/purchase_order_search_bloc.dart';
import '../../features/good_receipts/purchase_order/presentation/widgets/purchase_order_search_widget.dart';
import '../../features/good_receipts/purchase_order_detail/presentation/pages/purchase_order_detail_page.dart';
import '../../features/good_receipts/purchase_order_item_detail/presentation/pages/purchase_order_item_detail_page.dart';
import '../../features/good_receipts/purchase_order_item_detail/presentation/pages_params/purchase_order_item_detail_page_params.dart';
import '../../features/good_receipts/transaction/domain/entity/transaction_entity.dart';
import '../../features/good_receipts/transaction/presentation/bloc/transaction_search_bloc/transaction_search_bloc.dart';
import '../../features/good_receipts/transaction/presentation/widgets/transaction_search_widget.dart';
import '../../features/good_receipts/transaction_detail/presentation/page/transaction_detail_page.dart';
import '../../features/good_receipts/transaction_item_detail/presentation/pages/transaction_item_detail_page.dart';
import '../../features/good_receipts/transaction_item_detail/presentation/pages_params/purchase_order_item_detail_page_params.dart';
import '../../features/item_master/presentation/pages/item_master_listing_page.dart';
import '../../features/item_master/presentation/pages/item_master_rfid_view_page.dart';
import '../../features/item_master/presentation/pages/secondary_pages/item_master_listing_search.dart';
import '../../features/login/presentation/login_page.dart';
import '../../features/profile/presentation/page/profile_detail_screen.dart';
import '../../features/profile/presentation/page/profile_screen.dart';
import '../../features/profile/presentation/page/profile_sync_status_page.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';
import '../../features/stock_update/domin/entities/stock_update_rfid_scanning_view_entity_model.dart';
import '../../features/stock_update/presentation/pages/search_pages/stock_update_rfid_scanning_search_page.dart';
import '../../features/stock_update/presentation/pages/search_pages/stock_update_search_page.dart';
import '../../features/stock_update/presentation/pages/search_pages/stock_update_transaction_search_page.dart';
import '../../features/stock_update/presentation/pages/stock_update_add_page.dart';
import '../../features/stock_update/presentation/pages/stock_update_page.dart';
import '../../features/stock_update/presentation/pages/stock_update_rfid_scanning_page.dart';
import '../../features/stock_update/presentation/pages/stock_update_transaction_listing_page.dart';
import '../di/service_locator.dart';
import '../service/barcode_scanner/barcode_scanner_page.dart';
import 'route_name.dart';

final appRouter = GoRouter(
  initialLocation: AppRoute.splashScreen.path,

  routes: getRoutes(),
);

List<GoRoute> getRoutes() {
  return AppRoute.values.map((route) {
    switch (route) {
      case AppRoute.login:
        return GoRoute(
          path: route.path,
          builder: (context, state) => LoginScreen(),
        );
      case AppRoute.goodsReceipts:
        return GoRoute(
          path: route.path,
          builder: (context, state) => GoodsReceiptsPage(),
        );
      case AppRoute.goodsReceiptsDetail:
        return GoRoute(
          path: route.path,
          builder: (context, state) => GoodsReceiptsDetailPage(),
        );
      case AppRoute.dashboard:
        return GoRoute(
          path: route.path,
          builder: (context, state) => DashboardScreen(),
        );
      case AppRoute.baggingTaggingListing:
        return GoRoute(
          path: route.path,
          builder: (context, state) => BagTagListingPage(),
        );
      case AppRoute.profile:
        return GoRoute(
          path: route.path,
          builder: (context, state) => ProfileScreen(),
        );

      case AppRoute.numberOfReceipts:
        return GoRoute(
          path: route.path,
          builder: (context, state) => NumberOfPacketsWidget(),
        );
      case AppRoute.printRfidPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) {
            return PrintRfidPage();
          },
        );
      case AppRoute.baggingPrintRfidPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) {
            return BaggingPrintRfidPage();
          },
        );
      case AppRoute.createLabelPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>;
            return CreateLabelPage(
              goodsReceiptPurchaseOrderLineItemEntity:
                  data["goodsReceiptPurchaseOrderLineItemEntity"],
            );
          },
        );

      case AppRoute.baggingTaggingDetails:
        return GoRoute(
          path: route.path,
          builder: (context, state) {
            final list = state.extra as GoodsReceiptsTransactionEntity;
            return BaggingTaggingDetailsView(items: list);
          },

          // builder: (context, state) => BaggingTaggingDetailsView(),
        );
      case AppRoute.goodsDetailsPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) {
            final purchaseList =
                state.extra as GoodsReceiptPurchaseItemDetailEntity;
            return GoodsDetailsPage(purchaseItems: purchaseList);
          },
          // builder: (context, state) => GoodsDetailsPage(),
        );

      case AppRoute.goodsReceiptsSearch:
        return GoRoute(
          path: route.path,
          builder:
              (context, state) => BlocProvider(
                create: (context) => sl<PurchaseOrderSearchBloc>(),
                child: PurchaseOrderSearchWidget(),
              ),
        );

      case AppRoute.transactionSearch:
        return GoRoute(
          path: route.path,
          builder:
              (context, state) => BlocProvider(
                create: (context) => sl<TransactionSearchBloc>(),
                child: TransactionSearchWidget(),
              ),
        );

      case AppRoute.profileSyncStatusPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) => ProfileSyncStatusPage(),
        );

      case AppRoute.baggingTaggingConfirmationScanning:
        return GoRoute(
          path: route.path,
          builder:
              (context, state) =>
                  BaggingTaggingConfirmScanningPage(grnId: state.extra as int),
        );

      case AppRoute.chooseStorageLocationPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>;
            return ChooseStorageLocationPage(
              screenType: data['screenType'] as String,
            );
          },
        );
      case AppRoute.addManually:
        return GoRoute(
          path: route.path,
          builder:(context, state) {
            final data = state.extra as Map<String, dynamic>;
            return AddManualPage(
              selectedItemId: data['selectedItemId'] as int,
              screenType: data['screenType'] as String,
            );
          },
        );
      case AppRoute.itemMaster:
        return GoRoute(
          path: route.path,
          builder: (context, state) => ItemMasterListingPage(),
        );

      case AppRoute.attachmentsListingWidgetPage:
        return GoRoute(
          path: route.path,
          // builder: (context, state) => AttachmentsListingWidgetPage(images: [], initialIndex: 0,),
          builder: (context, state) {
            final args = state.extra as AttachmentsArguments;
            return AttachmentsListingWidgetPage(
              initialIndex: args.initialIndex,
              attachmentList: args.attachmentList,
            );
          },
        );
      //Consumption

      case AppRoute.consumptionTransaction:
        return GoRoute(
          path: route.path,
          builder: (context, state) => ConsumptionTransactionListingPage(),
        );
      case AppRoute.consumptionAdd:
        return GoRoute(
          path: route.path,
          builder: (context, state) => ConsumptionAddPage(),
        );
      case AppRoute.consumptionRFIDScan:
        return GoRoute(
          path: route.path,
          builder: (context, state) => ConsumptionRFIDScanningPage(),
        );
      case AppRoute.consumption:
        return GoRoute(
          path: route.path,
          builder: (context, state) {
            final list = state.extra as List<ConsumptionRfidListingViewEntity>;
            return ConsumptionItemUpdatePage(selectedList: list);
          },
        );

      case AppRoute.viewRfidListViewing:
        return GoRoute(
          path: route.path,
          // builder:
          //     (context, state) =>
          //         ViewRfidListViewing(
          //           screenType: state.extra as String,
          //           itemId: state.extra as int,),
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>;
            return ViewRfidListViewing(
              screenType: data['screenType'] as String,
              itemId: data['itemId'] as int,
            );
          },
        );
      case AppRoute.itemMasterViewRfidListViewing:
        return GoRoute(
          path: route.path,
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>;
            return ItemMasterRfidViewPage(
              screenType: data['screenType'] as String,
              selectedItemId: data['selectedItemId'] as int,
            );
          },
        );

      case AppRoute.viewRfidListDetailsPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) => ViewRfidListDetailsPage(),
        );
      case AppRoute.consumptionSearchEquipmentListPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) {
            final index = state.extra as int;
            return SearchEquipmentListPage(selectedItemIndex: index);
          },
        );
      case AppRoute.consumptionSearchLocationListPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) {
            final index = state.extra as int;
            return SearchLocationListPage(selectedItemIndex: index);
          },
        );

      //StockUpdate
      case AppRoute.stockUpdateTransaction:
        return GoRoute(
          path: route.path,
          builder: (context, state) => StockUpdateTransactionListingPage(),
        );
      case AppRoute.stockUpdateAdd:
        return GoRoute(
          path: route.path,
          builder: (context, state) => StockUpdateAddPage(),
        );
      case AppRoute.stockUpdate:
        return GoRoute(
          path: route.path,
          builder: (context, state) {
            final list = state.extra as List<StockUpdateRfidListingViewEntity>;
            return StockUpdatePage(selectedList: list);
          },
        );
      case AppRoute.stockUpdateRFIDScan:
        return GoRoute(
          path: route.path,
          builder: (context, state) => StockUpdateRFIDScanningPage(),
        );

      case AppRoute.addManuallyItemListingPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) {
            final itemId = state.extra as int;
            return AddManuallyItemListingPage(selectedItemId: itemId);
          },
        );
      case AppRoute.createLabelDetailsPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) => CreateLabelDetailsPage(),
        );
      case AppRoute.goodsReceiptTransactionItemDetailPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>;
            return GoodsReceiptTransactionItemDetailPage(
              grnDtId: data["grnDtId"],
              selectedItemPosition: data["selectedItemPosition"],
            );
          },
        );
      case AppRoute.searchConsumptionTransactionPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) => ConsumptionTranSearchWidget(),
        );
      case AppRoute.searchConsumptionTrnRfidListingPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) => ConsumptionTrnRfidListingSearchWidget(),
        );
      case AppRoute.searchConsumptionItemUpdatePage:
        return GoRoute(
          path: route.path,
          builder: (context, state) => ConsumptionItemUpdateSearchWidget(),
        );
      case AppRoute.searchStockUpdateTransactionPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) => StockUpdateTranSearchWidget(),
        );
      case AppRoute.searchItemPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) => ItemMasterSearchPage(),
        );
      case AppRoute.baggingConfirmationStorageDetailsPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>?;
            return BaggingConfirmationStorageDetailsPage(
              selectedItemIds: data?['selectedItemIds'] as List<int>? ?? [],
              grnId: data?['grnId'] as int? ?? 0,
              storageLocId: data?['storageLocId'] as int? ?? 0,
            );
          },
        );
      case AppRoute.searchStockUpdateRfidListingPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) => StockUpdateRfidListingSearchWidget(),
        );
      case AppRoute.searchStockUpdatePage:
        return GoRoute(
          path: route.path,
          builder: (context, state) => StockUpdateSearchWidget(),
        );
      case AppRoute.baggingPendingSearch:
        return GoRoute(
          path: route.path,
          builder:
              (context, state) => BlocProvider(
                create: (context) => sl<BaggingPendingSearchBloc>(),
                child: BaggingPendingSearchWidget(),
              ),
        );
      case AppRoute.baggingConfirmationSearch:
        return GoRoute(
          path: route.path,
          builder:
              (context, state) => BlocProvider(
                create: (context) => sl<BaggingConfirmationSearchBloc>(),
                child: BaggingConfirmationSearchPageWidget(),
              ),
        );
      case AppRoute.profileDetailPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) => ProfileDetailScreen(),
        );
      case AppRoute.barcodeScannerPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) => BarcodeScannerPage(),
        );
      case AppRoute.splashScreen:
        return GoRoute(
          path: route.path,
          builder: (context, state) => SplashScreen(),
        );
      case AppRoute.purchaseOrderDetailPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) {
            final data = state.extra as PurchaseOrderEntity;
            return PurchaseOrderDetailPage(purchaseOrderEntity: data);
          },
        );
      case AppRoute.purchaseOrderItemDetailPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) {
            final data = state.extra as PurchaseOrderItemDetailPageParams;
            return PurchaseOrderItemDetailPage(
              purchaseOrderItemDetailPageParams: data,
            );
          },
        );
      case AppRoute.transactionDetailPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) {
            final data = state.extra as TransactionEntity;
            return TransactionDetailPage(transactionEntity: data);
          },
        );
      case AppRoute.transactionItemDetailPage:
        return GoRoute(
          path: route.path,
          builder: (context, state) {
            final data = state.extra as TransactionItemDetailPageParams;
            return TransactionItemDetailPage(transactionItemDetailPageParams: data);
          },
        );
    }
  }).toList();
}
