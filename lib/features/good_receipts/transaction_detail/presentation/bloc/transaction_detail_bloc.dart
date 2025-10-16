import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_transaction_items_db_usecase.dart';
import 'transaction_detail_bloc_event.dart';
import 'transaction_detail_bloc_state.dart';

class TransactionDetailBloc
    extends Bloc<TransactionDetailBlocEvent, TransactionDetailBlocState> {
  TransactionDetailBloc({required this.getTransactionItemsDbUseCase})
    : super(TransactionDetailBlocState.initial()) {
    on<GetTransactionItemsEvent>((event, emit) async {
      switch (event) {
        case GetTransactionItemsEvent():
          await onGetTransactionItemsEvent(event, emit);
      }
    });
  }

  final GetTransactionItemsDbUseCase getTransactionItemsDbUseCase;

  Future<void> onGetTransactionItemsEvent(
    GetTransactionItemsEvent event,
    Emitter<TransactionDetailBlocState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        transactionEntity: event.transactionEntity,
      ),
    );
    final transactionItemResult = await getTransactionItemsDbUseCase(
      params: GetTransactionItemsParams(grnId: event.transactionEntity.grnId),
    );

    transactionItemResult.fold(
      (failure) {
        emit(state.copyWith(isLoading: false));
      },
      (success) {
        emit(state.copyWith(transactionItems: success, isLoading: false));
      },
    );
  }
}
