import '../../../../../core/service/db_service/table_data_manipulation/split_location_data_processor.dart';
import '../../../../../core/service/db_service/table_data_manipulation/transaction_dt_table_data_processor.dart';
import '../models/split_location_model.dart';
import '../models/transaction_item_detail_model.dart';

abstract interface class TransactionItemDetailLocalDataSource {
  Future<void> insertTransactionItemDetailData({
    required List<TransactionItemDetailsModel> transactionItemDetailModelList,
  });

  Future<List<TransactionItemDetailsModel>> getAllTransactionItemDetailData();

  Future<void> insertSplitLocationData({
    required List<SplitLocationData> splitLocationData,
  });

  Future<List<SplitLocationData>> getSplitStorageLocationForTransactionItem({
    required int grnId,
    required int grnDtId,
  });
}

class TransactionItemDetailLocalDataSourceImpl
    implements TransactionItemDetailLocalDataSource {
  TransactionItemDetailLocalDataSourceImpl({
    required this.transactionDtTableDataProcessor,
    required this.splitLocationDataProcessor,
  });

  final TransactionItemsTableProcessor transactionDtTableDataProcessor;
  final SplitLocationDataProcessor splitLocationDataProcessor;

  @override
  Future<void> insertTransactionItemDetailData({
    required List<TransactionItemDetailsModel> transactionItemDetailModelList,
  }) async {
    transactionDtTableDataProcessor.insertTransactionDtData(
      transactionDtList: transactionItemDetailModelList,
    );
  }

  @override
  Future<List<TransactionItemDetailsModel>>
  getAllTransactionItemDetailData() async {
    final transactionItemDetailData =
        await transactionDtTableDataProcessor.getAllTransactionItemDetailData();

    final List<TransactionItemDetailsModel> transactionItemDetailModelList =
        transactionItemDetailData.map((e) {
          final Map<String, dynamic> map = Map<String, dynamic>.from(e);
          map["IsMD"] = map["IsMD"] == 1 ? true : false;
          map["IsSDOC"] = map["IsSDOC"] == 1 ? true : false;
          map["ZeroDeclaration"] = map["ZeroDeclaration"] == 1 ? true : false;
          map["isAntiPiracy"] = map["isAntiPiracy"] == 1 ? true : false;
          map["isPyroTechnics"] = map["isPyroTechnics"] == 1 ? true : false;
          map["IsExportControl"] = map["IsExportControl"] == 1 ? true : false;
          map["IsIHM"] = map["IsIHM"] == 1 ? true : false;
          map["IsCritical"] = map["IsCritical"] == 1 ? true : false;
          map["IsIMDG"] = map["IsIMDG"] == 1 ? true : false;
          map["IsBagTagItem"] = map["IsBagTagItem"] == 1 ? true : false;
          return TransactionItemDetailsModel.fromJson(map);
        }).toList();

    return transactionItemDetailModelList;
  }

  @override
  Future<void> insertSplitLocationData({
    required List<SplitLocationData> splitLocationData,
  }) async {
    await splitLocationDataProcessor.clearSplitLocationTable();
    return splitLocationDataProcessor.insertSplitLocationItems(
      splitLocationData: splitLocationData,
    );
  }

  @override
  Future<List<SplitLocationData>> getSplitStorageLocationForTransactionItem({
    required int grnId,
    required int grnDtId,
  }) async {
    final result = await splitLocationDataProcessor
        .getSplitStorageLocationForTransactionItem(
          grnId: grnId,
          grnDtId: grnDtId,
        );
    final List<SplitLocationData> splitLocationDataList =
        result.map(SplitLocationData.fromJson).toList();
    return splitLocationDataList;
  }
}
