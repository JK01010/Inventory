import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/bagging_confirmation_list_entity.dart';
import '../../../domain/failures/bagging_and_tagging_failures.dart';
import '../../../domain/usecase/bagging_confirmation_serach_usecase.dart';

part 'bagging_confirmation_search_event.dart';

part 'bagging_confirmation_search_state.dart';

class BaggingConfirmationSearchBloc
    extends
        Bloc<BaggingConfirmationSearchEvent, BaggingConfirmationSearchState> {
  BaggingConfirmationSearchBloc({
    required this.baggingConfirmationPoSearchUseCase,
  }) : super(BaggingTaggingConfirmationPoSearchInitial()) {
    on<BaggingTaggingConfirmationNoChangedEvent>((event, emit) async {
      final failureOrSuccess = await baggingConfirmationPoSearchUseCase(
        query: event.query,
      );

      failureOrSuccess.fold(
        (failure) {
          emit(
            BaggingTaggingConfirmationPoSearchError(
              baggingAndTaggingFailures: failure,
            ),
          );
        },
        (baggingConfirmationPoList) {
          emit(
            BaggingTaggingConfirmationPoSearchLoaded(
              baggingConfirmationPoList: baggingConfirmationPoList,
              searchKeyword: event.query,
            ),
          );
        },
      );
    });
  }

  final BaggingConfirmationSearchUsecase baggingConfirmationPoSearchUseCase;
}
