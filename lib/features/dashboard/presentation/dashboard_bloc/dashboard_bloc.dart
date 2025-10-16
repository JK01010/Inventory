import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../common_feature/domain/usecase/fetch_all_port_list_usecase.dart';
import '../../../common_feature/domain/usecase/fetch_default_location_usecase.dart';
import '../../../common_feature/domain/usecase/fetch_item_category_usecase.dart';
import '../../../common_feature/domain/usecase/fetch_stock_location_usecase.dart';

import '../../../common_feature/domain/usecase/get_all_admin_structure_usecase.dart';
import '../../../common_feature/domain/usecase/get_all_vessel_specification.dart';
import '../../../common_feature/domain/usecase/insert_item_category_usecase.dart';
import '../../../common_feature/domain/usecase/insert_storage_location_usecase.dart';
import '../../../consumption/domin/usecases/insert_consumption_equipment_list.dart';
import '../../../consumption/domin/usecases/insert_consumption_location_list_usecase.dart';
import '../../../consumption/domin/usecases/insert_consumption_transaction_list_usecase.dart';
import '../../../good_receipts/domain/use_cases/fetch_all_items_api_usecase.dart';
import '../../../good_receipts/domain/use_cases/goods_receipts_po_usecase/item_category_config_usecase.dart';
import '../../../good_receipts/domain/use_cases/goods_receipts_po_usecase/item_rob_details_usecase.dart';
import '../../../good_receipts/purchase_order/domain/usecase/get_purchase_order_from_api_usecase.dart';
import '../../../good_receipts/purchase_order_detail/domain/use_cases/get_purchase_order_items_usecase.dart';
import '../../../good_receipts/purchase_order_item_detail/domain/use_cases/get_imdg_class_usecase.dart';
import '../../../good_receipts/purchase_order_item_detail/domain/use_cases/get_quality_list_use_case.dart';
import '../../../good_receipts/transaction/domain/usecase/get_all_transaction_from_api_usecase.dart';
import '../../../good_receipts/transaction_item_detail/domain/usecase/get_all_transaction_item_detail_usecase.dart';
import '../../../good_receipts/transaction_item_detail/domain/usecase/get_split_location_data_usecase.dart';
import '../../../item_master/domin/usecases/item_master_insert_use_case.dart';

import '../../../good_receipts/domain/use_cases/transaction_usecase/get_all_goods_receipt_transaction_use_case.dart';
import '../../../good_receipts/domain/use_cases/transaction_usecase/get_all_grn_transaction_item_use_case.dart';

