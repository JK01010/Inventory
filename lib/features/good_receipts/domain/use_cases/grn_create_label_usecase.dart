import 'package:fpdart/fpdart.dart';

import '../entities/grn_create_label_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class GRNCreateLabelUseCase {
  Future<Either<GoodsReceiptsFailures, List<GRNCreateLabelEntity>>>
  createGRNLabel(int grnId, List<int> itemIds);
}

class GRNCreateLabelUseCaseImpl implements GRNCreateLabelUseCase {
  GRNCreateLabelUseCaseImpl({required this.repository});

  final GoodsReceiptsRepository repository;

  @override
  Future<Either<GoodsReceiptsFailures, List<GRNCreateLabelEntity>>>
  createGRNLabel(int grnId, List<int> itemIds) {
    return repository.grnCreateLabel(grnId, itemIds);
  }
}
