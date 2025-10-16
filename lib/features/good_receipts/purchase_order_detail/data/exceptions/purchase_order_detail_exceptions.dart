sealed class PurchaseOrderDetailExceptions implements Exception{}


class PurchaseOrderItemsServerException extends PurchaseOrderDetailExceptions {}

class PurchaseOrderItemDbException extends PurchaseOrderDetailExceptions {}

class PurchaseOrderDetailUnknowException extends PurchaseOrderDetailExceptions {}
