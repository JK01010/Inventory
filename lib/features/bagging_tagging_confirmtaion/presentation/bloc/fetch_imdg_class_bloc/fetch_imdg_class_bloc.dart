import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../common_feature/domain/entities/fetch_imdg_class_entity.dart';
import '../../../../item_master/domin/failures/item_master_failures.dart';

part 'fetch_imdg_class_event.dart';
part 'fetch_imdg_class_state.dart';

class FetchImdgClassBloc
    extends Bloc<FetchImdgClassEvent, FetchImdgClassState> {
  FetchImdgClassBloc() : super(FetchImdgClassState.initial()) {
    on<FetchImdgClassEvent>((event, emit) async {
      switch (event) {
        case ImdgClassEventInsertDataEvent():
          await imdgClassEventInsertDataEvent(event, emit);
        case ImdgClassEventGetAllDataEvent():
          await imdgClassEventGetAllDataEvent(event, emit);
      }
    });
  }


  Future<void> imdgClassEventInsertDataEvent(
    FetchImdgClassEvent event,
    Emitter<FetchImdgClassState> emit,
  ) async {
    // await insertImdgClassUsecase();
  }

  Future<void> imdgClassEventGetAllDataEvent(
    FetchImdgClassEvent event,
    Emitter<FetchImdgClassState> emit,
  ) async {
    // emit(state.copyWith(isLoading: true));
    // await Future.delayed(Duration(seconds: 1));
    // final failureOrSuccess = await fetchImdgClassUsecase();
    // failureOrSuccess.fold(
    //   (failure) {
    //     emit(
    //       state.copyWith(
    //         failureOption: some(
    //           ImdgClassEventGetAllDataFailure(code: "", message: ""),
    //         ),
    //         isLoading: false,
    //       ),
    //     );
    //   },
    //   (success) {
    //     emit(state.copyWith(fetchImdgClassList: success, isLoading: false));
    //   },
    // );
  }
}
