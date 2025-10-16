import '../../../../core/error/failures.dart';

sealed class ConsumptionFailures extends Failure {
  const ConsumptionFailures({required super.code, required super.message});
}

class ConsumptionServerFailure extends ConsumptionFailures {
  const ConsumptionServerFailure({
    required super.code,
    required super.message,
  });
  }

class ConsumptionGetAllTransactionListFailure extends ConsumptionFailures {
  const ConsumptionGetAllTransactionListFailure({
    required super.code,
    required super.message,
  });
  }
