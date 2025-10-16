part of 'goods_receipt_packet_detail_bloc.dart';

class GoodsReceiptPacketDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GoodsReceiptFetchPacketsByPoIdEvent
    extends GoodsReceiptPacketDetailEvent {
  GoodsReceiptFetchPacketsByPoIdEvent({required this.poId});

  final String poId;
}

class GoodsReceiptAddEmptyPacketEvent extends GoodsReceiptPacketDetailEvent {}

class SavePacketListEvent extends GoodsReceiptPacketDetailEvent {
  SavePacketListEvent(this.packetDetailsEntityList);

  List<PacketDetailsEntity> packetDetailsEntityList = [];
}