import '../../../login/domain/usecases/logout_usecase.dart';
import '../../../rfid_scanner/scanner.dart';
import '../../../stock_update/domin/usecases/stock_update_table_insert_usecase.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({
    required this.fetchAllPortListUseCase,
    required this.logoutUseCase,
    required this.itemMasterInsertUseCase,
    required this.fetchStockLocationUseCase,
    required this.fetchDefaultLocationUseCase,
    required this.getAllGoodsReceiptTransactionUseCase,
    required this.getAllGrnTransactionItemUseCase,
    required this.getSplitLocationDataUseCase,
    required this.getAllItemsApiUseCase,
    required this.insertStorageLocationUseCase,
    required this.getAllVesselSpecification,
    required this.getPurchaseOrderItemsListUseCase,
    required this.fetchItemCategoryUsecase,
    required this.insertItemCategoryUsecase,
    required this.getAllTransactionFromApiUseCase,
    required this.fetchPurchaseOrderFromApiUsecase,
    required this.getAllTransactionItemDetailUsecase,
    required this.getQualityListUseCase,
    required this.getImdgClassUseCase,
    required this.insertConsumptionTransactionUseCase,
    required this.stockUpdateInsertUseCase,
    required this.insertEquipmentListUseCase,
    required this.insertConsumptionLocationListUseCase,
    required this.itemRobDetailsUseCase,
    required this.getAllAdminStructureUseCase
  }) : super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) async {
      switch (event) {
        case FetchAllCommonApi():
          await _fetchAllCommonApi(event, emit);
        case LogoutEvent():
          await onLogoutEvent(event, emit);
      }
    });
  }

  final FetchAllPortListUseCase fetchAllPortListUseCase;
  final ItemMasterInsertUseCase itemMasterInsertUseCase;
  final FetchStockLocationUseCase fetchStockLocationUseCase;

  final FetchDefaultLocationUseCase fetchDefaultLocationUseCase;
  final GetAllGoodsReceiptTransactionUseCase
  getAllGoodsReceiptTransactionUseCase;
  final GetAllGrnTransactionItemUseCase getAllGrnTransactionItemUseCase;
  final LogoutUseCase logoutUseCase;
  final GetSplitLocationDataUseCase getSplitLocationDataUseCase;
  final GetAllItemsApiUseCase getAllItemsApiUseCase;

  // final GetAllPoItemsUseCase getAllPoItemsUseCase;

  final InsertStorageLocationUseCase insertStorageLocationUseCase;
  final GetAllVesselSpecification getAllVesselSpecification;
  final GetPurchaseOrderItemsListUseCase getPurchaseOrderItemsListUseCase;
  final GetItemCategoryUsecase fetchItemCategoryUsecase;
  final InsertItemCategoryUsecase insertItemCategoryUsecase;
  final GetAllTransactionFromApiUseCase getAllTransactionFromApiUseCase;
  final GetPurchaseOrderFromApiUsecase fetchPurchaseOrderFromApiUsecase;
  final GetAllTransactionItemDetailUsecase getAllTransactionItemDetailUsecase;
  final GetQualityListUseCase getQualityListUseCase;
  final GetImdgClassUseCase getImdgClassUseCase;
  //consumptionListing
  final InsertConsumptionTransactionUseCase insertConsumptionTransactionUseCase;
  //stockUpdateListing
  final StockUpdateInsertUseCase stockUpdateInsertUseCase;
  //Equipment
  final InsertEquipmentListUseCase insertEquipmentListUseCase;
  //location
  final InsertConsumptionLocationListUseCase insertConsumptionLocationListUseCase;
  //robDetails
  final ItemRobDetailsUseCase itemRobDetailsUseCase;
  //adminStructure
  final GetAllAdminStructureUseCase getAllAdminStructureUseCase;


  Future<void> _fetchAllCommonApi(
    FetchAllCommonApi event,
    Emitter<DashboardState> emit,
  ) async {
    await getPermission();
    emit(DashboardLoading());

    // try {
    await getAllVesselSpecification();
    await insertStorageLocationUseCase();
    await getSplitLocationDataUseCase();
    await getAllItemsApiUseCase();
    await getPurchaseOrderItemsListUseCase();
    await fetchDefaultLocationUseCase();
    await fetchAllPortListUseCase();
    await fetchItemCategoryUsecase();
    await insertItemCategoryUsecase();
    await itemMasterInsertUseCase();
    await getAllGoodsReceiptTransactionUseCase();
    await fetchStockLocationUseCase();
    await getAllTransactionFromApiUseCase();
    await fetchPurchaseOrderFromApiUsecase();
    await getAllTransactionItemDetailUsecase();
    await getQualityListUseCase();
    await getImdgClassUseCase();
    await insertConsumptionTransactionUseCase();
    await stockUpdateInsertUseCase();
    await insertConsumptionLocationListUseCase();
    await insertEquipmentListUseCase();
    await itemRobDetailsUseCase(itemID: 0);
    await getAllAdminStructureUseCase();

    final getItemCategoryConfigUseCase = sl<GetItemCategoryConfigUseCase>();
    final result = await getItemCategoryConfigUseCase.getItemCategoryConfig();
    emit(DashboardSuccess());
    // } catch (e) {
    //   debugPrint("Error in _fetchAllCommonApi: $e");
    //   emit(DashboardFailure());
    // }
  }

  Future<void> onLogoutEvent(
    LogoutEvent event,
    Emitter<DashboardState> emit,
  ) async {
    final logoutFailureOrSuccess = await logoutUseCase();
    logoutFailureOrSuccess.fold(
      (failure) {
        emit(LogoutFailed());
      },
      (success) {
        emit(LogoutSuccess());
      },
    );
  }
}
