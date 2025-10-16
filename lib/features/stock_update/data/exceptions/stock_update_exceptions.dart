sealed class StockUpdateExceptions implements Exception{}

class StockUpdateServerException extends StockUpdateExceptions {}
class StockUpdateInsertDbException extends StockUpdateExceptions {}
class StockUpdateFetchDbException extends StockUpdateExceptions {}
