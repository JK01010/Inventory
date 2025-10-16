import '../../../../../core/error/failures.dart';

sealed class PurchaseOrderItemDetailsFailures extends Failure {
  const PurchaseOrderItemDetailsFailures({
    required super.code,
    required super.message,
  });
}

class PurchaseOrderItemDetailsUnknownFailure
    extends PurchaseOrderItemDetailsFailures {
  const PurchaseOrderItemDetailsUnknownFailure({
    required super.code,
    required super.message,
  });
}

class PurchaseOrderItemDetailsDbExceptionFailure
    extends PurchaseOrderItemDetailsFailures {
  const PurchaseOrderItemDetailsDbExceptionFailure({
    required super.code,
    required super.message,
  });
}

class PurchaseOrderItemDetailsNetworkFailure
    extends PurchaseOrderItemDetailsFailures {
  const PurchaseOrderItemDetailsNetworkFailure({
    required super.code,
    required super.message,
  });
}

class PurchaseOrderItemDetailsSerialNoGenerationFailure
    extends PurchaseOrderItemDetailsFailures {
  const PurchaseOrderItemDetailsSerialNoGenerationFailure({
    required super.code,
    required super.message,
  });
}

