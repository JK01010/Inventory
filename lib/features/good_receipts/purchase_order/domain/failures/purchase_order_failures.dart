import '../../../../../core/error/failures.dart';

sealed class PurchaseOrderFailures extends Failure {
  const PurchaseOrderFailures({required super.code, required super.message});
}

class PurchaseOrderServerFailure extends PurchaseOrderFailures {
  const PurchaseOrderServerFailure({
    required super.code,
    required super.message,
  });
}
