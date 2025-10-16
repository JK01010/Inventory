sealed class ConsumptionExceptions implements Exception{}


class ConsumptionServerException extends ConsumptionExceptions {}

class ConsumptionTransactionInsertDbException extends ConsumptionExceptions {}
