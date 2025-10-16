import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_split_location_data_transaction_item_usecase.dart';
import 'transaction_item_detail_bloc_event.dart';
import 'transaction_item_detail_bloc_state.dart';

class TransactionItemDetailBloc
    extends
        Bloc<TransactionItemDetailBlocEvent, TransactionItemDetailBlocState> {
  TransactionItemDetailBloc({
    required this.getSplitLocationDatForTransactionItemUseCase,
  }) : super(TransactionItemDetailBlocState.initial()) {
    on<TransactionItemDetailBlocEvent>((event, emit) async {
      switch (event) {
        case SetTransactionItemDetailInitialDataEvent():
          await onSetInitialDataEvent(event, emit);
          break;
        case GenerateSerialNumbersEvent():
          await onGenerateSerialNumbersEvent(event, emit);
          break;
      }
    });
  }

  final GetSplitLocationDatForTransactionItemUseCase
  getSplitLocationDatForTransactionItemUseCase;

  Future<void> onSetInitialDataEvent(
    SetTransactionItemDetailInitialDataEvent event,
    Emitter<TransactionItemDetailBlocState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final splitLocationResult =
        await getSplitLocationDatForTransactionItemUseCase(
          getSplitLocationDataTransactionItemParams:
              GetSplitLocationDataTransactionItemParams(
                grnId: event.transactionEntity.grnId,
                grnDtId: event.itemEntity.grnDtId,
              ),
        );
    final splitLocationList = splitLocationResult.getRight().toNullable() ?? [];
    emit(
      state.copyWith(
        isLoading: false,
        itemEntity: event.itemEntity,
        transactionEntity: event.transactionEntity,
        splitLocationEntity: splitLocationList,
      ),
    );
  }

  Future<void> onGenerateSerialNumbersEvent(
    GenerateSerialNumbersEvent event,
    Emitter<TransactionItemDetailBlocState> emit,
  ) async {
    // emit(state.copyWith())
    // // final serialNumbersResult = await generateSerialNumbersUseCase(
    //  // generateSerialNumberParams: GenerateSerialNumberParams(
    //  //   quantity: event.quantity,
    //  //   id: state.,
    //  //   itemId: event.itemId,
    //  //
    //  // )
    // );
  }
}
