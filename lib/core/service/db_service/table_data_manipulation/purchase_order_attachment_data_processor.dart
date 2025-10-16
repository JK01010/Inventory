import 'package:sqflite/sqflite.dart';

import '../../../../features/good_receipts/purchase_order/data/model/purchase_order_attachment_model.dart';
import '../tables/po_attachments_table.dart';

abstract interface class PurchaseOrderAttachmentDataProcessor {
  Future<void> insertPurchaseOrderAttachments({
    required List<PurchaseOrderAttachmentModel> purchaseOrderAttachmentModel,
  });

  Future<List<Map<String, dynamic>>> getPurchaseOrderAttachments({
    required int poHdId,
  });
}

class PurchaseOrderAttachmentDataProcessorImpl
    implements PurchaseOrderAttachmentDataProcessor {
  PurchaseOrderAttachmentDataProcessorImpl({required this.db});

  final Database db;

  @override
  Future<List<Map<String, dynamic>>> getPurchaseOrderAttachments({
    required int poHdId,
  }) {
    return db.query(PoAttachmentsTable.tableName);
  }

  @override
  Future<void> insertPurchaseOrderAttachments({
    required List<PurchaseOrderAttachmentModel> purchaseOrderAttachmentModel,
  }) async {
    final Batch batch = db.batch();

    for (var element in purchaseOrderAttachmentModel) {
      batch.insert(PoAttachmentsTable.tableName, element.toJson());
    }
    await batch.commit();
  }
}
