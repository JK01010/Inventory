import 'package:fpdart/fpdart.dart';

import '../entities/packet_details_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class GetAllPacketDetailsForGrByPoIdUseCase {
  Future<Either<GoodsReceiptsFailures, List<PacketDetailsEntity>>> call({
    required String grnId,
  });
}

class GetAllPacketDetailsForGrByPoIdUseCaseImpl
    implements GetAllPacketDetailsForGrByPoIdUseCase {
  GetAllPacketDetailsForGrByPoIdUseCaseImpl({required this.repository});

  final GoodsReceiptsRepository repository;

  @override
  Future<Either<GoodsReceiptsFailures, List<PacketDetailsEntity>>> call({
    required String grnId,
  }) {
    return repository.getPacketDetailsByPoId(grnId: grnId);
  }
}
