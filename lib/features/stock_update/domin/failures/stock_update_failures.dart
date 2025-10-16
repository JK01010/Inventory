import '../../../../core/error/failures.dart';

sealed class StockUpdateFailures extends Failure {
  const StockUpdateFailures({required super.code, required super.message});
}

class StockUpdateServerFailure extends StockUpdateFailures {
  const StockUpdateServerFailure({
    required super.code,
    required super.message,
  });
}

class StockUpdateInsertListFailure extends StockUpdateFailures {
  const StockUpdateInsertListFailure({
    required super.code,
    required super.message,
  });
}

class StockUpdateFetchListFailure extends StockUpdateFailures {
  const StockUpdateFetchListFailure({
    required super.code,
    required super.message,
  });
}
