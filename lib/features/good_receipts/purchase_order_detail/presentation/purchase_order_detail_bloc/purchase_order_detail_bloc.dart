import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../packets/add_packets_sheet/domain/entities/packets_entity.dart';
import '../../domain/use_cases/get_purchase_order_items_db_usecase.dart';
import 'purchase_order_detail_bloc_event.dart';
import 'purchase_order_detail_bloc_state.dart';

class PurchaseOrderDetailBloc
    extends Bloc<PurchaseOrderDetailBlocEvent, PurchaseOrderDetailBlocState> {
  PurchaseOrderDetailBloc({required this.getPurchaseOrderItemsListDbUseCase})
    : super(PurchaseOrderDetailBlocState.initial()) {
    on<PurchaseOrderDetailBlocEvent>((event, emit) async {
      switch (event) {
        case GetPurchaseOrderItemsEvent():
          await onGetPurchaseOrderItemsEvent(event, emit);
          break;
        case SetPurchaseOrderPacketsEvent():
          await onSetPurchaseOrderPacketsEvent(event, emit);
      }
    });
  }

  final GetPurchaseOrderItemsListDbUseCase getPurchaseOrderItemsListDbUseCase;

  Future<void> onGetPurchaseOrderItemsEvent(
    GetPurchaseOrderItemsEvent event,
    Emitter<PurchaseOrderDetailBlocState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        purchaseOrderData: event.purchaseOrderData,
      ),
    );
    final result = await getPurchaseOrderItemsListDbUseCase(
      params: GetPurchaseOrderItemsDbParams(
        poHdId: state.purchaseOrderData.poHdId,
      ),
    );
    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false));
      },
      (success) {
        emit(state.copyWith(purchaseOrderItems: success, isLoading: false));
      },
    );
  }

  Future<void> onSetPurchaseOrderPacketsEvent(
    SetPurchaseOrderPacketsEvent event,
    Emitter<PurchaseOrderDetailBlocState> emit,
  ) async {
    final currentPurchaseOrder = state.purchaseOrderData;
    List<PacketEntity> newPackets = List<PacketEntity>.from(event.packets);
    final updatedPurchaseOrder = currentPurchaseOrder.copyWith(
      packets: newPackets,
    );
    debugPrint(
      " updatedPurchaseOrder.packets.length : ${updatedPurchaseOrder.packets.length}",
    );
    emit(state.copyWith(purchaseOrderData: updatedPurchaseOrder));
  }
}
