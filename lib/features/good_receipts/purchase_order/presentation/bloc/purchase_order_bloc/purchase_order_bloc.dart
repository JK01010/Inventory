import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../domain/entity/purchase_order_entity.dart';
import '../../../domain/entity/purchase_order_filter_entity.dart';
import '../../../domain/failures/purchase_order_failures.dart';
import '../../../domain/usecase/get_purchase_order_from_db_usecase.dart';

part 'purchase_order_event.dart';

part 'purchase_order_state.dart';

class PurchaseOrderBloc extends Bloc<PurchaseOrderEvent, PurchaseOrderState> {
  PurchaseOrderBloc({required this.fetchPurchaseOrderFromDbUsecase})
    : super(PurchaseOrderState.initial()) {
    on<PurchaseOrderEvent>((event, emit) async {
      switch (event) {
        case GetPurchaseOrderFromDb():
          await _fetchPurchaseOrderFromDb(event, emit);
      }
    });
  }

  final GetPurchaseOrderFromDbUsecase fetchPurchaseOrderFromDbUsecase;

  Future<void> _fetchPurchaseOrderFromDb(
    GetPurchaseOrderFromDb event,
    Emitter<PurchaseOrderState> emit,
  ) async {
    final Either<PurchaseOrderFailures, List<PurchaseOrderEntity>>
    failureOrSuccess = await fetchPurchaseOrderFromDbUsecase(
      purchaseOrderFilterEntity: event.purchaseOrderFilterEntity,
    );

    failureOrSuccess.fold((failure) {}, (success) {
      emit(state.copyWith(purchaseOrderEntityList: success.reversed.toList()));
    });
  }
}
