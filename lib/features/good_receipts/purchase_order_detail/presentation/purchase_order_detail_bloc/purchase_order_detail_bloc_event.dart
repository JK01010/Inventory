import 'package:equatable/equatable.dart';

import '../../../../packets/add_packets_sheet/domain/entities/packets_entity.dart';
import '../../../purchase_order/domain/entity/purchase_order_entity.dart';

sealed class PurchaseOrderDetailBlocEvent extends Equatable {
  const PurchaseOrderDetailBlocEvent();

  @override
  List<Object> get props => [];
}

class GetPurchaseOrderItemsEvent extends PurchaseOrderDetailBlocEvent {
  const GetPurchaseOrderItemsEvent({required this.purchaseOrderData});

  final PurchaseOrderEntity purchaseOrderData;
}

class SetPurchaseOrderPacketsEvent extends PurchaseOrderDetailBlocEvent {
  const SetPurchaseOrderPacketsEvent({required this.packets});

  final List<PacketEntity> packets;
}
