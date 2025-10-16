import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/app_logger.dart';
import '../../domain/entities/goods_receipt_attachment_entity.dart';
import '../../domain/failures/goods_receipts_failures.dart';
import '../../domain/use_cases/get_goods_receipt_attachments_usecase.dart';
import '../../domain/use_cases/insert_captured_selected_media_attachment_usecase.dart';
import '../../domain/use_cases/insert_goods_receipts_attachment_usecase.dart';

part 'goods_receipt_attachment_event.dart';
part 'goods_receipt_attachment_state.dart';

class GoodsReceiptAttachmentBloc
    extends Bloc<GoodsReceiptAttachmentEvent, GoodsReceiptAttachmentState> {
  GoodsReceiptAttachmentBloc({
    required this.insertGoodsReceiptsAttachmentUseCase,
    required this.getGoodsReceiptAttachmentsUseCase,
    required this.insertCapturedSelectedMediaAttachmentUseCase,
  }) : super(GoodsReceiptAttachmentState.initial()) {
    on<GoodsReceiptAttachmentEvent>((event, emit) async {
      switch (event) {
        case InsertGoodsReceiptsAttachmentEvent():
          await insertGoodsReceiptsAttachments();
          return;
        case GetGoodsReceiptsAttachmentEvent():
          await getGoodsReceiptAttachmentList(event, emit);
          return;
        case InsertCapturedOrSelectedAttachmentEvent():
          await insertCapturedOrSelectedAttachmentEntity(event, emit);
      }
    });
  }

  final InsertGoodsReceiptsAttachmentUseCase
  insertGoodsReceiptsAttachmentUseCase;
  final GetGoodsReceiptAttachmentsUseCase getGoodsReceiptAttachmentsUseCase;
  final InsertCapturedSelectedMediaAttachmentUseCase
  insertCapturedSelectedMediaAttachmentUseCase;

  Future<void> insertGoodsReceiptsAttachments() async {
    await insertGoodsReceiptsAttachmentUseCase();
  }

  Future<void> getGoodsReceiptAttachmentList(
    GetGoodsReceiptsAttachmentEvent event,
    Emitter<GoodsReceiptAttachmentState> emit,
  ) async {
    await Future.delayed(Duration(seconds: 2));
    final failureOrSuccess = await getGoodsReceiptAttachmentsUseCase
        .getGoodsReceiptAttachmentList(event.poId);
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(goodsReceiptsFailure: some(failure), isLoading: false),
        );
      },
      (success) {
        emit(
          state.copyWith(
            goodsReceiptAttachmentEntityList: success,
            isLoading: false,
          ),
        );
      },
    );
  }

  Future<void> insertCapturedOrSelectedAttachmentEntity(
    InsertCapturedOrSelectedAttachmentEvent event,
    Emitter<GoodsReceiptAttachmentState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, goodsReceiptAttachmentEntityList: []));
    await Future.delayed(Duration(seconds: 2));
    final failureOrSuccess = await insertCapturedSelectedMediaAttachmentUseCase(
      event.goodsReceiptAttachmentEntityList,
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
            goodsReceiptAttachmentEntityList: success,
            isLoading: false,
          ),
        );
      },
    );
  }
}
