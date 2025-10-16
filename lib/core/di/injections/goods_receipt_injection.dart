import 'package:encrypt_shared_preferences/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../config/network_config.dart';
import '../../../features/bagging_tagging_confirmtaion/domain/usecase/get_all_bagging_item_details_usecase.dart';
import '../../../features/common_feature/data/data_source/common_local_data_source.dart';
import '../../../features/common_feature/data/data_source/common_network_data_source.dart';
import '../../../features/common_feature/domain/repositories/common_repository.dart';
import '../../../features/common_feature/domain/usecase/insert_pending_po_split_location_data_usecase.dart';
import '../../../features/common_feature/domain/usecase/insert_storage_location_usecase.dart';
import '../../../features/good_receipts/data/data_source/goods_receipts_local_data_source.dart';
import '../../../features/good_receipts/data/data_source/goods_receipts_remote_data_source.dart';
import '../../../features/good_receipts/data/repository/goods_receipts_repository_impl.dart';
import '../../../features/good_receipts/domain/repository/goods_receipts_repository.dart';
import '../../../features/good_receipts/domain/use_cases/create_new_label_list_and_update_goods_receipt_label_list_using_poid_use_case.dart';
import '../../../features/good_receipts/domain/use_cases/delete_goods_receipts_label_item_by_id_use_case.dart';
import '../../../features/good_receipts/domain/use_cases/delete_split_storage_location_item_by_id_use_case.dart';
import '../../../features/good_receipts/domain/use_cases/get_all_goods_receipt_transaction_detail_use_case.dart';
import '../../../features/good_receipts/domain/use_cases/get_all_item_list_to_create_new_label_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/get_all_packet_details_for_gr_by_po_id_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/get_goods_receipt_attachments_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/get_goods_receipt_ihm_attachments_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/get_goods_receipt_label_attachments_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/get_goods_receipt_label_detail_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/get_pending_po_split_location_data_use_case.dart';
import '../../../features/good_receipts/domain/use_cases/get_split_location_by_purchase_item_detail_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/get_storage_location_by_parent_id_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/goods_receipt_create_label_get_label_detail_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/goods_receipt_create_label_get_storage_locations_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/goods_receipt_create_label_save_label_detail_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/goods_receipt_save_packet_detail_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/goods_receipts_po_usecase/get_goods_receipt_details_by_id_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/goods_receipts_po_usecase/goods_receipt_get_all_po_line_items_data_use_case.dart';
import '../../../features/good_receipts/domain/use_cases/goods_receipts_po_usecase/item_category_config_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/goods_receipts_po_usecase/item_rob_details_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/goods_receipts_po_usecase/save_goods_receipts_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/goods_receipts_po_usecase/update_goods_receipts_po_detail_use_case.dart';
import '../../../features/good_receipts/domain/use_cases/grn_create_label_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/grn_location_mapping_use_case.dart';
import '../../../features/good_receipts/domain/use_cases/grn_location_serial_mapping_use_case.dart';
import '../../../features/good_receipts/domain/use_cases/insert_captured_selected_media_attachment_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/insert_captured_selected_media_label_attachment_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/insert_goods_receipts_attachment_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/insert_goods_receipts_detail_label_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/insert_or_update_split_storage_location_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/transaction_filter_usecase/search_transaction_grn_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/transaction_filter_usecase/search_transaction_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/transaction_usecase/filter_transaction_list_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/transaction_usecase/get_all_goods_receipt_transaction_use_case.dart';
import '../../../features/good_receipts/domain/use_cases/transaction_usecase/get_all_grn_transaction_item_use_case.dart';
import '../../../features/good_receipts/domain/use_cases/transaction_usecase/sync_transaction_list_usecase.dart';
import '../../../features/good_receipts/domain/use_cases/update_goods_receipt_detail_label_list_use_case.dart';
import '../../../features/good_receipts/domain/use_cases/update_stock_location_by_item_id_use_case.dart';
import '../../../features/good_receipts/presentation/goods_receipt_attachment_bloc/goods_receipt_attachment_bloc.dart';
import '../../../features/good_receipts/presentation/goods_receipt_detail_create_label_bloc/goods_receipt_create_label_bloc.dart';
import '../../../features/good_receipts/presentation/goods_receipt_detail_label_bloc/goods_receipt_label_bloc.dart';
import '../../../features/good_receipts/presentation/goods_receipt_label_attachment_bloc/goods_receipt_label_attachment_item_bloc.dart';
import '../../../features/good_receipts/presentation/goods_receipt_label_ihm_attachment_bloc/goods_receipt_label_ihm_attachment_bloc.dart';
import '../../../features/good_receipts/presentation/goods_receipt_packet_detail_bloc/goods_receipt_packet_detail_bloc.dart';
import '../../../features/good_receipts/presentation/goods_receipt_split_location_bloc/goods_receipt_split_location_bloc.dart';
import '../../../features/good_receipts/presentation/goods_receipt_transaction_detail_bloc/goods_receipts_transaction_detail_bloc.dart';
import '../../../features/good_receipts/presentation/goods_receipts_po_bloc/goods_receipts_po_bloc.dart';
import '../../../features/good_receipts/presentation/storage_location_bloc/storage_location_bloc.dart';
import '../../../features/good_receipts/transaction/domain/usecase/get_all_transaction_from_db_usecase.dart';
import '../../../features/good_receipts/transaction/presentation/bloc/transaction_search_bloc/transaction_search_bloc.dart';
import '../../../features/stock_update/presentation/bloc/stock_location_bloc/stock_location_bloc.dart';
import '../../service/db_service/table_data_manipulation/goods_receipt_detail_data_processor.dart';
import '../../service/db_service/table_data_manipulation/goods_receipt_detail_label_data_processor.dart';
import '../../service/db_service/table_data_manipulation/item_category_config_data_processor.dart';
import '../../service/db_service/table_data_manipulation/item_rob_details_data_processor.dart';
import '../../service/db_service/table_data_manipulation/packet_details_data_processor.dart';
import '../../service/db_service/table_data_manipulation/pending_po_split_location_table_processor.dart';
import '../../service/db_service/table_data_manipulation/purchsase_order_table_data_processor.dart';
import '../../service/db_service/table_data_manipulation/split_location_data_processor.dart';
import '../../service/db_service/table_data_manipulation/stock_location_data_processor.dart';
import '../../service/db_service/table_data_manipulation/transactions_table_data_processor.dart';
import '../../service/network/connectivity_manager.dart';
import '../../service/other_service/file_logger_service.dart';
import '../../utils/app_logger.dart';
import '../service_locator.dart';

