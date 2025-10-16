import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/grn_location_serial_mapping_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class FetchGRNLocationSerialMappingUseCase {
  Future<Either<GoodsReceiptsFailures, List<GRNLocationSerialMappingEntity>>>
  call();
}

class FetchGRNLocationSerialMappingUseCaseImpl
    implements FetchGRNLocationSerialMappingUseCase {
  FetchGRNLocationSerialMappingUseCaseImpl({required this.repository});

  final GoodsReceiptsRepository repository;

  @override
  Future<Either<GoodsReceiptsFailures, List<GRNLocationSerialMappingEntity>>>
  call() {
    return repository.fetchGRNLocationSerialMappingList();
  }
}
