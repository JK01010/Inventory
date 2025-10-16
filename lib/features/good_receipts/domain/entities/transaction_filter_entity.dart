// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../../../core/constants/app_enum.dart';
import '../../../common_feature/domain/entities/item_category_entity.dart';

class TransactionFilterEntity extends Equatable {
  const TransactionFilterEntity({
    this.poNumberOrTitle,
    this.categoryList,
    this.portId,
    this.grnNo,
    this.fromDate,
    this.toDate,
    this.syncFilter = SyncFilter.all,
  });

  final String? poNumberOrTitle;
  final List<ItemCategoryEntity>? categoryList;
  final int? portId;
  final String? grnNo;
  final DateTime? fromDate;
  final DateTime? toDate;
  final SyncFilter syncFilter;
  @override
  List<Object?> get props => [
    poNumberOrTitle,
    categoryList,
    portId,
    grnNo,
    fromDate,
    toDate,
    syncFilter,
  ];

  TransactionFilterEntity copyWith({
    String? poNumberOrTitle,
    List<ItemCategoryEntity>? categoryList,
    int? portId,
    String? grnNo,
    DateTime? fromDate,
    DateTime? toDate,
    SyncFilter? syncFilter,
  }) {
    return TransactionFilterEntity(
      poNumberOrTitle: poNumberOrTitle ?? this.poNumberOrTitle,
      categoryList: categoryList ?? this.categoryList,
      portId: portId ?? this.portId,
      grnNo: grnNo ?? this.grnNo,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      syncFilter: syncFilter ?? this.syncFilter,
    );
  }
}
