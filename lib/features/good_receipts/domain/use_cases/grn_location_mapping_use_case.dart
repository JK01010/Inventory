import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/grn_location_mapping_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class FetchGRNLocationMappingUseCase {
  Future<Either<GoodsReceiptsFailures, List<GRNLocationMappingEntity>>>
  call();
}

class FetchGRNLocationMappingUseCaseImpl
    implements FetchGRNLocationMappingUseCase {
  FetchGRNLocationMappingUseCaseImpl({required this.repository});

  final GoodsReceiptsRepository repository;

  @override
  Future<Either<GoodsReceiptsFailures, List<GRNLocationMappingEntity>>>
  call() {
    return repository.fetchGRNLocationMappingList();
  }
}
