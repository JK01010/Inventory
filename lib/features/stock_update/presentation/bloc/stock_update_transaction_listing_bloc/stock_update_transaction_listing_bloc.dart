import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../consumption/domin/usecases/search_consumption_transaction_usecase.dart';
import '../../../domin/entities/stock_update_view_entity_model.dart';
import '../../../domin/failures/stock_update_failures.dart';
import '../../../domin/usecases/stock_update_fetch_data_view_usecase.dart';
import '../../../domin/usecases/stock_update_fetch_filter_date_view_usecase.dart';
import '../../../domin/usecases/stock_update_fetch_search_data_view_usecase.dart';
import '../../../domin/usecases/stock_update_table_insert_usecase.dart';

part 'stock_update_transaction_listing_event.dart';

part 'stock_update_transaction_listing_state.dart';

class StockUpdateTransactionListingBloc
    extends
        Bloc<
          StockUpdateTransactionListingEvent,
          StockUpdateTransactionListingState
        > {
  StockUpdateTransactionListingBloc({
    required this.stockUpdateInsertUseCase,
    required this.stockUpdateFetchDataViewUseCase,
    required this.stockUpdateFetchFilterDataViewUseCase,
    required this.stockUpdateFetchSearchDataViewUseCase,
  }) : super(StockUpdateTransactionListingState.initialSetup()) {
    on<StockUpdateTransactionListingEvent>((event, emit) async {
      switch (event) {
        case StockUpdateTransactionListingInsertEvent():
          await _insertDataToDb(event, emit);
        case StockUpdateTransactionListingFetchViewEvent():
          await _fetchViewDataFromDb(event, emit);
        case StockUpdateFilterFetchDataEvent():
          await _fetchFilterViewDataFromDb(event, emit);
        case StockUpdateSearchEvent():
          await _itemSearchFromDb(event, emit);
      }
    });
  }

  final StockUpdateInsertUseCase stockUpdateInsertUseCase;
  final StockUpdateFetchDataViewUseCase stockUpdateFetchDataViewUseCase;
  final StockUpdateFetchFilterDataViewUseCase
  stockUpdateFetchFilterDataViewUseCase;
  final StockUpdateFetchSearchDataViewUseCase
  stockUpdateFetchSearchDataViewUseCase;

  Future<void> _insertDataToDb(
    StockUpdateTransactionListingEvent event,
    Emitter<StockUpdateTransactionListingState> emit,
  ) async {
    await stockUpdateInsertUseCase();
  }

  Future<void> _fetchViewDataFromDb(
    StockUpdateTransactionListingFetchViewEvent event,
    Emitter<StockUpdateTransactionListingState> emit,
  ) async {
    emit(StockUpdateTransactionListingState.initialSetup());
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    final failureOrSuccess = await stockUpdateFetchDataViewUseCase(offSet: 0);
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(isLoading: false, stockUpdateFailures: some(failure)),
        );
      },
      (success) {
        emit(
          state.copyWith(
            isLoading: false,
            isFilterActive: false,
            stockUpdateViewList: success,
          ),
        );
      },
    );
  }

  Future<void> _fetchFilterViewDataFromDb(
    StockUpdateFilterFetchDataEvent event,
    Emitter<StockUpdateTransactionListingState> emit,
  ) async {
    // emit(StockUpdateTransactionListingState.initialSetup());
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    final failureOrSuccess = await stockUpdateFetchFilterDataViewUseCase(
      articleNo: event.articleNo,
      itemName: event.itemName,
    );
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(isLoading: false, stockUpdateFailures: some(failure)),
        );
      },
      (success) {
        emit(
          state.copyWith(
            isLoading: false,
            isFilterActive: true,
            stockUpdateViewList: success,
          ),
        );
      },
    );
  }

  Future<void> _itemSearchFromDb(
    StockUpdateSearchEvent event,
    Emitter<StockUpdateTransactionListingState> emit,
  ) async {
    //checking the event is from search or onBack and searching the data isNotEmpty
    if (event.isSearch && event.searchText.trim().isNotEmpty) {
      final failureOrSuccess = await stockUpdateFetchSearchDataViewUseCase(
        searchText: event.searchText,
      );
      failureOrSuccess.fold(
        (failure) {
          emit(state.copyWith(stockUpdateFailures: some(failure)));
        },
        (success) {
          emit(state.copyWith(stockUpdateSearchList: success));
        },
      );
    } else {
      emit(state.copyWith(stockUpdateSearchList: []));
    }
  }
}
