import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import '../../../domin/entities/consumption_location_entity.dart';
import '../../../domin/failures/consumption_failures.dart';
import '../../../domin/usecases/fetch_all_consuption_location_usecase.dart';
import '../../../domin/usecases/insert_consumption_location_list_usecase.dart';

part 'consumption_location_event.dart';

part 'consumption_location_state.dart';

class ConsumptionLocationBloc
    extends Bloc<ConsumptionLocationEvent, ConsumptionLocationState> {
  ConsumptionLocationBloc({
    required this.insertConsumptionLocationListUseCase,
    required this.fetchAllConsumptionLocationUseCase,
  }) : super(ConsumptionLocationState.initial()) {
    on<ConsumptionLocationEvent>((event, emit) async {
      switch (event) {
        case InsertLocationDataEvent():
          await insertLocationDataEvent(event, emit);

        case FetchAllLocationDataEvent():
          await fetchAllLocationDataEvent(event, emit);
      }
    });
  }

  final InsertConsumptionLocationListUseCase insertConsumptionLocationListUseCase;
  final FetchAllConsumptionLocationUseCase fetchAllConsumptionLocationUseCase;

  Future<void> insertLocationDataEvent(
    ConsumptionLocationEvent event,
    Emitter<ConsumptionLocationState> emit,
  ) async {
    await insertConsumptionLocationListUseCase();
  }

  Future<void> fetchAllLocationDataEvent(
    ConsumptionLocationEvent event,
    Emitter<ConsumptionLocationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    final failureOrSuccess = await fetchAllConsumptionLocationUseCase();
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(consumptionFailures: some(failure), isLoading: false),
        );
      },
      (success) {
        emit(
          state.copyWith(consumptionLocationEntity: success, isLoading: false),
        );
      },
    );
  }
}
