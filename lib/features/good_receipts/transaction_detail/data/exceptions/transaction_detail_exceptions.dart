sealed class TransactionDetailExceptions implements Exception{}


class TransactionDetailServerException extends TransactionDetailExceptions {}

class TransactionDetailDbException extends TransactionDetailExceptions {}

class TransactionDetailUnknowException extends TransactionDetailExceptions {}
