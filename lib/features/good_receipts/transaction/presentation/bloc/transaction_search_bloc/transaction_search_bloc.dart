import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/transaction_filter_entity.dart';
import '../../../domain/entity/transaction_entity.dart';
import '../../../domain/failure/transaction_failures.dart';
import '../../../domain/usecase/get_all_transaction_from_db_usecase.dart';

part 'transaction_search_event.dart';

part 'transaction_search_state.dart';

class TransactionSearchBloc
    extends Bloc<TransactionSearchEvent, TransactionSearchState> {
  TransactionSearchBloc({required this.getAllTransactionFromDbUsecase})
    : super(TransactionSearchInitial()) {
    on<TransactionOnChangedEvent>((event, emit) async {
      final TransactionFilterEntity transactionFilterEntity =
          TransactionFilterEntity(poNumberOrTitle: event.query);
      final failureOrSuccess = await getAllTransactionFromDbUsecase(
        transactionFilterEntity: transactionFilterEntity,
      );

      failureOrSuccess.fold(
        (failure) {
          emit(TransactionSearchError(transactionFailures: failure));
        },
        (transaction) {
          emit(TransactionSearchLoaded(transactionList: transaction));
        },
      );
    });
  }
  final GetAllTransactionFromDbUsecase getAllTransactionFromDbUsecase;
}
