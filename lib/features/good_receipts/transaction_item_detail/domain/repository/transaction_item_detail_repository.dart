import 'package:fpdart/fpdart.dart';

import '../../../../common_feature/domain/failures/common_failures.dart';
import '../../../domain/entities/split_location_entity.dart';
import '../entity/transaction_item_detail_entity.dart';
import '../failures/transaction_item_detail_failure.dart';
import '../usecase/get_split_location_data_transaction_item_usecase.dart';

abstract interface class TransactionItemDetailRepository {
  Future<Either<TransactionItemDetailFailure, Unit>>
  getAllTransactionItemDetailFromApi();

  Future<Either<CommonFailures, Unit>> getSplitLocationData();

  Future<Either<TransactionItemDetailFailure, List<SplitLocationEntity>>>
  getSplitLocationDataForTransactionItem({
    required GetSplitLocationDataTransactionItemParams
    getSplitLocationDataTransactionItemParams,
  });
}
