import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/app_logger.dart';
import '../../domain/entities/goods_receipt_label_attachment_entity.dart';
import '../../domain/entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../../domain/failures/goods_receipts_failures.dart';
import '../../domain/use_cases/get_goods_receipt_label_attachments_usecase.dart';
import '../../domain/use_cases/insert_captured_selected_media_label_attachment_usecase.dart';

part 'goods_receipt_label_attachment_item_event.dart';
part 'goods_receipt_label_attachment_item_state.dart';

class GoodsReceiptLabelAttachmentItemBloc
    extends
        Bloc<
          GoodsReceiptLabelAttachmentItemEvent,
          GoodsReceiptLabelAttachmentItemState
        > {
  GoodsReceiptLabelAttachmentItemBloc({
    required this.getGoodsReceiptLabelAttachmentsUseCase,
    required this.insertCapturedSelectedMediaLabelAttachmentUseCase,
  }) : super(GoodsReceiptLabelAttachmentItemState.initial()) {
    on<GoodsReceiptLabelAttachmentItemEvent>((event, emit) async {
      switch (event) {
        case GetGoodsReceiptLabelAttachmentItemEvent():
          await getGoodsReceiptLabelAttachments(event, emit);
          break;
        case InsertCapturedOrSelectedLabelAttachmentEvent():
          await insertCapturedOrSelectedLabelAttachments(event, emit);
          break;
      }
    });
  }

  GetGoodsReceiptLabelAttachmentsUseCase getGoodsReceiptLabelAttachmentsUseCase;
  InsertCapturedSelectedMediaLabelAttachmentUseCase
  insertCapturedSelectedMediaLabelAttachmentUseCase;

  Future<void> getGoodsReceiptLabelAttachments(
    GetGoodsReceiptLabelAttachmentItemEvent event,
    Emitter<GoodsReceiptLabelAttachmentItemState> emit,
  ) async {
    await Future.delayed(Duration(seconds: 2));
    final failureOrSuccess = await getGoodsReceiptLabelAttachmentsUseCase
        .getGoodsReceiptLabelAttachmentList(
          event.goodsReceiptPurchaseOrderLineItemEntity,
        );
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(goodsReceiptsFailure: some(failure), isLoading: false),
        );
      },
      (success) {
        emit(
          state.copyWith(
            goodsReceiptLabelAttachmentEntityList: success,
            isLoading: false,
          ),
        );
      },
    );
  }

  Future<void> insertCapturedOrSelectedLabelAttachments(
    InsertCapturedOrSelectedLabelAttachmentEvent event,
    Emitter<GoodsReceiptLabelAttachmentItemState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        goodsReceiptLabelAttachmentEntityList: [],
      ),
    );
    await Future.delayed(Duration(seconds: 2));
    final failureOrSuccess =
        await insertCapturedSelectedMediaLabelAttachmentUseCase(
          event.goodsReceiptLabelAttachmentEntityList,
        );
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(goodsReceiptsFailure: some(failure), isLoading: false),
        );
      },
      (success) {
        emit(
          state.copyWith(
            goodsReceiptLabelAttachmentEntityList: success,
            isLoading: false,
          ),
        );
      },
    );
  }
}
