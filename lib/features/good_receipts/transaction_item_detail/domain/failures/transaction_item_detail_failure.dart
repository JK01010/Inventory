sealed class TransactionItemDetailFailure {}

class TransactionItemDetailUnknownFailure
    implements TransactionItemDetailFailure {}

class TransactionItemDetailDbFailure
    implements TransactionItemDetailFailure {}


class TransactionItemDetailServerFailure
    implements TransactionItemDetailFailure {}
