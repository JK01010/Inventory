import 'package:sqflite/sqflite.dart';

import '../../../features/bagging_tagging_confirmtaion/data/data_source/bagging_tagging_local_data_source.dart';
import '../../../features/bagging_tagging_confirmtaion/data/repository_impl/bagging_tagging_repository_impl.dart';
import '../../../features/bagging_tagging_confirmtaion/domain/repository/bagging_tagging_repository.dart';
import '../../../features/bagging_tagging_confirmtaion/domain/usecase/bagging_confirmation_serach_usecase.dart';
import '../../../features/bagging_tagging_confirmtaion/domain/usecase/bagging_pending_serach_usecase.dart';
import '../../../features/bagging_tagging_confirmtaion/domain/usecase/fetch_all_item_id_on_rfid_scan_use_case.dart';
import '../../../features/bagging_tagging_confirmtaion/domain/usecase/fetch_all_location_on_rfid_scan_usecase.dart';
import '../../../features/bagging_tagging_confirmtaion/domain/usecase/fetch_confirmation_list_usecase.dart';
import '../../../features/bagging_tagging_confirmtaion/domain/usecase/fetch_rfid_listing_view_list_usecase.dart';
import '../../../features/bagging_tagging_confirmtaion/domain/usecase/fetching_confirmation_storage_location_usecase.dart';
import '../../../features/bagging_tagging_confirmtaion/domain/usecase/get_all_bagging_item_details_usecase.dart';
import '../../../features/bagging_tagging_confirmtaion/domain/usecase/get_all_bagging_purchase_list_usecase.dart';
import '../../../features/bagging_tagging_confirmtaion/domain/usecase/get_bagging_confirmation_list_usecase.dart';
import '../../../features/bagging_tagging_confirmtaion/domain/usecase/get_pending_list_usecase.dart';
import '../../../features/bagging_tagging_confirmtaion/domain/usecase/insert_bagging_confirmation_list_usecase.dart';
import '../../../features/bagging_tagging_confirmtaion/domain/usecase/insert_bagging_purchase_list_usecase.dart';
import '../../../features/bagging_tagging_confirmtaion/domain/usecase/insert_bagging_tagging_item_details_usecase.dart';
import '../../../features/bagging_tagging_confirmtaion/domain/usecase/insert_pendin_list_usecase.dart';
import '../../../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_confirmation_list/bagging_confirmation_list_bloc.dart';
import '../../../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_packet_list/bagging_packet_list_bloc.dart';
import '../../../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_confirmation_bloc/bagging_tagging_confirmation_bloc.dart';
import '../../../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_confirmation_search_bloc/bagging_confirmation_search_bloc.dart';
import '../../../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_item_details_bloc/bagging_item_details_bloc.dart';
import '../../../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_listing/bagging_tagging_list_bloc.dart';
import '../../../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_pending_search_bloc/bagging_pending_search_bloc.dart';
import '../../../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_purchase_list/bagging_tagging_purchase_list_bloc.dart';
import '../../../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_purchase_pending_bloc/bagging_tagging_purchase_pending_bloc.dart';
import '../../../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_purchase_pending_details_bloc/bagging_tagging_purchase_pending_details_bloc.dart';
import '../../../features/bagging_tagging_confirmtaion/presentation/bloc/bagging_tagging_split_location_bloc/bagging_tagging_split_location_bloc.dart';
import '../../../features/good_receipts/domain/repository/goods_receipts_repository.dart';
import '../../../features/good_receipts/domain/use_cases/delete_split_storage_location_item_by_id_use_case.dart';
import '../../../features/good_receipts/domain/use_cases/get_all_goods_receipt_transaction_detail_use_case.dart';
import '../../../features/good_receipts/domain/use_cases/get_packet_details_by_po_id_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/get_split_location_by_purchase_item_detail_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/goods_receipts_po_usecase/save_bagging_and_tagging_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/insert_or_update_split_storage_location_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/transaction_usecase/filter_transaction_list_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/transaction_usecase/get_all_goods_receipt_transaction_use_case.dart';
import '../../../features/good_receipts/domain/use_cases/transaction_usecase/get_all_grn_transaction_item_use_case.dart';
import '../../../features/good_receipts/domain/use_cases/transaction_usecase/sync_transaction_list_usecase.dart';
import '../../service/db_service/table_data_manipulation/bagging_confirmation_list_datasource.dart';
import '../../service/db_service/table_data_manipulation/bagging_tagging_pending_datasource.dart';
import '../../service/db_service/bagging_items_details_datasource.dart';
import '../../service/other_service/file_logger_service.dart';
import '../../utils/app_logger.dart';
import '../service_locator.dart';

