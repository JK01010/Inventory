import '../../../../../core/error/failures.dart';

sealed class PurchaseOrderDetailsFailures extends Failure {
  const PurchaseOrderDetailsFailures({
    required super.code,
    required super.message,
  });
}

class PurchaseOrderDetailsUnknownFailure extends PurchaseOrderDetailsFailures {
  const PurchaseOrderDetailsUnknownFailure({
    required super.code,
    required super.message,
  });
}

class PurchaseOrderDetailsDbExceptionFailure
    extends PurchaseOrderDetailsFailures {
  const PurchaseOrderDetailsDbExceptionFailure({
    required super.code,
    required super.message,
  });
}

class PurchaseOrderDetailsNetworkFailure
    extends PurchaseOrderDetailsFailures {
  const PurchaseOrderDetailsNetworkFailure({
    required super.code,
    required super.message,
  });
}
