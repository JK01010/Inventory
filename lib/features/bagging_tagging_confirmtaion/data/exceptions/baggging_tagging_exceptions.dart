sealed class BaggingTaggingExceptions implements Exception{}

class BaggingTaggingServerException extends BaggingTaggingExceptions {}

class BaggingTaggingGetAllDbException extends BaggingTaggingExceptions {}
class BaggingTaggingInsertPendingListException extends BaggingTaggingExceptions {}

class SyncStatusUpdateException extends BaggingTaggingExceptions {}

class UnknownException extends BaggingTaggingExceptions {}