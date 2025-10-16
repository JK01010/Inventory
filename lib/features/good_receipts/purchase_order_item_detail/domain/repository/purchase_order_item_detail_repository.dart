import 'package:fpdart/fpdart.dart';

import '../../../../common_feature/domain/entities/fetch_imdg_class_entity.dart';
import '../../../../common_feature/domain/entities/quality_entity.dart';
import '../../../domain/entities/split_location_entity.dart';
import '../entity/serial_number_entity.dart';
import '../failures/purchase_order_item_details_failures.dart';
import '../use_cases/generate_serial_numbers_usecase.dart';
import '../use_cases/get_purchase_order_item_serial_number_usecase.dart';
import '../use_cases/get_purchase_order_item_split_location_data.dart';
import '../use_cases/update_purchase_order_item_usecase.dart';

abstract interface class PurchaseOrderItemDetailRepository {
  Future<Either<PurchaseOrderItemDetailsFailures, Unit>> getQualityList();

  Future<Either<PurchaseOrderItemDetailsFailures, List<QualityEntity>>>
  getQualityListDb();

  Future<Either<PurchaseOrderItemDetailsFailures, Unit>> getImdgClass();

  Future<Either<PurchaseOrderItemDetailsFailures, List<ImdgClassEntity>>>
  getImdgClassListDb();

  Future<Either<PurchaseOrderItemDetailsFailures, Unit>>
  updatePurchaseOrderItemData({
    required UpdatePurchaseOrderItemDataParams
    updatePurchaseOrderItemDataParams,
  });

  Future<Either<PurchaseOrderItemDetailsFailures, List<SplitLocationEntity>>>
  getPurchaseOrderItemSplitLocationData({
    required GetPurchaseOrderItemSplitLocationDataParams
    getPendingPoSplitLocationDataParams,
  });

  Future<Either<PurchaseOrderItemDetailsFailures, List<SerialNumberEntity>>>
  generateSerialNumbers({
    required GenerateSerialNumberParams generateSerialNumberParams,
  });

  Future<Either<PurchaseOrderItemDetailsFailures, List<SerialNumberEntity>>>
  getPurchaseOrderItemSerialNumberUseCase({
    required GetPurchaseOrderItemSerialNumberParams
    getPurchaseOrderItemSerialNumberParams,
  });
}
