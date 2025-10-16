import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../domain/entities/dropdown_model.dart';
import '../../../domain/entities/pending_list_model.dart';

import '../../../domain/failures/bagging_and_tagging_failures.dart';
import '../../../domain/usecase/get_pending_list_usecase.dart';
import '../../../domain/usecase/insert_pendin_list_usecase.dart';

part 'bagging_tagging_list_event.dart';
part 'bagging_tagging_list_state.dart';

class BaggingTaggingListBloc extends Bloc<BaggingTaggingListEvent, BaggingTaggingListState> {
  BaggingTaggingListBloc({
    required this.getUseCase,
    required this.insertUseCase,
  }) : super(BaggingTaggingListState.initial()) {
    on<BaggingTaggingListInsertDataEvent>(_onInsertData);
    on<BaggingTaggingListGetAllDataEvent>(_onGetAllData);
  }

  final GetBaggingTaggingPendingListUseCase getUseCase;
  final InsertBaggingTaggingPendingListUseCase insertUseCase;

  Future<void> _onInsertData(
      BaggingTaggingListInsertDataEvent event,
      Emitter<BaggingTaggingListState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, failureOption: none()));

    final result = await insertUseCase();

    result.fold(
          (failure) => emit(state.copyWith(
        isLoading: false,
        failureOption: some(failure),
      )),
          (_) => add(BaggingTaggingListGetAllDataEvent()),
    );
  }

  Future<void> _onGetAllData(
      BaggingTaggingListGetAllDataEvent event,
      Emitter<BaggingTaggingListState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, failureOption: none()));

    final result = await getUseCase();

    result.fold(
          (failure) => emit(state.copyWith(
        isLoading: false,
        failureOption: some(failure),
      )),
          (list) => emit(state.copyWith(
        isLoading: false,
        baggingTaggingList: list,
      )),
    );
  }

  Future<List<DropDownModel>> getSuggestions(String pattern) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate delay
    final allSuggestions = [
      DropDownModel(title: 'New York', id: 1),
      DropDownModel(title: 'Los Angeles', id: 2),
      DropDownModel(title: 'Dubai', id: 3),
      DropDownModel(title: 'Shanghai', id: 4),
    ];
    return allSuggestions
        .where((e) =>
        e.title.toLowerCase().contains(pattern.toLowerCase()))
        .toList();
  }
}





