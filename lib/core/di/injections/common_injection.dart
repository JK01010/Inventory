import 'package:encrypt_shared_preferences/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../config/network_config.dart';
import '../../../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_item_section/bagging_item_section_bloc.dart';
import '../../../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_item_sub_section/bagging_item_sub_section_bloc.dart';
import '../../../features/common_feature/data/data_source/common_local_data_source.dart';
import '../../../features/common_feature/data/data_source/common_network_data_source.dart';
import '../../../features/common_feature/data/repositories/common_repository_impl.dart';
import '../../../features/common_feature/domain/repositories/common_repository.dart';
import '../../../features/common_feature/domain/usecase/common_usecase.dart';
import '../../../features/common_feature/domain/usecase/fetch_all_port_list_db_usecase.dart';
import '../../../features/common_feature/domain/usecase/fetch_all_port_list_usecase.dart';
import '../../../features/common_feature/domain/usecase/fetch_default_location_usecase.dart';
import '../../../features/common_feature/domain/usecase/fetch_item_category_usecase.dart';
import '../../../features/common_feature/domain/usecase/fetch_stock_location_usecase.dart';
import '../../../features/common_feature/domain/usecase/get_all_admin_structure_usecase.dart';
import '../../../features/common_feature/domain/usecase/get_all_equipment_list_usecase.dart';
import '../../../features/common_feature/domain/usecase/get_all_po_items.dart';
import '../../../features/common_feature/domain/usecase/get_all_vessel_specification.dart';
import '../../../features/common_feature/domain/usecase/get_equipment_children_usecase.dart';
import '../../../features/common_feature/domain/usecase/insert_item_category_usecase.dart';
import '../../../features/common_feature/domain/usecase/insert_pending_po_split_location_data_usecase.dart';
import '../../../features/common_feature/domain/usecase/insert_storage_location_usecase.dart';
import '../../../features/common_feature/domain/usecase/item_section_fetch_usecase.dart';
import '../../../features/common_feature/domain/usecase/item_section_insert_usecase.dart';
import '../../../features/common_feature/domain/usecase/item_sub_section_fetch_usecase.dart';
import '../../../features/common_feature/domain/usecase/item_sub_section_insert_usecase.dart';
import '../../../features/consumption/domin/repository/consumption_repository.dart';
import '../../../features/consumption/domin/usecases/insert_consumption_equipment_list.dart';
import '../../../features/consumption/domin/usecases/insert_consumption_location_list_usecase.dart';
import '../../../features/consumption/domin/usecases/insert_consumption_transaction_list_usecase.dart';
import '../../../features/dashboard/presentation/dashboard_bloc/dashboard_bloc.dart';
import '../../../features/good_receipts/domain/use_cases/fetch_all_items_api_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/goods_receipts_po_usecase/item_rob_details_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/transaction_usecase/get_all_goods_receipt_transaction_use_case.dart';
import '../../../features/good_receipts/domain/use_cases/transaction_usecase/get_all_grn_transaction_item_use_case.dart';
import '../../../features/good_receipts/purchase_order/domain/usecase/get_purchase_order_from_api_usecase.dart';
import '../../../features/good_receipts/purchase_order_detail/domain/use_cases/get_purchase_order_items_usecase.dart';
import '../../../features/good_receipts/purchase_order_item_detail/domain/use_cases/get_imdg_class_usecase.dart';
import '../../../features/good_receipts/purchase_order_item_detail/domain/use_cases/get_quality_list_use_case.dart';
import '../../../features/good_receipts/transaction/domain/usecase/get_all_transaction_from_api_usecase.dart';
import '../../../features/good_receipts/transaction_item_detail/domain/usecase/get_all_transaction_item_detail_usecase.dart';
import '../../../features/good_receipts/transaction_item_detail/domain/usecase/get_split_location_data_usecase.dart';
import '../../../features/item_master/domin/usecases/item_master_insert_use_case.dart';
import '../../../features/login/domain/usecases/logout_usecase.dart';
import '../../../features/profile/presentation/profile_bloc/profile_bloc.dart';
import '../../../features/stock_update/domin/repository/stock_update_repository.dart';
import '../../../features/stock_update/domin/usecases/stock_update_table_insert_usecase.dart';
import '../../service/db_service/table_data_manipulation/admin_structure_data_processor.dart';
import '../../service/db_service/table_data_manipulation/common_data_processor.dart';
import '../../service/db_service/table_data_manipulation/failed_common_api_local_data_source.dart';
import '../../service/db_service/table_data_manipulation/meta_local_data_source.dart';
import '../../service/network/connectivity_manager.dart';
import '../../service/network/domain/network_connectivity_usecase.dart';
import '../service_locator.dart';

