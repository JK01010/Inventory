import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../good_receipts/domain/entities/split_location_entity.dart';
import '../../../domain/entities/bagging_item_details_entity.dart';
import '../../../domain/entities/bagging_purchase_details_entity.dart';
import '../../../domain/failures/bagging_and_tagging_failures.dart';
import '../../../domain/usecase/get_all_bagging_item_details_usecase.dart';
import '../../../domain/usecase/insert_bagging_tagging_item_details_usecase.dart';

part 'bagging_item_details_event.dart';

part 'bagging_item_details_state.dart';

class BaggingItemDetailsBloc
    extends Bloc<BaggingItemDetailsEvent, BaggingItemDetailsState> {
  BaggingItemDetailsBloc({
    required this.insertBaggingTaggingItemDetailsUsecase,
    required this.getItemSplitLocationDataUseCase,
  }) : super(BaggingItemDetailsState.initial()) {
    on<BaggingItemDetailsEvent>((event, emit) async {
      switch (event) {
        case BaggingItemDetailsInsertDataEvent():
          await insertBaggingTaggingItemDetails(event, emit);

        case BaggingItemDetailsGetAllDataEvent():
          await getAllBaggingTaggingItemDetails(event, emit);
      }
    });
  }

  final InsertBaggingTaggingItemDetailsUsecase
  insertBaggingTaggingItemDetailsUsecase;
  final GetItemSplitLocationDataUseCase getItemSplitLocationDataUseCase;

  Future<void> insertBaggingTaggingItemDetails(
    BaggingItemDetailsInsertDataEvent event,
    Emitter<BaggingItemDetailsState> emit,
  ) async {
    // await insertBaggingTaggingItemDetailsUsecase();
  }

  Future<void> getAllBaggingTaggingItemDetails(
    BaggingItemDetailsGetAllDataEvent event,
    Emitter<BaggingItemDetailsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, splitLocationEntity: []));
    final failureOrSuccess = await getItemSplitLocationDataUseCase(
      getSplitLocationDataParams: GetItemSplitLocationDataParams(
        grnId: event.grnId,
        grnDtId: event.grnDtId,
      ),
    );
    failureOrSuccess.fold(
      (failure) {
        debugPrint("inside the failure ****************");
        // emit(
        //   state.copyWith(
        //     baggingAndTaggingFailures: some(failure),
        //     isLoading: false,
        //   ),
        // );
      },
      (success) {
        debugPrint("inside the success splitLocationEntity : $success");
        emit(state.copyWith(splitLocationEntity: success, isLoading: false));
      },
    );
  }
}
