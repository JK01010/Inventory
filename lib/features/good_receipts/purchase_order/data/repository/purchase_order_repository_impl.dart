import 'package:fpdart/fpdart.dart';

import '../../domain/entity/purchase_order_entity.dart';
import '../../domain/entity/purchase_order_filter_entity.dart';
import '../../domain/failures/purchase_order_failures.dart';
import '../../domain/repository/purchase_order_repository.dart';
import '../data_source/purchase_order_local_data_source.dart';
import '../data_source/purchase_order_network_data_source.dart';
import '../model/purchase_order_filter_model.dart';
import '../model/purchase_order_model.dart';

class PurchaseOrderRepositoryImpl implements PurchaseOrderRepository {
  PurchaseOrderRepositoryImpl({
    required this.purchaseOrderNetworkDataSource,
    required this.purchaseOrderLocalDataSource,
  });

  final PurchaseOrderNetworkDataSource purchaseOrderNetworkDataSource;
  final PurchaseOrderLocalDataSource purchaseOrderLocalDataSource;

  @override
  Future<Either<PurchaseOrderFailures, Unit>> getPurchaseOrderFromApi() async {
    // try {
    final PurchaseOrderResponseModel? purchaseOrderResponseModel =
        await purchaseOrderNetworkDataSource.getAllPurchaseOrderFromApi();

    if (purchaseOrderResponseModel != null &&
        purchaseOrderResponseModel.reportData != null) {
      purchaseOrderLocalDataSource.insertPurchaseOrderList(
        purchaseOrderModelList: purchaseOrderResponseModel.reportData!,
      );
    }
    return right(unit);
  }

  @override
  Future<Either<PurchaseOrderFailures, List<PurchaseOrderEntity>>>
  getPurchaseOrderFromDb({
    PurchaseOrderFilterEntity? purchaseOrderFilterEntity,
  }) async {
    try {
      PurchaseOrderFilterModel? purchaseOrderFilterModel;
      if (purchaseOrderFilterEntity != null) {
        purchaseOrderFilterModel = PurchaseOrderFilterModel.fromEntity(
          purchaseOrderFilterEntity,
        );
      }

      final List<PurchaseOrderModel> purchaseOrderModelList =
          await purchaseOrderLocalDataSource.getAllPurchaseOrderFromDb(
            filter: purchaseOrderFilterModel,
          );

      final List<PurchaseOrderEntity> purchaseOrderEntityList =
          purchaseOrderModelList.map((e) => e.toEntity()).toList();

      return right(purchaseOrderEntityList);
    } catch (e) {
      return left(PurchaseOrderServerFailure(code: "", message: ""));
    }
  }
}
