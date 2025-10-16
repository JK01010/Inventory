import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../domin/entities/item_master_rfid_view_entity_model.dart';
import '../../../domin/failures/item_master_failures.dart';
import '../../../domin/usecases/item_master_rfid_listing_insert_use_case.dart';
import '../../../domin/usecases/item_master_rfid_view_fetch_use_case.dart';

part 'rfid_view_event.dart';
part 'rfid_view_state.dart';

class RfidViewBloc extends Bloc<RfidViewEvent, RfidViewState> {

  RfidViewBloc({
    required this.itemMasterRfidListingInsertUseCase,
    required this.fetchItemMasterRfidListingUseCase
    }) : super(RfidViewState.initialState()) {
    on<RfidViewEvent>((event, emit) async {
      switch(event){
        case ItemMasterRfidListingInsertEvent():
          await _insertDataToDb(event,emit);
        case ItemMasterRfidListingFetchEvent():
          await _fetchDataFromDb(event,emit);
      }
    });
  }

  final ItemMasterRfidListingInsertUseCase itemMasterRfidListingInsertUseCase;
  final FetchItemMasterRfidListingUseCase fetchItemMasterRfidListingUseCase;

  Future<void> _insertDataToDb(
      RfidViewEvent event,
      Emitter<RfidViewState> emit,
      ) async {
    await itemMasterRfidListingInsertUseCase();
  }

  Future<void> _fetchDataFromDb(
      ItemMasterRfidListingFetchEvent event,
      Emitter<RfidViewState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    final failureOrSuccess = await fetchItemMasterRfidListingUseCase(itemId: event.selectedItemId);
    failureOrSuccess.fold(
          (failure) {
        emit(
          state.copyWith(itemMasterFailures: some(failure), isLoading: false),
        );
      },
          (success) {
        emit(state.copyWith(itemMasterRfidViewEntity: success, isLoading: false));
      },
    );
  }
}
