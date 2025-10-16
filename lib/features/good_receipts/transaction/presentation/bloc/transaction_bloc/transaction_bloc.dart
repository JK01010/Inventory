import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../domain/entities/transaction_filter_entity.dart';
import '../../../domain/entity/transaction_entity.dart';
import '../../../domain/failure/transaction_failures.dart';
import '../../../domain/usecase/get_all_transaction_from_db_usecase.dart';

part 'transaction_event.dart';

part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc({required this.getAllTransactionFromDbUsecase})
    : super(TransactionState.initial()) {
    on<TransactionEvent>((event, emit) async {
      switch (event) {
        case GetAllTransactionFromDb():
          await _getAllTransactionFromDb(event, emit);
      }
    });
  }

  final GetAllTransactionFromDbUsecase getAllTransactionFromDbUsecase;

  Future<void> _getAllTransactionFromDb(
    GetAllTransactionFromDb event,
    Emitter<TransactionState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final Either<TransactionFailures, List<TransactionEntity>>
    failureOrSuccess = await getAllTransactionFromDbUsecase(
      transactionFilterEntity: event.transactionFilterEntity,
    );

    failureOrSuccess.fold(
      (failure) {
        emit(state.copyWith(isLoading: false));
      },
      (transactionEntityList) {
        emit(
          state.copyWith(
            transactionEntityList: transactionEntityList.reversed.toList(),
            isLoading: false,
          ),
        );
      },
    );
  }
}
