import '../../../../../core/service/db_service/table_data_manipulation/transactions_table_data_processor.dart';
import '../../../data/models/transaction_filter_model.dart';
import '../model/transaction_model.dart';

abstract interface class TransactionLocalDataSource {
  Future<void> insertTransaction({
    required List<TransactionModel> transactionModelList,
  });
  Future<List<TransactionModel>> getAllTransaction({
    TransactionFilterModel? filter,
  });
}

class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  TransactionLocalDataSourceImpl({
    required this.transactionsTableDataProcessor,
  });

  final TransactionsTableDataProcessor transactionsTableDataProcessor;
  @override
  Future<List<TransactionModel>> getAllTransaction({
    TransactionFilterModel? filter,
  }) async {
    final List<Map<String, dynamic>> transactionList =
        await transactionsTableDataProcessor.getAllTransaction(filter: filter);

    final transactionModelList =
        transactionList.map((e) {
          final Map<String, dynamic> map = Map<String, dynamic>.from(e);

          map["IsBaggingCompleted"] =
              map["IsBaggingCompleted"] == 1 ? true : false;
          map["IsFull"] = map["IsFull"] == 1 ? true : false;
          map["IsBaggingTaggingApplicable"] =
              map["IsBaggingTaggingApplicable"] == 1 ? true : false;
          map["isConfirmed"] = map["isConfirmed"] == 1 ? true : false;
          map["SyncStatus"] = map["SyncStatus"] == 1 ? true : false;
          return TransactionModel.fromJson(map);
        }).toList();

    return transactionModelList;
  }

  @override
  Future<void> insertTransaction({
    required List<TransactionModel> transactionModelList,
  }) async {
    transactionsTableDataProcessor.insertTransactionData(
      goodsReceiptTransactionModelList: transactionModelList,
    );
  }
}
