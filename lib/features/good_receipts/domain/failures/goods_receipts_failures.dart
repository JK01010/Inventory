import '../../../../core/error/failures.dart';

sealed class GoodsReceiptsFailures extends Failure {
  const GoodsReceiptsFailures({required super.code, required super.message});
}

class GoodsReceiptsServerFailure extends GoodsReceiptsFailures {
  const GoodsReceiptsServerFailure({
    required super.code,
    required super.message,
  });
}

class GoodsReceiptsLockStatusUpdateFailure extends GoodsReceiptsFailures {
  const GoodsReceiptsLockStatusUpdateFailure({
    required super.code,
    required super.message,
  });
}

class GoodsReceiptsUnknownFailure extends GoodsReceiptsFailures {
  const GoodsReceiptsUnknownFailure({
    required super.code,
    required super.message,
  });
}

class GoodsReceiptsGetAllDbFailure extends GoodsReceiptsFailures {
  const GoodsReceiptsGetAllDbFailure({
    required super.code,
    required super.message,
  });
}

class GoodsReceiptsInsertPoFailure extends GoodsReceiptsFailures {
  const GoodsReceiptsInsertPoFailure({
    required super.code,
    required super.message,
  });
}

class GoodsReceiptsDetailInsertPoFailure extends GoodsReceiptsFailures {
  const GoodsReceiptsDetailInsertPoFailure({
    required super.code,
    required super.message,
  });
}

class GetGoodsReceiptsDetailByIdFailure extends GoodsReceiptsFailures {
  const GetGoodsReceiptsDetailByIdFailure({
    required super.code,
    required super.message,
  });
}

class GoodsReceiptsDetailInsertAttachmentFailure extends GoodsReceiptsFailures {
  const GoodsReceiptsDetailInsertAttachmentFailure({
    required super.code,
    required super.message,
  });
}

class GoodsReceiptsDetailGetAttachmentFailure extends GoodsReceiptsFailures {
  const GoodsReceiptsDetailGetAttachmentFailure({
    required super.code,
    required super.message,
  });
}

class GoodsReceiptsInsertLabelDetailFailure extends GoodsReceiptsFailures {
  const GoodsReceiptsInsertLabelDetailFailure({
    required super.code,
    required super.message,
  });
}

class GetGoodsReceiptsLabelDetailFailure extends GoodsReceiptsFailures {
  const GetGoodsReceiptsLabelDetailFailure({
    required super.code,
    required super.message,
  });
}

class TransactionItemSyncFailure extends GoodsReceiptsFailures {
  const TransactionItemSyncFailure({
    required super.code,
    required super.message,
  });
}

class UpdateGoodsReceiptsPoDetailFailure extends GoodsReceiptsFailures {
  const UpdateGoodsReceiptsPoDetailFailure({
    required super.code,
    required super.message,
  });
}

class GoodsReceiptsUploadFileFailure extends GoodsReceiptsFailures {
  const GoodsReceiptsUploadFileFailure({
    required super.code,
    required super.message,
  });
}

class GoodsReceiptDetailUpdateLabelListFailure extends GoodsReceiptsFailures {
  const GoodsReceiptDetailUpdateLabelListFailure({
    required super.code,
    required super.message,
  });
}

class GoodsReceiptDetailUpdateLabelFailure extends GoodsReceiptsFailures {
  const GoodsReceiptDetailUpdateLabelFailure({
    required super.code,
    required super.message,
  });
}

class GoodsReceiptCreateLabelSaveDetailFailure extends GoodsReceiptsFailures {
  const GoodsReceiptCreateLabelSaveDetailFailure({
    required super.code,
    required super.message,
  });
}

class GoodsReceiptsGetLabelAttachmentFailure extends GoodsReceiptsFailures {
  const GoodsReceiptsGetLabelAttachmentFailure({
    required super.code,
    required super.message,
  });
}

class GoodsReceiptsInsertLabelAttachmentFailure extends GoodsReceiptsFailures {
  const GoodsReceiptsInsertLabelAttachmentFailure({
    required super.code,
    required super.message,
  });
}

class GoodsReceiptsGetIhmAttachmentFailure extends GoodsReceiptsFailures {
  const GoodsReceiptsGetIhmAttachmentFailure({
    required super.code,
    required super.message,
  });
}

class GoodsReceiptsPendingPoSearchFailure extends GoodsReceiptsFailures {
  const GoodsReceiptsPendingPoSearchFailure({
    required super.code,
    required super.message,
  });
}

class GoodsReceiptsInsertTransactionFailure extends GoodsReceiptsFailures {
  const GoodsReceiptsInsertTransactionFailure({
    required super.code,
    required super.message,
  });
}

class GoodsReceiptsInsertTransactionDetailFailure
    extends GoodsReceiptsFailures {
  const GoodsReceiptsInsertTransactionDetailFailure({
    required super.code,
    required super.message,
  });
}

class GoodsReceiptsGetAllTransactionDetailFailure
    extends GoodsReceiptsFailures {
  const GoodsReceiptsGetAllTransactionDetailFailure({
    required super.code,
    required super.message,
  });
}

class GoodsReceiptsGetTransactionDetailByIdFailure
    extends GoodsReceiptsFailures {
  const GoodsReceiptsGetTransactionDetailByIdFailure({
    required super.code,
    required super.message,
  });
}

class StorageLocationGetLocationsByIdFailure extends GoodsReceiptsFailures {
  const StorageLocationGetLocationsByIdFailure({
    required super.code,
    required super.message,
  });
}

class SplitLocationGetLocationsByIdFailure extends GoodsReceiptsFailures {
  const SplitLocationGetLocationsByIdFailure({
    required super.code,
    required super.message,
  });
}

class InsertOrUpdateSplitLocationFailure extends GoodsReceiptsFailures {
  const InsertOrUpdateSplitLocationFailure({
    required super.code,
    required super.message,
  });
}

class DeleteGoodsReceiptLabelItemFailure extends GoodsReceiptsFailures {
  const DeleteGoodsReceiptLabelItemFailure({
    required super.code,
    required super.message,
  });
}

class DeleteSplitLocationItemFailure extends GoodsReceiptsFailures {
  const DeleteSplitLocationItemFailure({
    required super.code,
    required super.message,
  });
}

class GetAllStorageLocationsFailure extends GoodsReceiptsFailures {
  const GetAllStorageLocationsFailure({
    required super.code,
    required super.message,
  });
}

class GetAllImdgClassesFailure extends GoodsReceiptsFailures {
  const GetAllImdgClassesFailure({required super.code, required super.message});
}

class SavePacketDetailsListFailure extends GoodsReceiptsFailures {
  const SavePacketDetailsListFailure({
    required super.code,
    required super.message,
  });
}

class GetGoodsReceiptPoLineItemsListFailure extends GoodsReceiptsFailures {
  const GetGoodsReceiptPoLineItemsListFailure({
    required super.code,
    required super.message,
  });
}

