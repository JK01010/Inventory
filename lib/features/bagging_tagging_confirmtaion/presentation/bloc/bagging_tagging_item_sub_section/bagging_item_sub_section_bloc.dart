import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../common_feature/domain/entities/item_sub_section_entity.dart';
import '../../../../common_feature/domain/usecase/item_sub_section_fetch_usecase.dart';
import '../../../../common_feature/domain/usecase/item_sub_section_insert_usecase.dart';
import '../../../../item_master/domin/failures/item_master_failures.dart';

part 'bagging_item_sub_section_event.dart';
part 'bagging_item_sub_section_state.dart';

class BaggingItemSubSectionBloc
    extends Bloc<BaggingItemSubSectionEvent, BaggingItemSubSectionState> {
  BaggingItemSubSectionBloc({
    required this.itemSubSectionInsertUsecase,
    required this.itemSubSectionFetchUsecase,
  }) : super(BaggingItemSubSectionState.initial()) {
    on<BaggingItemSubSectionEvent>((event, emit) async {
      switch (event) {
        case ItemSubSectionInsertDataEvent():
          await itemSubSectionInsertDataEvent(event, emit);

        case ItemSubSectionFetchAllDataEvent():
          await itemSubSectionFetchAllDataEvent(event, emit);
      }
    });
  }

  final ItemSubSectionInsertUsecase itemSubSectionInsertUsecase;
  final ItemSubSectionFetchUsecase itemSubSectionFetchUsecase;

  Future<void> itemSubSectionInsertDataEvent(
    ItemSubSectionInsertDataEvent event,
    Emitter<BaggingItemSubSectionState> emit,
  ) async {
    await itemSubSectionInsertUsecase();
  }

  Future<void> itemSubSectionFetchAllDataEvent(
    ItemSubSectionFetchAllDataEvent event,
    Emitter<BaggingItemSubSectionState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    final failureOrSuccess = await itemSubSectionFetchUsecase();
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(
            itemMasterFailures: some(
              ItemSubSectionFetchAllDataFailure(code: "", message: ""),
            ),
            isLoading: false,
          ),
        );
      },
      (success) {
        emit(state.copyWith(itemSubSectionEntity: success, isLoading: false));
      },
    );
  }
}
