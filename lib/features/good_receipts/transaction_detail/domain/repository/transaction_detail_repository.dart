import 'package:fpdart/fpdart.dart';

import '../../../../common_feature/domain/entities/item_entity.dart';
import '../failures/transaction_detail_failures.dart';
import '../use_cases/get_transaction_items_db_usecase.dart';

abstract interface class TransactionDetailRepository {
  Future<Either<TransactionDetailFailures, List<ItemEntity>>>
  getTransactionItemsFromDb({required GetTransactionItemsParams params});
}