void goodsReceiptInjection() {
  sl
    ..registerSingleton<GoodsReceiptDetailDataProcessor>(
      GoodsReceiptDetailDataProcessorImpl(db: sl<Database>()),
    )
    ..registerSingleton<GoodsReceiptDetailLabelDataProcessor>(
      GoodsReceiptDetailLabelDataProcessorImpl(db: sl<Database>()),
    )
    ///already declare in common injection
    // ..registerSingleton<StockLocationDataProcessor>(
    //   StockLocationDataProcessorImpl(db: sl<Database>()),
    // )
    ..registerSingleton<PacketDetailsDataProcessor>(
      PacketDetailsDataProcessorImpl(db: sl<Database>()),
    )
    ..registerSingleton<ItemCategoryConfigDataProcessor>(
      ItemCategoryConfigDataProcessorImpl(db: sl<Database>()),
    )
    ..registerSingleton<ItemRobDetailsDataProcessor>(
      ItemRobDetailsDataProcessorImpl(db: sl<Database>()),
    )
    ..registerSingleton<GoodsReceiptsLocalDataSource>(
      GoodsReceiptsLocalDataSourceImpl(
        pendingPoTableDataManipulation: sl<PurchaseOrderTableDataProcessor>(),
        goodsReceiptDetailDataProcessor: sl<GoodsReceiptDetailDataProcessor>(),
        transactionsTableDataProcessor: sl<TransactionsTableDataProcessor>(),
        goodsReceiptDetailLabelDataProcessor:
            sl<GoodsReceiptDetailLabelDataProcessor>(),
        stockLocationDataProcessor: sl<StockLocationDataProcessor>(),
        packetDetailsDataProcessor: sl<PacketDetailsDataProcessor>(),
        splitLocationDataProcessor: sl<SplitLocationDataProcessor>(),
        itemRobDetailsDataProcessor: sl<ItemRobDetailsDataProcessor>(),
        pendingPoSplitLocationTableProcessor:
            sl<PendingPoSplitLocationTableProcessor>(),
      ),
    )
    ..registerSingleton<GoodsReceiptsRemoteDataSource>(
      GoodsReceiptsRemoteDataSourceImpl(
        appNetworkClient: sl<AppNetworkClient>(),
        encryptedSharedPreferences: sl<EncryptedSharedPreferences>(),
        purchaseOrderTableDataProcessor: sl<PurchaseOrderTableDataProcessor>(),
        goodsReceiptDetailLabelDataProcessor:
            sl<GoodsReceiptDetailLabelDataProcessor>(),
        transactionsTableDataProcessor: sl<TransactionsTableDataProcessor>(),
        itemCategoryConfigDataProcessor: sl<ItemCategoryConfigDataProcessor>(),
      ),
    )
    ..registerLazySingleton<GoodsReceiptsRepository>(
      () => GoodsReceiptsRepositoryImpl(
        goodsReceiptsLocalDataSource: sl<GoodsReceiptsLocalDataSource>(),
        appLogger: sl<AppLogger>(),
        fileLoggerService: sl<FileLoggerService>(),
        connectivityManager: sl<ConnectivityManager>(),
        goodsReceiptsRemoteDataSource: sl<GoodsReceiptsRemoteDataSource>(),
        commonLocalDataSource: sl<CommonLocalDataSource>(),
        commonNetworkDataSource: sl<CommonNetworkDataSource>(),
      ),
    )
    ..registerSingleton<UpdateGoodsReceiptsPoDetailUseCase>(
      UpdateGoodsReceiptsPoDetailUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<GetGoodsReceiptDetailsByIdUseCase>(
      GetGoodsReceiptDetailsByIdUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<DeleteGoodsReceiptsLabelItemByIdUseCase>(
      DeleteGoodsReceiptsLabelItemByIdUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<GoodsReceiptGetAllPoLineItemsDataUseCase>(
      GoodsReceiptGetAllPoLineItemsDataUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<SaveGoodReceiptsUseCase>(
      SaveGoodReceiptsUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerFactory<GoodsReceiptsPoBloc>(
      () => GoodsReceiptsPoBloc(
        goodsReceiptGetAllPoLineItemsDataUseCase:
            sl<GoodsReceiptGetAllPoLineItemsDataUseCase>(),
        updateGoodsReceiptsPoDetailUseCase:
            sl<UpdateGoodsReceiptsPoDetailUseCase>(),
        getGoodsReceiptDetailsByIdUseCase:
            sl<GetGoodsReceiptDetailsByIdUseCase>(),

        saveGoodReceiptsUseCase: sl<SaveGoodReceiptsUseCase>(),
      ),
    )
    ..registerSingleton<InsertGoodsReceiptsAttachmentUseCase>(
      InsertGoodsReceiptsAttachmentUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<GetGoodsReceiptAttachmentsUseCase>(
      GetGoodsReceiptAttachmentsUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<InsertCapturedSelectedMediaAttachmentUseCase>(
      InsertCapturedSelectedMediaAttachmentUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<GoodsReceiptAttachmentBloc>(
      GoodsReceiptAttachmentBloc(
        insertGoodsReceiptsAttachmentUseCase:
            sl<InsertGoodsReceiptsAttachmentUseCase>(),
        getGoodsReceiptAttachmentsUseCase:
            sl<GetGoodsReceiptAttachmentsUseCase>(),
        insertCapturedSelectedMediaAttachmentUseCase:
            sl<InsertCapturedSelectedMediaAttachmentUseCase>(),
      ),
    )
    ..registerLazySingleton<GetAllGoodsReceiptTransactionUseCase>(
      () => GetAllGoodsReceiptTransactionUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerLazySingleton<SyncTransactionListUseCase>(
      () => SyncTransactionListUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerLazySingleton<FilterTransactionListUseCase>(
      () => FilterTransactionListUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerLazySingleton<GetAllGrnTransactionItemUseCase>(
      () => GetAllGrnTransactionItemUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<InsertGoodsReceiptsDetailLabelUseCase>(
      InsertGoodsReceiptsLabelDetailUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<GetGoodsReceiptLabelDetailUseCase>(
      GetGoodsReceiptLabelDetailUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<UpdateGoodsReceiptDetailLabelListUseCase>(
      UpdateGoodsReceiptDetailLabelListUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<GetAllItemListToCreateNewLabelUseCase>(
      GetAllItemListToCreateNewLabelUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<
      CreateNewLabelListAndUpdateGoodsReceiptLabelListUsingPoIdUseCase
    >(
      CreateNewLabelListAndUpdateGoodsReceiptLabelListUsingPoIdUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<GRNCreateLabelUseCase>(
      GRNCreateLabelUseCaseImpl(repository: sl<GoodsReceiptsRepository>()),
    )
    ..registerSingleton<GoodsReceiptLabelBloc>(
      GoodsReceiptLabelBloc(
        insertGoodsReceiptsDetailLabelUseCase:
            sl<InsertGoodsReceiptsDetailLabelUseCase>(),
        getGoodsReceiptLabelDetailUseCase:
            sl<GetGoodsReceiptLabelDetailUseCase>(),
        updateGoodsReceiptDetailLabelListUseCase:
            sl<UpdateGoodsReceiptDetailLabelListUseCase>(),
        deleteGoodsReceiptsLabelItemByIdUseCase:
            sl<DeleteGoodsReceiptsLabelItemByIdUseCase>(),
        getAllItemListToCreateNewLabelUseCase:
            sl<GetAllItemListToCreateNewLabelUseCase>(),
        createNewLabelListAndUpdateGoodsReceiptLabelListUsingPoIdUseCase:
            sl<
              CreateNewLabelListAndUpdateGoodsReceiptLabelListUsingPoIdUseCase
            >(),
        grnCreateLabelUseCase: sl<GRNCreateLabelUseCase>(),
      ),
    )
    ..registerSingleton<GoodsReceiptCreateLabelGetLabelDetailUseCase>(
      GoodsReceiptCreateLabelGetLabelDetailUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<GoodsReceiptCreateLabelSaveLabelDetailUseCase>(
      GoodsReceiptCreateLabelSaveLabelDetailUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<GoodsReceiptCreateLabelGetStorageLocationsUseCase>(
      GoodsReceiptCreateLabelGetStorageLocationsUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<FetchGRNLocationMappingUseCase>(
      FetchGRNLocationMappingUseCaseImpl(
        repository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<FetchGRNLocationSerialMappingUseCase>(
      FetchGRNLocationSerialMappingUseCaseImpl(
        repository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<ItemRobDetailsUseCase>(
      ItemRobDetailsUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<GoodsReceiptCreateLabelBloc>(
      GoodsReceiptCreateLabelBloc(
        goodsReceiptCreateLabelGetLabelDetailUseCase:
            sl<GoodsReceiptCreateLabelGetLabelDetailUseCase>(),
        goodsReceiptCreateLabelSaveLabelDetailUseCase:
            sl<GoodsReceiptCreateLabelSaveLabelDetailUseCase>(),
        goodsReceiptCreateLabelGetStorageLocationsUseCase:
            sl<GoodsReceiptCreateLabelGetStorageLocationsUseCase>(),
        fetchGRNLocationMappingUseCase: sl<FetchGRNLocationMappingUseCase>(),
        fetchGRNLocationSerialMappingUseCase:
            sl<FetchGRNLocationSerialMappingUseCase>(),

        itemRobDetailsUseCase: sl<ItemRobDetailsUseCase>(),
      ),
    )
    ..registerSingleton<GetGoodsReceiptLabelAttachmentsUseCase>(
      GetGoodsReceiptLabelAttachmentsUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<InsertCapturedSelectedMediaLabelAttachmentUseCase>(
      InsertCapturedSelectedMediaLabelAttachmentUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerFactory<GoodsReceiptLabelAttachmentItemBloc>(
      () => GoodsReceiptLabelAttachmentItemBloc(
        getGoodsReceiptLabelAttachmentsUseCase:
            sl<GetGoodsReceiptLabelAttachmentsUseCase>(),
        insertCapturedSelectedMediaLabelAttachmentUseCase:
            sl<InsertCapturedSelectedMediaLabelAttachmentUseCase>(),
      ),
    )
    ..registerSingleton<GetGoodsReceiptIhmAttachmentsUseCase>(
      GetGoodsReceiptIhmAttachmentsUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerFactory<GoodsReceiptLabelIhmAttachmentBloc>(
      () => GoodsReceiptLabelIhmAttachmentBloc(
        getGoodsReceiptIhmAttachmentsUseCase:
            sl<GetGoodsReceiptIhmAttachmentsUseCase>(),
      ),
    )
    ..registerSingleton<GetAllGoodsReceiptTransactionDetailUseCase>(
      GetAllGoodsReceiptTransactionDetailUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerFactory<GoodsReceiptsTransactionDetailBloc>(
      () => GoodsReceiptsTransactionDetailBloc(
        getAllGoodsReceiptTransactionDetailUseCase:
            sl<GetAllGoodsReceiptTransactionDetailUseCase>(),
      ),
    )
    ..registerSingleton<UpdateStockLocationByItemIdUseCase>(
      UpdateStockLocationByItemIdUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerFactory<StockLocationBloc>(
      () => StockLocationBloc(
        updateStockLocationByItemIdUseCase:
            sl<UpdateStockLocationByItemIdUseCase>(),
      ),
    )
    ..registerSingleton<InsertStorageLocationUseCase>(
      InsertStorageLocationUseCaseImpl(repository: sl<CommonRepository>()),
    )
    ..registerSingleton<GetStorageLocationByParentIdUseCase>(
      GetStorageLocationByParentIdUseCaseImpl(
        commonRepository: sl<CommonRepository>(),
      ),
    )
    ..registerFactory<StorageLocationBloc>(
      () => StorageLocationBloc(
        insertStorageLocationUseCase: sl<InsertStorageLocationUseCase>(),
        getStorageLocationByParentIdUseCase:
            sl<GetStorageLocationByParentIdUseCase>(),
      ),
    )
    ..registerSingleton<GetSplitLocationByPurchaseItemDetailUseCase>(
      GetSplitLocationByPurchaseItemDetailUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<InsertOrUpdateSplitStorageLocationUseCase>(
      InsertOrUpdateSplitStorageLocationUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<DeleteSplitStorageLocationItemByIdUseCase>(
      DeleteSplitStorageLocationItemByIdUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<GetPendingPoSplitLocationDataUseCase>(
      GetPendingPoSplitLocationDataUseCaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<GetItemSplitLocationDataUseCase>(
      GetItemSplitLocationDataUseCaseImpl(
        commonRepository: sl<CommonRepository>(),
      ),
    )
    ..registerFactory<GoodsReceiptSplitLocationBloc>(
      () => GoodsReceiptSplitLocationBloc(
        getSplitLocationByPurchaseItemDetailUseCase:
            sl<GetSplitLocationByPurchaseItemDetailUseCase>(),
        insertOrUpdateSplitStorageLocationUseCase:
            sl<InsertOrUpdateSplitStorageLocationUseCase>(),
        deleteSplitStorageLocationItemByIdUseCase:
            DeleteSplitStorageLocationItemByIdUseCaseImpl(
              goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
            ),
        insertPendingPoSplitLocationDataUseCase:
            sl<InsertPendingPoSplitLocationDataUseCase>(),
        getPendingPoSplitLocationDataUseCase:
            sl<GetPendingPoSplitLocationDataUseCase>(),
        getItemSplitLocationDataUseCase: sl<GetItemSplitLocationDataUseCase>(),
      ),
    )
    ..registerSingleton<GetAllPacketDetailsForGrByPoIdUseCase>(
      GetAllPacketDetailsForGrByPoIdUseCaseImpl(
        repository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<GoodsReceiptSavePacketDetailUseCase>(
      GoodsReceiptSavePacketDetailUseCaseImpl(
        repository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerFactory<GoodsReceiptPacketDetailBloc>(
      () => GoodsReceiptPacketDetailBloc(
        getAllPacketDetailsForGrByPoIdUseCase:
            sl<GetAllPacketDetailsForGrByPoIdUseCase>(),
        goodsReceiptSavePacketDetailUseCase:
            sl<GoodsReceiptSavePacketDetailUseCase>(),
      ),
    )
    ..registerSingleton<SearchTransactionGrnUsecase>(
      SearchTransactionGrnUsecaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerSingleton<SearchTransactionUsecase>(
      SearchTransactionUsecaseImpl(
        goodsReceiptsRepository: sl<GoodsReceiptsRepository>(),
      ),
    )
    ..registerFactory<TransactionSearchBloc>(
      () => TransactionSearchBloc(
        getAllTransactionFromDbUsecase: sl<GetAllTransactionFromDbUsecase>(),
      ),
    )
    ..registerSingleton<GetItemCategoryConfigUseCase>(
      GetItemCategoryConfigUseCaseImpl(
        repository: sl<GoodsReceiptsRepository>(),
      ),
    );

  //GoodsReceiptSavePacketDetailUseCase
}
