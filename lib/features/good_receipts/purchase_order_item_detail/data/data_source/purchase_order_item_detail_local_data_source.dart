import '../../../../../core/service/db_service/table_data_manipulation/imdg_class_table_data_processor.dart';
import '../../../../../core/service/db_service/table_data_manipulation/pending_po_split_location_table_processor.dart';
import '../../../../../core/service/db_service/table_data_manipulation/purchase_order_item_serial_numbers_table_processor.dart';
import '../../../../../core/service/db_service/table_data_manipulation/purchase_order_items_table_processor.dart';
import '../../../../../core/service/db_service/table_data_manipulation/quality_list_table_data_processor.dart';
import '../../../../common_feature/data/model/fetch_imdg_class_model.dart';
import '../../../../common_feature/data/model/quality_list_model.dart';
import '../../../data/models/pending_po_split_location_model.dart';
import '../../domain/use_cases/get_purchase_order_item_split_location_data.dart';
import '../models/serial_number_data.dart';

abstract interface class PurchaseOrderItemDetailLocalDataSource {
  Future<void> insertQualityList({required List<QualityListData> qualityList});

  Future<List<QualityListData>> getQualityList();

  Future<void> insertImdgClassList({
    required List<ImdgClassData> imdgClassList,
  });

  Future<List<ImdgClassData>> getImdgClassList();

  Future<int> updatePurchaseOrderItemData({
    required int poHdId,
    required int poDtId,
    required Map<String, dynamic> data,
  });

  Future<void> insertPurchaseOrderSplitLocationList({
    required List<PendingPoSplitLocationModel> pendingPoSplitLocationModelList,
  });

  Future<List<PendingPoSplitLocationModel>>
  getPurchaseOrderItemSplitLocationData({
    required GetPurchaseOrderItemSplitLocationDataParams
    getPendingPoSplitLocationDataParams,
  });

  Future<void> insertPurchaseOrderItemsSerialNumbers({
    required List<SerialNumberData> serialNumberData,
  });

  Future<List<SerialNumberData>> getPurchaseOrderItemsSerialNumbers({
    required int poHdId,
    required int poDtId,
  });
}

class PurchaseOrderItemDetailLocalDataSourceImpl
    implements PurchaseOrderItemDetailLocalDataSource {
  PurchaseOrderItemDetailLocalDataSourceImpl({
    required this.qualityTableDataProcessor,
    required this.imdgClassTableDataProcessor,
    required this.purchaseOrderItemsTableProcessor,
    required this.pendingPoSplitLocationTableProcessor,
    required this.purchaseOrderItemSerialNumbersTableProcessor,
  });

  final QualityTableDataProcessor qualityTableDataProcessor;
  final ImdgClassTableDataProcessor imdgClassTableDataProcessor;
  final PurchaseOrderItemsTableProcessor purchaseOrderItemsTableProcessor;
  final PendingPoSplitLocationTableProcessor
  pendingPoSplitLocationTableProcessor;
  final PurchaseOrderItemSerialNumbersTableProcessor
  purchaseOrderItemSerialNumbersTableProcessor;

  @override
  Future<void> insertQualityList({
    required List<QualityListData> qualityList,
  }) async {
    return qualityTableDataProcessor.insertQualityList(
      qualityListData: qualityList,
    );
  }

  @override
  Future<List<QualityListData>> getQualityList() async {
    final result = await qualityTableDataProcessor.getQualityList();
    return result.map(QualityListData.fromJson).toList();
  }

  @override
  Future<void> insertImdgClassList({
    required List<ImdgClassData> imdgClassList,
  }) async {
    return imdgClassTableDataProcessor.insertImdgClassList(
      imdgClassData: imdgClassList,
    );
  }

  @override
  Future<List<ImdgClassData>> getImdgClassList() async {
    final result = await imdgClassTableDataProcessor.getImdgClass();
    return result.map(ImdgClassData.fromJson).toList();
  }

  @override
  Future<int> updatePurchaseOrderItemData({
    required int poHdId,
    required int poDtId,
    required Map<String, dynamic> data,
  }) async {
    return purchaseOrderItemsTableProcessor.updatePurchaseOrderItemData(
      poHdId: poHdId,
      poDtId: poDtId,
      data: data,
    );
  }

  @override
  Future<void> insertPurchaseOrderSplitLocationList({
    required List<PendingPoSplitLocationModel> pendingPoSplitLocationModelList,
  }) async {
    return pendingPoSplitLocationTableProcessor.insertSplitLocationItems(
      pendingPoSplitLocationDataItem: pendingPoSplitLocationModelList,
    );
  }

  @override
  Future<List<PendingPoSplitLocationModel>>
  getPurchaseOrderItemSplitLocationData({
    required GetPurchaseOrderItemSplitLocationDataParams
    getPendingPoSplitLocationDataParams,
  }) async {
    final result = await pendingPoSplitLocationTableProcessor
        .getSplitLocationItems(
          getPendingPoSplitLocationDataParams:
              getPendingPoSplitLocationDataParams,
        );
    return result.map(PendingPoSplitLocationModel.fromJson).toList();
  }

  @override
  Future<void> insertPurchaseOrderItemsSerialNumbers({
    required List<SerialNumberData> serialNumberData,
  }) async {
    return purchaseOrderItemSerialNumbersTableProcessor
        .insertPurchaseOrderItemsSerialNumbers(
          serialNumberData: serialNumberData,
        );
  }

  @override
  Future<List<SerialNumberData>> getPurchaseOrderItemsSerialNumbers({
    required int poHdId,
    required int poDtId,
  }) async {
    final result = await purchaseOrderItemSerialNumbersTableProcessor
        .getPurchaseOrderItemsSerialNumbers(poHdId: poHdId, poDtId: poDtId);
    return result.map(SerialNumberData.fromJsonForPurchaseOrderTable).toList();
  }
}
