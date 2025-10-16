import 'package:fpdart/fpdart.dart';
import '../../../domain/entities/split_location_entity.dart';
import '../failures/transaction_item_detail_failure.dart';
import '../repository/transaction_item_detail_repository.dart';

abstract interface class GetSplitLocationDatForTransactionItemUseCase {
  Future<Either<TransactionItemDetailFailure, List<SplitLocationEntity>>> call({
    required GetSplitLocationDataTransactionItemParams
    getSplitLocationDataTransactionItemParams,
  });
}

class GetSplitLocationDatForTransactionItemUseCaseImpl
    implements GetSplitLocationDatForTransactionItemUseCase {
  GetSplitLocationDatForTransactionItemUseCaseImpl({
    required this.transactionItemDetailRepository,
  });

  final TransactionItemDetailRepository transactionItemDetailRepository;

  @override
  Future<Either<TransactionItemDetailFailure, List<SplitLocationEntity>>> call({
    required GetSplitLocationDataTransactionItemParams
    getSplitLocationDataTransactionItemParams,
  }) async {
    return transactionItemDetailRepository
        .getSplitLocationDataForTransactionItem(
          getSplitLocationDataTransactionItemParams:
              getSplitLocationDataTransactionItemParams,
        );
  }
}

class GetSplitLocationDataTransactionItemParams {
  GetSplitLocationDataTransactionItemParams({
    required this.grnId,
    required this.grnDtId,
  });

  final int grnId;
  final int grnDtId;
}
