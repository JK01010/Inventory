import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/pending_list_model.dart';
import '../../../domain/failures/bagging_and_tagging_failures.dart';
import '../../../domain/usecase/bagging_pending_serach_usecase.dart';

part 'bagging_pending_search_event.dart';

part 'bagging_pending_search_state.dart';

class BaggingPendingSearchBloc
    extends Bloc<BaggingPendingSearchEvent, BaggingPendingSearchState> {
  BaggingPendingSearchBloc({required this.baggingPendingPoSearchUseCase})
    : super(BaggingTaggingPendingPoSearchInitial()) {
    on<BaggingTaggingPendingNoChangedEvent>((event, emit) async {
      final failureOrSuccess = await baggingPendingPoSearchUseCase(
        query: event.query,
      );

      failureOrSuccess.fold(
        (failure) {
          debugPrint("left ******************");
          emit(
            BaggingTaggingPendingPoSearchError(
              baggingAndTaggingFailures: failure,
            ),
          );
        },
        (baggingPendingPoList) {
          debugPrint("right ******************");
          debugPrint("event.query : ${event.query}");
          emit(
            BaggingTaggingPendingPoSearchLoaded(
              baggingPendingPoList: baggingPendingPoList,
              searchKeyword: event.query,
            ),
          );
        },
      );
    });
  }

  final BaggingPendingSearchUsecase baggingPendingPoSearchUseCase;
}
