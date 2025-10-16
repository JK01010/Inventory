import '../../../../../core/service/db_service/table_data_manipulation/purchase_order_attachment_data_processor.dart';
import '../../../../../core/service/db_service/table_data_manipulation/purchase_order_items_table_processor.dart';
import '../../../../../core/service/db_service/table_data_manipulation/transaction_dt_table_data_processor.dart';
import '../../../purchase_order/data/model/purchase_order_attachment_model.dart';
import '../../../transaction_item_detail/data/models/transaction_item_detail_model.dart';

abstract interface class TransactionDetailLocalDataSource {
  Future<List<TransactionItemDetailsModel>> getTransactionItems({
    required int grnId,
  });
}

class TransactionDetailLocalDataSourceImpl
    implements TransactionDetailLocalDataSource {
  TransactionDetailLocalDataSourceImpl({
    required this.transactionItemsTableProcessor,
  });

  final TransactionItemsTableProcessor transactionItemsTableProcessor;

  @override
  Future<List<TransactionItemDetailsModel>> getTransactionItems({
    required int grnId,
  }) async {
    final result = await transactionItemsTableProcessor
        .getAllTransactionItemsByGrn(grnId: grnId);
    return result.map(TransactionItemDetailsModel.fromJson).toList();
  }
}
