import 'package:fpdart/fpdart.dart';

import '../../../../common_feature/domain/failures/common_failures.dart';
import '../repository/transaction_item_detail_repository.dart';

abstract interface class GetSplitLocationDataUseCase {
  Future<Either<CommonFailures, Unit>> call();
}

class GetSplitLocationDataUseCaseImpl implements GetSplitLocationDataUseCase {
  GetSplitLocationDataUseCaseImpl({required this.transactionItemDetailRepository});

  final TransactionItemDetailRepository transactionItemDetailRepository;

  @override
  Future<Either<CommonFailures, Unit>> call() {
    return transactionItemDetailRepository.getSplitLocationData();
  }
}
