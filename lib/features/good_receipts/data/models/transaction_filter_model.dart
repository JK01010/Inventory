// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../../../core/constants/app_enum.dart';
import '../../../common_feature/data/model/item_category_model.dart';
import '../../domain/entities/transaction_filter_entity.dart';

class TransactionFilterModel extends Equatable {
  const TransactionFilterModel({
    this.poNumberOrTitle,
    this.categoryList,
    this.deliveryPort,
    this.grnNo,
    this.fromDate,
    this.toDate,
    this.syncFilter,
  });

  final String? poNumberOrTitle;
  final List<ItemCategoryModel>? categoryList;
  final int? deliveryPort;
  final String? grnNo;
  final DateTime? fromDate;
  final DateTime? toDate;
  final SyncFilter? syncFilter;
  @override
  List<Object?> get props => [
    poNumberOrTitle,
    categoryList,
    deliveryPort,
    grnNo,
    fromDate,
    toDate,
    syncFilter,
  ];

  factory TransactionFilterModel.fromEntity(TransactionFilterEntity entity) {
    return TransactionFilterModel(
      categoryList:
          entity.categoryList?.map(ItemCategoryModel.fromEntity).toList(),
      deliveryPort: entity.portId,
      fromDate: entity.fromDate,
      toDate: entity.toDate,
      grnNo: entity.grnNo,
      poNumberOrTitle: entity.poNumberOrTitle,
      syncFilter: entity.syncFilter,
    );
  }

  TransactionFilterModel copyWith({
    String? poNumberOrTitle,
    List<ItemCategoryModel>? categoryList,
    int? deliveryPort,
    String? grnNo,
    DateTime? fromDate,
    DateTime? toDate,
    SyncFilter? syncFilter,
  }) {
    return TransactionFilterModel(
      poNumberOrTitle: poNumberOrTitle ?? this.poNumberOrTitle,
      categoryList: categoryList ?? this.categoryList,
      deliveryPort: deliveryPort ?? this.deliveryPort,
      grnNo: grnNo ?? this.grnNo,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      syncFilter: syncFilter ?? this.syncFilter,
    );
  }
}
