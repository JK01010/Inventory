sealed class TransactionItemDetailException implements Exception {}

class TransactionItemDetailUnknownException
    extends TransactionItemDetailException {}

class TransactionItemDetailDbException
    extends TransactionItemDetailException {}

class TransactionItemDetailServerException
    extends TransactionItemDetailException {}
