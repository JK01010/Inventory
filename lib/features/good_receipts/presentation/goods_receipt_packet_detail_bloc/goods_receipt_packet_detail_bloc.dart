import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/app_logger.dart';
import '../../domain/entities/packet_details_entity.dart';
import '../../domain/failures/goods_receipts_failures.dart';
import '../../domain/use_cases/get_all_packet_details_for_gr_by_po_id_usecase.dart';
import '../../domain/use_cases/goods_receipt_save_packet_detail_usecase.dart';

part 'goods_receipt_packet_detail_event.dart';
part 'goods_receipt_packet_detail_state.dart';

class GoodsReceiptPacketDetailBloc
    extends Bloc<GoodsReceiptPacketDetailEvent, GoodsReceiptPacketDetailState> {
  GoodsReceiptPacketDetailBloc({
    required this.getAllPacketDetailsForGrByPoIdUseCase,
    required this.goodsReceiptSavePacketDetailUseCase,
  }) : super(GoodsReceiptPacketDetailState.initial()) {
    on<GoodsReceiptPacketDetailEvent>((event, emit) async {
      switch (event) {
        case GoodsReceiptFetchPacketsByPoIdEvent():
          await getAllPacketDetailsForGrByPoId(event, emit);
        case GoodsReceiptAddEmptyPacketEvent():
          await insertEmptyPacketTemplate(emit);
        case SavePacketListEvent():
          await saveNewlyAddedPacketList(event, emit);
      }
    });
  }

  final GetAllPacketDetailsForGrByPoIdUseCase
  getAllPacketDetailsForGrByPoIdUseCase;
  final GoodsReceiptSavePacketDetailUseCase goodsReceiptSavePacketDetailUseCase;

  Future<void> getAllPacketDetailsForGrByPoId(
    GoodsReceiptFetchPacketsByPoIdEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final failureOrSuccess = await getAllPacketDetailsForGrByPoIdUseCase(
      grnId: event.poId,
    );
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(
            goodsReceiptsFailures: some(failure),
            isLoading: false,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(packetDetailsEntityList: success, isLoading: false),
        );
      },
    );
  }

  Future<void> insertEmptyPacketTemplate(Emitter emit) async {
    List<PacketDetailsEntity> tempPacketList =
        state.packetDetailsEntityList..add(
          PacketDetailsEntity(
            id: DateTime.now().millisecondsSinceEpoch,
            poId: '',
            poDtId: 0,
            width: 0,
            length: 0,
            height: 0,
            weight: 0,
            actualVolume: 0,
            packetName: '',
          ),
        );
    emit(
      state.copyWith(isLoading: false, packetDetailsEntityList: tempPacketList),
    );
  }

  Future<void> saveNewlyAddedPacketList(
    SavePacketListEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final failureOrSuccess = await goodsReceiptSavePacketDetailUseCase
        .goodsReceiptSavePacketDetail(event.packetDetailsEntityList);
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(
            goodsReceiptsFailures: some(failure),
            isLoading: false,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(packetDetailsEntityList: success, isLoading: false),
        );
      },
    );
  }
}
