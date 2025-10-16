import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../core/utils/app_logger.dart';
import '../../../../good_receipts/domain/entities/stock_location_entity.dart';
import '../../../../good_receipts/domain/failures/goods_receipts_failures.dart';
import '../../../../good_receipts/domain/use_cases/update_stock_location_by_item_id_use_case.dart';

part 'stock_location_event.dart';
part 'stock_location_state.dart';

class StockLocationBloc extends Bloc<StockLocationEvent, StockLocationState> {
  StockLocationBloc({required this.updateStockLocationByItemIdUseCase})
    : super(StockLocationState.initial()) {
    on<StockLocationEvent>((event, emit) async {
      switch (event) {
        case UpdateStockLocationByItemIdEvent():
          await updateStockLocationByItemId(event, emit);
          break;
      }
    });
  }

  final UpdateStockLocationByItemIdUseCase updateStockLocationByItemIdUseCase;

  Future<void> updateStockLocationByItemId(
    UpdateStockLocationByItemIdEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 2));
    final failureOrSuccess = await updateStockLocationByItemIdUseCase.call(
      event.itemId,
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
    
        emit(state.copyWith(isLoading: false));
      },
    );
  }
}
