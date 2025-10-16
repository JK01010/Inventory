part of 'bagging_packet_list_bloc.dart';


class BaggingPacketListState extends Equatable {
  const BaggingPacketListState({
    required this.isLoading,
    required this.goodsReceiptsFailures,
    required this.packetDetailsEntity
  });

  factory BaggingPacketListState.initial() => BaggingPacketListState(
    packetDetailsEntity: [],
    isLoading: false,
    goodsReceiptsFailures: none(),
  );

  final List<PacketDetailsEntity> packetDetailsEntity;
  final bool isLoading;
  final Option<GoodsReceiptsFailures> goodsReceiptsFailures;



  @override
  List<Object?> get props => [
    goodsReceiptsFailures,
    isLoading,
    packetDetailsEntity,

  ];

  BaggingPacketListState copyWith({
    List<PacketDetailsEntity>? packetDetailsEntity,
    bool? isLoading,
    Option<GoodsReceiptsFailures>? goodsReceiptsFailures,
  }) {
    return BaggingPacketListState(
      packetDetailsEntity: packetDetailsEntity ?? this.packetDetailsEntity,
      isLoading: isLoading ?? this.isLoading,
      goodsReceiptsFailures: goodsReceiptsFailures ?? this.goodsReceiptsFailures,
    );
  }
}