void baggingTaggingInjection() {
  sl
    ..registerSingleton<BaggingItemDetailsDataSource>(
      BaggingItemDetailsDataSourceImpl(db: sl<Database>()),
    )
    // === Data Source ===
    ..registerSingleton<BaggingTaggingPendingDatasource>(
      BaggingTaggingPendingDatasourceImpl(db: sl<Database>()),
    )
    ..registerSingleton<BaggingConfirmationListDatasource>(
      BaggingConfirmationListDatasourceImpl(db: sl<Database>()),
    )
    ..registerSingleton<BaggingTaggingLocalDataSource>(
      BaggingTaggingLocalDataSourceImpl(
        baggingItemDetailsDataSource: sl<BaggingItemDetailsDataSource>(),

        baggingTaggingPendingDatasource: sl<BaggingTaggingPendingDatasource>(),
        baggingConfirmationListDatasource:
            sl<BaggingConfirmationListDatasource>(),
      ),
    )
    // === Repository ===
    // BaggingTaggingRepository
    ..registerSingleton<BaggingTaggingRepository>(
      BaggingTaggingRepositoryImpl(
        appLogger: sl<AppLogger>(),
        fileLoggerService: sl<FileLoggerService>(),
        baggingTaggingLocalDataSource: sl<BaggingTaggingLocalDataSource>(),
      ),
    )
    // === Use Cases ===
    ..registerSingleton<InsertBaggingTaggingItemDetailsUsecase>(
      InsertBaggingTaggingItemDetailsUsecaseImpl(
        baggingTaggingRepository: sl<BaggingTaggingRepository>(),
      ),
    )
    ..registerSingleton<GetPacketDetailsByPoIdUseCase>(
      GetPacketDetailsByPoIdUseCaseImpl(
        repository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<GetBaggingTaggingPendingListUseCase>(
      GetBaggingTaggingPendingListUseCaseImpl(
        repository: sl<BaggingTaggingRepository>(),
      ),
    )
    ..registerSingleton<InsertBaggingTaggingPendingListUseCase>(
      InsertBaggingTaggingPendingListUseCaseImpl(
        repository: sl<BaggingTaggingRepository>(),
      ),
    )
    ..registerSingleton<InsertBaggingConfirmationListUsecase>(
      InsertBaggingConfirmationListUsecaseImpl(
        repository: sl<BaggingTaggingRepository>(),
      ),
    )
    ..registerSingleton<GetAllBaggingConfirmationListUsecase>(
      GetAllBaggingConfirmationListUsecaseImpl(
        baggingTaggingRepository: sl<BaggingTaggingRepository>(),
      ),
    )
    ..registerSingleton<InsertBaggingPurchaseListUsecase>(
      InsertBaggingPurchaseListUsecaseImpl(
        repository: sl<BaggingTaggingRepository>(),
      ),
    )
    ..registerSingleton<GetAllBaggingPurchaseListUsecase>(
      GetAllBaggingPurchaseListUsecaseImpl(
        commonRepository: sl<BaggingTaggingRepository>(),
      ),
    )
    ..registerSingleton<FetchingConfirmationStorageLocationUsecase>(
      FetchingConfirmationStorageLocationUsecaseImpl(
        baggingTaggingRepository: sl<BaggingTaggingRepository>(),
      ),
    )
    ..registerSingleton<FetchAllLocationOnRfidScanUseCase>(
      FetchAllLocationOnRfidScanUseCaseImpl(
        baggingTaggingRepository: sl<BaggingTaggingRepository>(),
      ),
    )
    ..registerSingleton<FetchRfidListingViewListUsecase>(
      FetchRfidListingViewListUsecaseImpl(
        baggingTaggingRepository: sl<BaggingTaggingRepository>(),
      ),
    )
    ..registerSingleton<BaggingPendingSearchUsecase>(
      BaggingPendingSerachUsecaseImpl(
        baggingTaggingRepository: sl<BaggingTaggingRepository>(),
      ),
    )
    ..registerSingleton<BaggingConfirmationSearchUsecase>(
      BaggingConfirmationSerachUsecaseImpl(
        baggingTaggingRepository: sl<BaggingTaggingRepository>(),
      ),
    )
    ..registerSingleton<FetchConfirmationListUseCase>(
      FetchConfirmationListUseCaseImpl(
        baggingTaggingRepository: sl<BaggingTaggingRepository>(),
      ),
    )
    ..registerSingleton<FetchAllItemIdOnRfidScanUseCase>(
      FetchAllItemIdOnRfidScanUseCaseImpl(
        baggingTaggingRepository: sl<BaggingTaggingRepository>(),
      ),
    )
    // === Bloc ===
    ..registerSingleton<BaggingItemDetailsBloc>(
      BaggingItemDetailsBloc(
        insertBaggingTaggingItemDetailsUsecase:
            sl<InsertBaggingTaggingItemDetailsUsecase>(),
        getItemSplitLocationDataUseCase: sl<GetItemSplitLocationDataUseCase>(),
      ),
    )
    ..registerSingleton<BaggingTaggingListBloc>(
      BaggingTaggingListBloc(
        getUseCase: sl<GetBaggingTaggingPendingListUseCase>(),
        insertUseCase: sl<InsertBaggingTaggingPendingListUseCase>(),
      ),
    )
    ..registerSingleton<BaggingConfirmationListBloc>(
      BaggingConfirmationListBloc(
        insertBaggingConfirmationListUsecase:
            sl<InsertBaggingConfirmationListUsecase>(),
        getAllBaggingConfirmationListUsecase:
            sl<GetAllBaggingConfirmationListUsecase>(),
        fetchingConfirmationStorageLocationUsecase:
            sl<FetchingConfirmationStorageLocationUsecase>(),
        fetchAllLocationOnRfidScanUseCase:
            sl<FetchAllLocationOnRfidScanUseCase>(),
        fetchConfirmationListUseCase: sl<FetchConfirmationListUseCase>(),
        fetchAllItemIdOnRfidScanUseCase: sl<FetchAllItemIdOnRfidScanUseCase>(),
      ),
    )
    ..registerFactory<BaggingTaggingPurchaseListBloc>(
      () => BaggingTaggingPurchaseListBloc(
        insertPurchaseUseCase: sl<InsertBaggingPurchaseListUsecase>(),
        getPurchaseUseCase: sl<GetAllBaggingPurchaseListUsecase>(),
        fetchRfidViewUseCase: sl<FetchRfidListingViewListUsecase>(),
      ),
    )
    ..registerFactory<BaggingPacketListBloc>(
      () => BaggingPacketListBloc(
        fetchPacketDetailsByPoIdUseCase: sl<GetPacketDetailsByPoIdUseCase>(),
      ),
    )
    ..registerFactory<BaggingTaggingSplitLocationBloc>(
      () => BaggingTaggingSplitLocationBloc(
        insertOrUpdateSplitStorageLocationUseCase:
            sl<InsertOrUpdateSplitStorageLocationUseCase>(),
        getSplitLocationByPurchaseItemDetailUseCase:
            sl<GetSplitLocationByPurchaseItemDetailUseCase>(),
        deleteSplitStorageLocationItemByIdUseCase:
            sl<DeleteSplitStorageLocationItemByIdUseCase>(),
      ),
    )
    ..registerFactory<BaggingPendingSearchBloc>(
      () => BaggingPendingSearchBloc(
        baggingPendingPoSearchUseCase: sl<BaggingPendingSearchUsecase>(),
      ),
    )
    ..registerFactory<BaggingConfirmationSearchBloc>(
      () => BaggingConfirmationSearchBloc(
        baggingConfirmationPoSearchUseCase:
            sl<BaggingConfirmationSearchUsecase>(),
      ),
    )
    ..registerFactory<BaggingTaggingPurchasePendingBloc>(
      () => BaggingTaggingPurchasePendingBloc(
        filterTransactionListUseCase: sl<FilterTransactionListUseCase>(),
        getAllGoodsReceiptTransactionUseCase:
            sl<GetAllGoodsReceiptTransactionUseCase>(),
        getAllGrnTransactionItemUseCase: sl<GetAllGrnTransactionItemUseCase>(),
        syncTransactionListUseCase: sl<SyncTransactionListUseCase>(),
      ),
    )
    ..registerSingleton<SaveBaggingAndTaggingUsecase>(
      SaveBaggingAndTaggingUsecaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerFactory<BaggingTaggingPurchasePendingDetailsBloc>(
      () => BaggingTaggingPurchasePendingDetailsBloc(
        getAllGoodsReceiptTransactionDetailUseCase:
            sl<GetAllGoodsReceiptTransactionDetailUseCase>(),

        saveBaggingAndTaggingUsecase: sl<SaveBaggingAndTaggingUsecase>(),
      ),
    )
    ..registerFactory<BaggingTaggingConfirmationBloc>(
      () => BaggingTaggingConfirmationBloc(
        filterTransactionListUseCase: sl<FilterTransactionListUseCase>(),
        getAllGoodsReceiptTransactionUseCase:
            sl<GetAllGoodsReceiptTransactionUseCase>(),
        getAllGrnTransactionItemUseCase: sl<GetAllGrnTransactionItemUseCase>(),
        syncTransactionListUseCase: sl<SyncTransactionListUseCase>(),
      ),
    );
}
