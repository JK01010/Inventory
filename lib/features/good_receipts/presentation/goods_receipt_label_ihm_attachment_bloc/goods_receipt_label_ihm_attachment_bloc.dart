import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/app_logger.dart';
import '../../domain/entities/goods_receipt_ihm_attachment_entity.dart';
import '../../domain/failures/goods_receipts_failures.dart';
import '../../domain/use_cases/get_goods_receipt_ihm_attachments_usecase.dart';
import '../../domain/use_cases/goods_receipt_create_label_get_label_detail_usecase.dart';

part 'goods_receipt_label_ihm_attachment_event.dart';
part 'goods_receipt_label_ihm_attachment_state.dart';

class GoodsReceiptLabelIhmAttachmentBloc extends Bloc<GoodsReceiptLabelIhmAttachmentEvent, GoodsReceiptLabelIhmAttachmentState> {
  GoodsReceiptLabelIhmAttachmentBloc({
    required this.getGoodsReceiptIhmAttachmentsUseCase
  }) : super(GoodsReceiptLabelIhmAttachmentState.initial()) {
    on<GoodsReceiptLabelIhmAttachmentEvent>((event, emit) async {
      switch(event){
        case GetGoodsReceiptLabelIhmAttachmentEvent():
          await getGoodsReceiptLabelIhmAttachmentEvent(event, emit);
      }
    });
  }

  GetGoodsReceiptIhmAttachmentsUseCase getGoodsReceiptIhmAttachmentsUseCase;

  Future<void> getGoodsReceiptLabelIhmAttachmentEvent(GetGoodsReceiptLabelIhmAttachmentEvent event,
      Emitter<GoodsReceiptLabelIhmAttachmentState> emit)async {
    emit(state.copyWith(isLoading: true, goodsReceiptIhmAttachmentEntityList: []));
    await Future.delayed(Duration(seconds: 2));
    final failureOrSuccess = await getGoodsReceiptIhmAttachmentsUseCase.getGoodsReceiptIhmAttachmentList(event.itemId);
    failureOrSuccess.fold(
          (failure) {
        emit(
          state.copyWith(goodsReceiptFailure: some(failure),isLoading: false),
        );
      },
          (success) {
        emit(
          state.copyWith(goodsReceiptIhmAttachmentEntityList: success, isLoading: false),
        );
      },
    );
  }
}
