part of 'goods_receipt_packet_detail_bloc.dart';

@immutable
class GoodsReceiptPacketDetailState extends Equatable {
  GoodsReceiptPacketDetailState({
    required this.isLoading,
    required this.goodsReceiptsFailures,
    required this.packetDetailsEntityList,
  });

  factory GoodsReceiptPacketDetailState.initial() =>
      GoodsReceiptPacketDetailState(
        packetDetailsEntityList: [],
        isLoading: false,
        goodsReceiptsFailures: none(),
      );

  final List<PacketDetailsEntity> packetDetailsEntityList;
  final bool isLoading;
  final Option<GoodsReceiptsFailures> goodsReceiptsFailures;

  @override
  List<Object?> get props => [
    goodsReceiptsFailures,
    isLoading,
    packetDetailsEntityList,
  ];

  GoodsReceiptPacketDetailState copyWith({
    List<PacketDetailsEntity>? packetDetailsEntityList,
    bool? isLoading,
    Option<GoodsReceiptsFailures>? goodsReceiptsFailures,
  }) {
    return GoodsReceiptPacketDetailState(
      packetDetailsEntityList:
          packetDetailsEntityList ?? this.packetDetailsEntityList,
      isLoading: isLoading ?? this.isLoading,
      goodsReceiptsFailures:
          goodsReceiptsFailures ?? this.goodsReceiptsFailures,
    );
  }
}
