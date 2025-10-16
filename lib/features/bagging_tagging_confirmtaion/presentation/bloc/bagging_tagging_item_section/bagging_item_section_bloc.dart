import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../common_feature/domain/entities/item_section_entity.dart';
import '../../../../common_feature/domain/usecase/item_section_fetch_usecase.dart';
import '../../../../common_feature/domain/usecase/item_section_insert_usecase.dart';
import '../../../../item_master/domin/failures/item_master_failures.dart';

part 'bagging_item_section_event.dart';
part 'bagging_item_section_state.dart';

class BaggingItemSectionBloc
    extends Bloc<BaggingItemSectionEvent, BaggingItemSectionState> {
  BaggingItemSectionBloc({
    required this.itemSectionInsertUsecase,
    required this.itemSectionFetchUsecase,
  }) : super(BaggingItemSectionState.initial()) {
    on<BaggingItemSectionEvent>((event, emit) async {
      switch (event) {
        case ItemSectionInsertDataEvent():
          await itemSectionInsertDataEvent(event, emit);

        case ItemSectionFetchAllDataEvent():
          await itemSectionFetchAllDataEvent(event, emit);
      }
    });
  }

  final ItemSectionInsertUsecase itemSectionInsertUsecase;
  final ItemSectionFetchUsecase itemSectionFetchUsecase;

  Future<void> itemSectionInsertDataEvent(
    ItemSectionInsertDataEvent event,
    Emitter<BaggingItemSectionState> emit,
  ) async {
    await itemSectionInsertUsecase();
  }

  Future<void> itemSectionFetchAllDataEvent(
    ItemSectionFetchAllDataEvent event,
    Emitter<BaggingItemSectionState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    final failureOrSuccess = await itemSectionFetchUsecase();
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(
            itemMasterFailures: some(
              ItemSectionFetchAllDataFailure(code: "", message: ""),
            ),
            isLoading: false,
          ),
        );
      },
      (success) {
        emit(state.copyWith(itemSectionEntity: success, isLoading: false));
      },
    );
  }
}