void commonInjection() {
  sl
    //common data source


    ..registerSingleton<MetaLocalDataSource>(
      MetaLocalDataSourceImpl(db: sl<Database>()),
    )
    ..registerSingleton<CommonNetworkDataSource>(
      CommonNetworkDataSourceImpl(
        commonDatasource: sl<CommonDatasource>(),
        appNetworkClient: sl<AppNetworkClient>(),
        encryptedSharedPreferences: sl<EncryptedSharedPreferences>(),
        metaLocalDataSource: sl<MetaLocalDataSource>(),
        failedCommonApiLocalDataSource: sl<FailedCommonApiLocalDataSource>(),
      ),
    )
    ..registerSingleton<CommonRepository>(
      CommonRepositoryImpl(
        commonLocalDataSource: sl<CommonLocalDataSource>(),
        commonNetworkDataSource: sl<CommonNetworkDataSource>(),
        connectivityManager: sl<ConnectivityManager>(),
        failedCommonApiLocalDataSource: sl<FailedCommonApiLocalDataSource>(),
        metaLocalDataSource: sl<MetaLocalDataSource>(),
      ),
    )
    //CM use case
    ..registerSingleton<CommonUseCase>(
      CommonUseCaseImpl(commonRepository: sl<CommonRepository>()),
    )
    ..registerSingleton<GetAllEquipmentListUseCase>(
      GetAllEquipmentListUseCaseImpl(commonRepository: sl<CommonRepository>()),
    )
    ..registerSingleton<GetEquipmentChildrenUsecase>(
      GetEquipmentChildrenUsecaseImpl(commonRepository: sl<CommonRepository>()),
    )
    ..registerSingleton<InsertItemCategoryUsecase>(
      InsertItemCategoryUsecaseImpl(repository: sl<CommonRepository>()),
    )
    ..registerSingleton<GetItemCategoryUsecase>(
      GetItemCategoryUsecaseImpl(commonRepository: sl<CommonRepository>()),
    )
    ..registerSingleton<ItemSectionFetchUsecase>(
      ItemSectionFetchUsecaseImpl(commonRepository: sl<CommonRepository>()),
    )
    ..registerSingleton<ItemSectionInsertUsecase>(
      ItemSectionInsertUsecaseImpl(repository: sl<CommonRepository>()),
    )
    ..registerSingleton<ItemSubSectionInsertUsecase>(
      ItemSubSectionInsertUsecaseImpl(repository: sl<CommonRepository>()),
    )
    ..registerSingleton<ItemSubSectionFetchUsecase>(
      ItemSubSectionFetchUsecaseImpl(commonRepository: sl<CommonRepository>()),
    )
    ..registerSingleton<NetworkConnectivityUseCase>(
      NetworkConnectivityUseCaseImpl(
        connectivityManager: sl<ConnectivityManager>(),
      ),
    )
    // Bloc
    /*..registerSingleton<ConsumptionItemUpdateBloc>(
      ConsumptionItemUpdateBloc(
        insertEquipmentListUseCase: sl<InsertEquipmentListUsecase>(),
        getAllEquipmentListUseCase: sl<GetAllEquipmentListUsecase>(),
        getEquipmentChildrenUseCase: sl<GetEquipmentChildrenUsecase>(),
        conTranMultipleInsertUseCase: null,
      ),
    )*/
    ..registerSingleton<BaggingItemSectionBloc>(
      BaggingItemSectionBloc(
        itemSectionInsertUsecase: sl<ItemSectionInsertUsecase>(),
        itemSectionFetchUsecase: sl<ItemSectionFetchUsecase>(),
      ),
    )
    ..registerSingleton<BaggingItemSubSectionBloc>(
      BaggingItemSubSectionBloc(
        itemSubSectionInsertUsecase: sl<ItemSubSectionInsertUsecase>(),
        itemSubSectionFetchUsecase: sl<ItemSubSectionFetchUsecase>(),
      ),
    )
    ..registerSingleton<ProfileBloc>(
      ProfileBloc(encryptedSharedPreferences: sl<EncryptedSharedPreferences>()),
    )
    ..registerSingleton<FetchAllPortListUseCase>(
      FetchAllPortListUseCaseImpl(commonRepository: sl<CommonRepository>()),
    )
    ..registerSingleton<GetAllPortListFromDbUseCase>(
      GetAllPortListFromDbUseCaseImpl(commonRepository: sl<CommonRepository>()),
    )
    ..registerSingleton<FetchStockLocationUseCase>(
      FetchStockLocationUseCaseImpl(commonRepository: sl<CommonRepository>()),
    )
    ..registerSingleton<FetchDefaultLocationUseCase>(
      FetchDefaultLocationUseCaseImpl(commonRepository: sl<CommonRepository>()),
    )

    ..registerSingleton<GetAllItemsApiUseCase>(
      GetAllItemsApiUseCaseImpl(commonRepository: sl<CommonRepository>()),
    )
    ..registerSingleton<GetAllVesselSpecification>(
      GetAllVesselSpecificationImpl(repository: sl<CommonRepository>()),
    )
    ..registerSingleton<GetAllPoItemsUseCase>(
      GetAllPoItemsUseCaseImpl(commonRepository: sl<CommonRepository>()),
    )
    ..registerSingleton<InsertPendingPoSplitLocationDataUseCase>(
      InsertPendingPoSplitLocationDataUseCaseImpl(
        repository: sl<CommonRepository>(),
      ),
    )
    ..registerSingleton<GetAllAdminStructureUseCase>(
      GetAllAdminStructureUseCaseImpl(repository: sl<CommonRepository>()),
    )
    ..registerFactory<DashboardBloc>(
      () => DashboardBloc(
        fetchAllPortListUseCase: sl<FetchAllPortListUseCase>(),
        itemMasterInsertUseCase: sl<ItemMasterInsertUseCase>(),
        logoutUseCase: sl<LogoutUseCase>(),
        getAllGoodsReceiptTransactionUseCase:
            sl<GetAllGoodsReceiptTransactionUseCase>(),
        getAllGrnTransactionItemUseCase: sl<GetAllGrnTransactionItemUseCase>(),
        fetchStockLocationUseCase: sl<FetchStockLocationUseCase>(),
        fetchDefaultLocationUseCase: sl<FetchDefaultLocationUseCase>(),
        getSplitLocationDataUseCase: sl<GetSplitLocationDataUseCase>(),
        getAllItemsApiUseCase: sl<GetAllItemsApiUseCase>(),
        insertStorageLocationUseCase: sl<InsertStorageLocationUseCase>(),
        getAllVesselSpecification: sl<GetAllVesselSpecification>(),
        getPurchaseOrderItemsListUseCase:
            sl<GetPurchaseOrderItemsListUseCase>(),
        fetchItemCategoryUsecase: sl<GetItemCategoryUsecase>(),
        insertItemCategoryUsecase: sl<InsertItemCategoryUsecase>(),
        fetchPurchaseOrderFromApiUsecase: sl<GetPurchaseOrderFromApiUsecase>(),
        getAllTransactionFromApiUseCase: sl<GetAllTransactionFromApiUseCase>(),
        getAllTransactionItemDetailUsecase:
            sl<GetAllTransactionItemDetailUsecase>(),
        getQualityListUseCase: sl<GetQualityListUseCase>(),
        getImdgClassUseCase: sl<GetImdgClassUseCase>(),
          insertConsumptionTransactionUseCase: sl<InsertConsumptionTransactionUseCase>(),
          stockUpdateInsertUseCase: sl<StockUpdateInsertUseCase>(),
          insertEquipmentListUseCase: sl<InsertEquipmentListUseCase>(),
          insertConsumptionLocationListUseCase: sl<InsertConsumptionLocationListUseCase>(),
          itemRobDetailsUseCase: sl<ItemRobDetailsUseCase>(),
          getAllAdminStructureUseCase: sl<GetAllAdminStructureUseCase>()
      ),
    );
}
