import 'package:sqflite/sqflite.dart';

import '../../../config/network_config.dart';
import '../../../features/common_feature/domain/usecase/fetch_all_port_list_db_usecase.dart';
import '../../../features/common_feature/domain/usecase/fetch_item_category_usecase.dart';
import '../../../features/good_receipts/purchase_order/data/data_source/purchase_order_local_data_source.dart';
import '../../../features/good_receipts/purchase_order/data/data_source/purchase_order_network_data_source.dart';
import '../../../features/good_receipts/purchase_order/data/repository/purchase_order_repository_impl.dart';
import '../../../features/good_receipts/purchase_order/domain/repository/purchase_order_repository.dart';
import '../../../features/good_receipts/purchase_order/domain/usecase/get_purchase_order_from_api_usecase.dart';
import '../../../features/good_receipts/purchase_order/domain/usecase/get_purchase_order_from_db_usecase.dart';
import '../../../features/good_receipts/purchase_order/presentation/bloc/purchase_order_bloc/purchase_order_bloc.dart';

import '../../../features/good_receipts/purchase_order/presentation/bloc/purchase_order_filter_bloc/purchase_order_filter_bloc.dart';
import '../../../features/good_receipts/purchase_order/presentation/bloc/purchase_order_search_bloc/purchase_order_search_bloc.dart';
import '../../service/db_service/table_data_manipulation/purchsase_order_table_data_processor.dart';
import '../service_locator.dart';

void purchaseOrderInjection() {
  sl
    // Data sources
    ..registerSingleton<PurchaseOrderTableDataProcessor>(
      PurchaseOrderTableDataProcessorImpl(db: sl<Database>()),
    )
    // Data sources
    ..registerSingleton<PurchaseOrderLocalDataSource>(
      PurchaseOrderLocalDataSourceImpl(
        purchaseOrderTableDataProcessor: sl<PurchaseOrderTableDataProcessor>(),
      ),
    )
    ..registerSingleton<PurchaseOrderNetworkDataSource>(
      PurchaseOrderNetworkDataSourceImpl(
        appNetworkClient: sl<AppNetworkClient>(),
      ),
    )
    // Repository
    ..registerSingleton<PurchaseOrderRepository>(
      PurchaseOrderRepositoryImpl(
        purchaseOrderLocalDataSource: sl<PurchaseOrderLocalDataSource>(),
        purchaseOrderNetworkDataSource: sl<PurchaseOrderNetworkDataSource>(),
      ),
    )
    // Use cases
    ..registerSingleton<GetPurchaseOrderFromApiUsecase>(
      GetPurchaseOrderFromApiUsecaseImpl(
        purchaseOrderRepository: sl<PurchaseOrderRepository>(),
      ),
    )
    ..registerSingleton<GetPurchaseOrderFromDbUsecase>(
      GetPurchaseOrderFromDbUsecaseImpl(
        purchaseOrderRepository: sl<PurchaseOrderRepository>(),
      ),
    )
    // Bloc
    ..registerFactory<PurchaseOrderBloc>(
      () => PurchaseOrderBloc(
        fetchPurchaseOrderFromDbUsecase: sl<GetPurchaseOrderFromDbUsecase>(),
      ),
    )
    ..registerFactory<PurchaseOrderSearchBloc>(
      () => PurchaseOrderSearchBloc(
        fetchPurchaseOrderFromDbUsecase: sl<GetPurchaseOrderFromDbUsecase>(),
      ),
    )
    ..registerFactory<PurchaseOrderFilterBloc>(
      () => PurchaseOrderFilterBloc(
        getPurchaseOrderFromDbUsecase: sl<GetPurchaseOrderFromDbUsecase>(),
        getItemCategoryUsecase: sl<GetItemCategoryUsecase>(),
        getAllPortListFromDbUseCase: sl<GetAllPortListFromDbUseCase>(),
      ),
    );
}
