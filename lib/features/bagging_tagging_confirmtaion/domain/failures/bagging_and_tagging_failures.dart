import '../../../../core/error/failures.dart';

sealed class BaggingAndTaggingFailures extends Failure {
  const BaggingAndTaggingFailures({
    required super.code,
    required super.message,
  });
}

class BaggingAndTaggingServerFailure extends BaggingAndTaggingFailures {
  const BaggingAndTaggingServerFailure({
    required super.code,
    required super.message,
  });
}
class BaggingTaggingInsertDetailsExceptionFailure extends BaggingAndTaggingFailures {
  const BaggingTaggingInsertDetailsExceptionFailure({
    required super.code,
    required super.message,
  });
}
class BaggingTaggingGetAllItemDetailsFailure extends BaggingAndTaggingFailures {
  const BaggingTaggingGetAllItemDetailsFailure({
    required super.code,
    required super.message,
  });
}
class BaggingTaggingGetAllDbExceptionFailure extends BaggingAndTaggingFailures {
  const BaggingTaggingGetAllDbExceptionFailure({
    required super.code,
    required super.message,
  });
}

class BaggingAndTaggingUnknownFailure extends BaggingAndTaggingFailures {
  const BaggingAndTaggingUnknownFailure({
    required super.code,
    required super.message,
  });
}
class BaggingTaggingGetAllPurchaseItemDetailsFailure extends BaggingAndTaggingFailures {
  const BaggingTaggingGetAllPurchaseItemDetailsFailure({
    required super.code,
    required super.message,
  });
}
class BaggingTaggingGetAllPurchaseItemListFailure extends BaggingAndTaggingFailures {
  const BaggingTaggingGetAllPurchaseItemListFailure({
    required super.code,
    required super.message,
  });
}
class BaggingTaggingSyncStatusUpdateFailure extends BaggingAndTaggingFailures {
  const BaggingTaggingSyncStatusUpdateFailure({
    required super.code,
    required super.message,
  });
}
class BaggingTaggingInsertFailure extends BaggingAndTaggingFailures {
  const BaggingTaggingInsertFailure({
    required super.code,
    required super.message,
  });
}
class BaggingTaggingInsertConfirmationListFailure extends BaggingAndTaggingFailures {
  const BaggingTaggingInsertConfirmationListFailure({
    required super.code,
    required super.message,
  });
}
class BaggingTaggingGetConfirmationListFailure extends BaggingAndTaggingFailures {
  const BaggingTaggingGetConfirmationListFailure({
    required super.code,
    required super.message,
  });
}
class BaggingTaggingPoSearchExceptionFailure extends BaggingAndTaggingFailures {
  const BaggingTaggingPoSearchExceptionFailure({
    required super.code,
    required super.message,
  });
}
class BaggingTaggingSaveConfirmationFailure extends BaggingAndTaggingFailures {
  const BaggingTaggingSaveConfirmationFailure({
    required super.code,
    required super.message,
  });
}