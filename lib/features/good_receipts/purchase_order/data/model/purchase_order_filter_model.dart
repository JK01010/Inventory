// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/app_enum.dart';
import '../../../../common_feature/domain/entities/item_category_entity.dart';
import '../../domain/entity/purchase_order_filter_entity.dart';

class PurchaseOrderFilterModel extends Equatable {
  const PurchaseOrderFilterModel({
    this.poNumberOrTitle,
    this.categoryList = const [],
    this.deliveryPortName,
    this.grnNo,
    this.fromDate,
    this.toDate,
    this.syncFilter = SyncFilter.all,
  });

  final String? poNumberOrTitle;
  final List<ItemCategoryEntity> categoryList;
  final String? deliveryPortName;
  final String? grnNo;
  final DateTime? fromDate;
  final DateTime? toDate;
  final SyncFilter syncFilter;
  @override
  List<Object?> get props => [
    poNumberOrTitle,
    categoryList,
    deliveryPortName,
    grnNo,
    fromDate,
    toDate,
    syncFilter,
  ];
  factory PurchaseOrderFilterModel.fromEntity(
    PurchaseOrderFilterEntity entity,
  ) {
    return PurchaseOrderFilterModel(
      categoryList: entity.categoryList,
      deliveryPortName: entity.deliveryPortName,
      fromDate: entity.fromDate,
      grnNo: entity.grnNo,
      poNumberOrTitle: entity.poNumberOrTitle,
      syncFilter: entity.syncFilter,
      toDate: entity.toDate,
    );
  }

  PurchaseOrderFilterEntity toEntity() {
    return PurchaseOrderFilterEntity(
      categoryList: categoryList,
      deliveryPortName: deliveryPortName,
      fromDate: fromDate,
      grnNo: grnNo,
      poNumberOrTitle: poNumberOrTitle,
      syncFilter: syncFilter,
      toDate: toDate,
    );
  }
}
