import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/entities/goods_receipt_purchase_item_detail_entity.dart';
import '../../domain/failures/goods_receipts_failures.dart';
import '../../domain/use_cases/get_all_goods_receipt_transaction_detail_use_case.dart';

part 'goods_receipts_transaction_detail_event.dart';

part 'goods_receipts_transaction_detail_state.dart';

class GoodsReceiptsTransactionDetailBloc
    extends
        Bloc<
          GoodsReceiptsTransactionDetailEvent,
          GoodsReceiptsTransactionDetailState
        > {
  GoodsReceiptsTransactionDetailBloc({
    required this.getAllGoodsReceiptTransactionDetailUseCase,
  }) : super(GoodsReceiptsTransactionDetailState.initial()) {
    on<GoodsReceiptsTransactionDetailEvent>((event, emit) async {
      switch (event) {
        case GetPOItemListForSelectedGRNTransactionEvent():
          await getPOItemListForSelectedGRNTransaction(event, emit);
          break;
        case GetGoodsReceiptsTransactionByIdEvent():
          await getTransactionsDetailById(event, emit);
          break;
      }
    });
  }

  GetAllGoodsReceiptTransactionDetailUseCase
  getAllGoodsReceiptTransactionDetailUseCase;

  Future<void> getPOItemListForSelectedGRNTransaction(
    GetPOItemListForSelectedGRNTransactionEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    debugPrint('getPOItemListForSelectedGRNTransaction poid : ${event.poId}');
    final failureOrSuccess = await getAllGoodsReceiptTransactionDetailUseCase(
      event.poId,
    );

    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(goodsReceiptFailure: some(failure), isLoading: false),
        );
      },
      (success) {
        emit(
          state.copyWith(
            goodsReceiptPurchaseItemDetailEntityList: success,
            isLoading: false,
          ),
        );
      },
    );
  }

  Future<void> getTransactionsDetailById(
    GetGoodsReceiptsTransactionByIdEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    // final failureOrSuccess = await getGoodsReceiptTransactionDetailsByIdUseCase
    //     .getGoodsReceiptTransactionDetailsById(event.transactionId);

    // failureOrSuccess.fold(
    //   (failure) {
    //     emit(
    //       state.copyWith(goodsReceiptFailure: some(failure), isLoading: false),
    //     );
    //   },
    //   (success) {
    //     emit(
    //       state.copyWith(
    //         goodsReceiptPurchaseItemDetailEntity: success,
    //         isLoading: false,
    //       ),
    //     );
    //   },
    // );
  }
}
