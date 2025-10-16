import '../../../../../core/error/failures.dart';

sealed class TransactionDetailFailures extends Failure {
  const TransactionDetailFailures({
    required super.code,
    required super.message,
  });
}

class TransactionDetailUnknownFailure extends TransactionDetailFailures {
  const TransactionDetailUnknownFailure({
    required super.code,
    required super.message,
  });
}

class TransactionDetailDbExceptionFailure extends TransactionDetailFailures {
  const TransactionDetailDbExceptionFailure({
    required super.code,
    required super.message,
  });
}

class TransactionDetailNetworkFailure extends TransactionDetailFailures {
  const TransactionDetailNetworkFailure({
    required super.code,
    required super.message,
  });
}
