import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../good_receipts/domain/entities/packet_details_entity.dart';
import '../../../../good_receipts/domain/failures/goods_receipts_failures.dart';
import '../../../../good_receipts/domain/use_cases/get_packet_details_by_po_id_usecase.dart';

part 'bagging_packet_list_event.dart';
part 'bagging_packet_list_state.dart';


class BaggingPacketListBloc
    extends Bloc<BaggingPacketListEvent, BaggingPacketListState> {
  BaggingPacketListBloc({
    required this.fetchPacketDetailsByPoIdUseCase,
  }) : super(BaggingPacketListState.initial()) {
    on<BaggingPacketListEvent>((event, emit) async {
      switch (event) {
        // case BaggingPacketInsertDataEvent():
        //   await baggingPacketInsertDataEvent(event, emit);

        case BaggingPacketFetchAllDataEvent():
          await baggingPacketFetchAllDataEvent(event, emit);
      }
    });
  }

  final GetPacketDetailsByPoIdUseCase fetchPacketDetailsByPoIdUseCase;


  Future<void> baggingPacketFetchAllDataEvent(
      BaggingPacketFetchAllDataEvent event,
      Emitter<BaggingPacketListState> emit,) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    final failureOrSuccess = await fetchPacketDetailsByPoIdUseCase(grnId: event.grnId);
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
          state.copyWith(
            packetDetailsEntity: success,
            isLoading: false,
          ),
        );
      },
    );
  }

}