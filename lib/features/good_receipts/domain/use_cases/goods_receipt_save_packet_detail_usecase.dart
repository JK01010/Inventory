import 'package:fpdart/fpdart.dart';

import '../entities/packet_details_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class GoodsReceiptSavePacketDetailUseCase {
  Future<Either<GoodsReceiptsFailures, List<PacketDetailsEntity>>>
  goodsReceiptSavePacketDetail(
    List<PacketDetailsEntity> packetDetailsEntityList,
  );
}

class GoodsReceiptSavePacketDetailUseCaseImpl
    implements GoodsReceiptSavePacketDetailUseCase {
  GoodsReceiptSavePacketDetailUseCaseImpl({required this.repository});

  final GoodsReceiptsRepository repository;

  @override
  Future<Either<GoodsReceiptsFailures, List<PacketDetailsEntity>>>
  goodsReceiptSavePacketDetail(
    List<PacketDetailsEntity> packetDetailsEntityList,
  ) {
    return repository.goodsReceiptSavePacketDetailList(
      packetDetailEntityList: packetDetailsEntityList,
    );
  }
}
