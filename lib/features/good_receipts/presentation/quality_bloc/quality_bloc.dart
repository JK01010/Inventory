import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../common_feature/domain/entities/quality_entity.dart';
import '../../../common_feature/domain/failures/common_failures.dart';
import '../../purchase_order_item_detail/domain/use_cases/get_quality_list_db_usecase.dart';

part 'quality_event.dart';

part 'quality_state.dart';

class QualityBloc extends Bloc<QualityEvent, QualityState> {
  QualityBloc({required this.getQualityListDbUseCase})
    : super(QualityState.initial()) {
    on<QualityEvent>((event, emit) async {
      switch (event) {
        case FetchAllQualityListEvent():
          await fetchAllQualityList(event, emit);
      }
    });
  }

  GetQualityListDbUseCase getQualityListDbUseCase;

  Future<void> fetchAllQualityList(
    QualityEvent event,
    Emitter<QualityState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    final failureOrSuccess = await getQualityListDbUseCase();
    failureOrSuccess.fold((failure) {}, (success) {
      emit(state.copyWith(fetchQualityList: success, isLoading: false));
    });
  }
}
