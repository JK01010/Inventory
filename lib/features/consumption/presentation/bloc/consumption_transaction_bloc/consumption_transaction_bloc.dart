import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';


import '../../../domin/entities/con_transaction_view_entity_model.dart';
import '../../../domin/failures/consumption_failures.dart';
import '../../../domin/usecases/fetch_all_consumption_transaction_header_usecase.dart';
import '../../../domin/usecases/fetch_filter_consumption_transaction_usecase.dart';
import '../../../domin/usecases/insert_consumption_transaction_list_usecase.dart';
import '../../../domin/usecases/search_consumption_transaction_usecase.dart';
import 'consumption_transaction_event.dart';

part 'consumption_transaction_state.dart';

class ConsumptionTransactionBloc
    extends Bloc<ConsumptionTransactionEvent, ConsumptionTransactionState> {
  ConsumptionTransactionBloc({
    required this.insertConsumptionTransactionUseCase,
    required this.fetchAllConsumptionTransactionUseCase,
    required this.fetchConsumptionTransactionFilterUseCase,
    required this.searchConsumptionTransactionHeaderUseCase,
  }) : super(ConsumptionTransactionState.initial()) {
    on<ConsumptionTransactionEvent>((event, emit) async {
      switch (event) {
        case ConsumptionTransactionInsertDataEvent():
          await _consumptionTransactionInsertData(event, emit);
        case ConsumptionTransactionFetchDataEvent():
          await _getAllConsumptionTransactionList(event, emit);
        case ConsumptionTransactionFilterEvent():
          await _applyFilter(event,emit);
        case ConsumptionTransactionSearchEvent():
          await _itemSearchFromDb(event,emit);
      }
    });
  }

  ///useCause
  final InsertConsumptionTransactionUseCase insertConsumptionTransactionUseCase;
  final FetchAllConsumptionTransactionUseCase fetchAllConsumptionTransactionUseCase;
  final FetchConsumptionTransactionFilterUseCase fetchConsumptionTransactionFilterUseCase;
  final SearchConsumptionTransactionUseCase searchConsumptionTransactionHeaderUseCase;

  ///insertDataIntoDb
  Future<void> _consumptionTransactionInsertData(
    ConsumptionTransactionInsertDataEvent event,
    Emitter<ConsumptionTransactionState> emit,
  ) async {
    await insertConsumptionTransactionUseCase();
    // await fetchAllConsumptionTransactionUseCase();
  }

  ///fetchDataFromDb
  Future<void> _getAllConsumptionTransactionList(
    ConsumptionTransactionFetchDataEvent event,
    Emitter<ConsumptionTransactionState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    final failureOrSuccess = await fetchAllConsumptionTransactionUseCase();
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(consumptionFailures: some(failure), isLoading: false),
        );
      },
      (success) {
        emit(state.copyWith(transactionList: success, isLoading: false ,isFilterActive :false));
      },
    );
  }

  ///filter
  Future<void> _applyFilter(
    ConsumptionTransactionFilterEvent event,
    Emitter<ConsumptionTransactionState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    final failureOrSuccess = await fetchConsumptionTransactionFilterUseCase(event.itemName,event.articleNo);
    failureOrSuccess.fold(
          (failure) {
        emit(
          state.copyWith(consumptionFailures: some(failure), isLoading: false),
        );
      },
          (success) {
        emit(state.copyWith(transactionList: success, isLoading: false, isFilterActive: true));
      },
    );
  }

  //search
  Future<void> _itemSearchFromDb(
      ConsumptionTransactionSearchEvent event,
      Emitter<ConsumptionTransactionState> emit,
      ) async {
    //checking the event is from search or onBack and searching the data isNotEmpty
    if(event.isSearch && event.searchText.trim().isNotEmpty) {
      final failureOrSuccess = await searchConsumptionTransactionHeaderUseCase(
          searchText: event.searchText);
      failureOrSuccess.fold(
            (failure) {
          emit(
            state.copyWith(consumptionFailures: some(failure)),
          );
        },
            (success) {
          emit(state.copyWith(searchTransactionList: success));
        },
      );
    }else{
      emit(state.copyWith(searchTransactionList: []));
    }
  }


}
