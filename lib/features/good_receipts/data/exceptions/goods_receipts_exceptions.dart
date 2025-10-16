sealed class GoodsReceiptsExceptions implements Exception {}

class GoodsReceiptsServerException extends GoodsReceiptsExceptions {}

class GoodsReceiptsGetAllDbException extends GoodsReceiptsExceptions {}

class GoodsReceiptsPendingPoSearchException extends GoodsReceiptsExceptions {}

class GoodsReceiptsInsertPoException extends GoodsReceiptsExceptions {}

class GoodsReceiptsInsertPoDetailException extends GoodsReceiptsExceptions {}

class GoodsReceiptsGetPoDetailByIDException extends GoodsReceiptsExceptions {}

class GoodsReceiptsInsertAttachmentException extends GoodsReceiptsExceptions {}

class GoodsReceiptsGetAttachmentException extends GoodsReceiptsExceptions {}

class GoodsReceiptsInsertDetailLabelException extends GoodsReceiptsExceptions {}

class GoodsReceiptsGetLabelItemsException extends GoodsReceiptsExceptions {}

class LockStatusUpdateException extends GoodsReceiptsExceptions {}

class TransactionItemSyncException extends GoodsReceiptsExceptions {}

class UnknownException extends GoodsReceiptsExceptions {}

class GoodsReceiptsUpdatePoDetailException extends GoodsReceiptsExceptions {}

class GoodsReceiptsDetailUpdateLabelListException
    extends GoodsReceiptsExceptions {}

class GoodsReceiptsDetailUpdateLabelException extends GoodsReceiptsExceptions {}

class GoodsReceiptsCreateLabelSaveException extends GoodsReceiptsExceptions {}

class GoodsReceiptsGetLabelAttachmentsException
    extends GoodsReceiptsExceptions {}

class GoodsReceiptsInsertLabelAttachmentException
    extends GoodsReceiptsExceptions {}

class AttachmentFileUpdateException extends GoodsReceiptsExceptions {}

class GoodsReceiptsGetIhmAttachmentsException extends GoodsReceiptsExceptions {}

class GoodsReceiptsInsertTransactionDetailException
    extends GoodsReceiptsExceptions {}

class GoodsReceiptsInsertTransactionException extends GoodsReceiptsExceptions {}

class GoodsReceiptsGetAllTransactionDetailException
    extends GoodsReceiptsExceptions {}

class GoodsReceiptsGetTransactionDetailByIdException
    extends GoodsReceiptsExceptions {}

class StockLocationUpdateException extends GoodsReceiptsExceptions {}

class GetStorageLocationException extends GoodsReceiptsExceptions {}

class GetSplitLocationException extends GoodsReceiptsExceptions {}

class InsertOrUpdateSplitLocationException extends GoodsReceiptsExceptions {}

class DeleteGoodsReceiptLabelItemException extends GoodsReceiptsExceptions {}

class DeleteSplitLocationItemException extends GoodsReceiptsExceptions {}

class GetAllStorageLocationException extends GoodsReceiptsExceptions {}

class GetAllImdgClassException extends GoodsReceiptsExceptions {}

class GoodsReceiptsSavePacketDetailsException extends GoodsReceiptsExceptions {}

class GoodsReceiptsGetAllPoLineItemsException extends GoodsReceiptsExceptions {}
