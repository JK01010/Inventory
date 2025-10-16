sealed class BaggingTaggingExceptions implements Exception{}

class BaggingTaggingServerException extends BaggingTaggingExceptions {}

class BaggingTaggingInsertDetailsException extends BaggingTaggingExceptions {}

class BaggingInsertPurchaseDetailsException extends BaggingTaggingExceptions {}

class BaggingTaggingGetAllItemDetailsException extends BaggingTaggingExceptions {}

class BaggingTaggingGetAllItemListException extends BaggingTaggingExceptions {}

class BaggingTaggingGetAllDbException extends BaggingTaggingExceptions {}

class BaggingTaggingInsertPendingListException extends BaggingTaggingExceptions {}

class SyncStatusUpdateException extends BaggingTaggingExceptions {}

class UnknownException extends BaggingTaggingExceptions {}

class BaggingTaggingInsertConfirmationListException extends BaggingTaggingExceptions {}

class BaggingTaggingGetAllConfirmationListException extends BaggingTaggingExceptions {}

class BaggingTaggingPendingPoSearchException extends BaggingTaggingExceptions {}