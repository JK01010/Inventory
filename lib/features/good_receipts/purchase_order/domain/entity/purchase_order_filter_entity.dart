// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/app_enum.dart';
import '../../../../common_feature/domain/entities/item_category_entity.dart';

class PurchaseOrderFilterEntity extends Equatable {
  const PurchaseOrderFilterEntity({
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

  PurchaseOrderFilterEntity copyWith({
    String? poNumberOrTitle,
    List<ItemCategoryEntity>? categoryList,
    String? deliveryPortName,
    String? grnNo,
    DateTime? fromDate,
    DateTime? toDate,
    SyncFilter? syncFilter,
  }) {
    return PurchaseOrderFilterEntity(
      poNumberOrTitle: poNumberOrTitle ?? this.poNumberOrTitle,
      categoryList: categoryList ?? this.categoryList,
      deliveryPortName: deliveryPortName ?? this.deliveryPortName,
      grnNo: grnNo ?? this.grnNo,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      syncFilter: syncFilter ?? this.syncFilter,
    );
  }
}
