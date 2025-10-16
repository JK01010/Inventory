import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../good_receipts/domain/entities/goods_receipt_purchase_item_detail_entity.dart';
import '../../../../good_receipts/domain/entities/goods_receipt_transaction_entity.dart';
import '../../../../good_receipts/domain/failures/goods_receipts_failures.dart';
import '../../../../good_receipts/domain/use_cases/get_all_goods_receipt_transaction_detail_use_case.dart';
import '../../../../good_receipts/domain/use_cases/goods_receipts_po_usecase/save_bagging_and_tagging_usecase.dart';
import '../../../../good_receipts/domain/use_cases/goods_receipts_po_usecase/save_goods_receipts_usecase.dart';

part 'bagging_tagging_purchase_pending_details_event.dart';

part 'bagging_tagging_purchase_pending_details_state.dart';

class BaggingTaggingPurchasePendingDetailsBloc
    extends
        Bloc<
          BaggingTaggingPurchasePendingDetailsEvent,
          BaggingTaggingPurchasePendingDetailsState
        > {
  BaggingTaggingPurchasePendingDetailsBloc({
    required this.getAllGoodsReceiptTransactionDetailUseCase,
    required this.saveBaggingAndTaggingUsecase,
  }) : super(BaggingTaggingPurchasePendingDetailsState.initial()) {
    on<BaggingTaggingPurchasePendingDetailsEvent>((event, emit) async {
      switch (event) {
        case GetBaggingTaggingPendingByIdEvent():
          await getTransactionsDetailById(event, emit);
          break;
        case SetPendingInitalDataEvent():
          await setPendingInitalData(event, emit);
          break;
        case SaveBaggingAndTagging():
          await saveBaggingAndTagging(event, emit);
      }
    });
  }

  GetAllGoodsReceiptTransactionDetailUseCase
  getAllGoodsReceiptTransactionDetailUseCase;

  SaveBaggingAndTaggingUsecase saveBaggingAndTaggingUsecase;

  Future<void> getTransactionsDetailById(
    GetBaggingTaggingPendingByIdEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final failureOrSuccess = await getAllGoodsReceiptTransactionDetailUseCase(
      event.transactionId,
    );

    failureOrSuccess.fold(
      (failure) {
        debugPrint("failureOrSuccess:: $failure");
        emit(
          state.copyWith(goodsReceiptFailure: some(failure), isLoading: false),
        );
      },
      (success) {
        debugPrint("success:: $success");
        emit(
          state.copyWith(
            goodsReceiptPurchaseItemDetailEntityList: success,
            isLoading: false,
          ),
        );
      },
    );
  }

  Future<void> setPendingInitalData(
    SetPendingInitalDataEvent event,
    Emitter<BaggingTaggingPurchasePendingDetailsState> emit,
  ) async {
    emit(
      state.copyWith(
        goodsReceiptsTransactionEntity: event.goodsReceiptsTransactionEntity,
      ),
    );
  }

  Future<void> saveBaggingAndTagging(
    SaveBaggingAndTagging event,
    Emitter<BaggingTaggingPurchasePendingDetailsState> emit,
  ) async {
    final BaggingAndTaggingParams param = BaggingAndTaggingParams(
      id: event.id,
      statusType: "FNL",
    );
    emit(state.copyWith(isLoading: true));
    final failureOrSuccess = await saveBaggingAndTaggingUsecase(param);
    emit(state.copyWith(isLoading: false));
    emit(state.copyWith(saveLoading: true));
    emit(state.copyWith(saveLoading: false));

    failureOrSuccess.fold(
      (l) {
        log(l.toString(), name: "failure");
      },
      (r) {
        log(r.toString(), name: "Succcess");
      },
    );
  }
}
