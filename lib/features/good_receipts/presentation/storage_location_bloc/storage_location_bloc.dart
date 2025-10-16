import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../common_feature/domain/entities/storage_location_entity.dart';
import '../../../common_feature/domain/usecase/insert_storage_location_usecase.dart';
import '../../domain/failures/goods_receipts_failures.dart';
import '../../domain/use_cases/get_storage_location_by_parent_id_usecase.dart';

part 'storage_location_event.dart';
part 'storage_location_state.dart';

class StorageLocationBloc
    extends Bloc<StorageLocationEvent, StorageLocationState> {
  StorageLocationBloc({
    required this.insertStorageLocationUseCase,
    required this.getStorageLocationByParentIdUseCase,
  }) : super(StorageLocationState.initial()) {
    on<StorageLocationEvent>((event, emit) async {
      switch (event) {
        case InsertStorageLocationEvent():
          insertStorageLocationEvent();
          break;
        case FetchStorageLocationByParentIdEvent():
          await getStorageLocationByParentId(
            event.parentId,
            event.storageLocationEntity,
            emit,
          );
          break;
        case ResetStorageLocationEvent():
          await resetStorageLocation(emit);
          break;
        case NavigateToStorageLocationEvent():
          await navigateToSelectedStorageLocationInBreadCrumb(event, emit);
        case StorageLocationListSearchEvent():
          await storageLocationListSearch(event, emit);
      }
    });
  }

  GetStorageLocationByParentIdUseCase getStorageLocationByParentIdUseCase;
  InsertStorageLocationUseCase insertStorageLocationUseCase;

  Future<void> navigateToSelectedStorageLocationInBreadCrumb(
    NavigateToStorageLocationEvent event,
    Emitter<StorageLocationState> emit,
  ) async {
    int pickedLocation = state.breadCrumbEntityList.indexWhere(
      (item) => item == event.selectedBreadCrumbLocation,
    );

    if (pickedLocation != -1) {
      emit(state.copyWith(isLoading: true));
      state.breadCrumbEntityList.removeRange(
        pickedLocation,
        state.breadCrumbEntityList.length,
      );
      emit(
        state.copyWith(
          isLoading: false,
          storageLocationEntity: event.selectedBreadCrumbLocation,
          breadCrumbEntityList: state.breadCrumbEntityList,
        ),
      );

      add(
        FetchStorageLocationByParentIdEvent(
          event.selectedBreadCrumbLocation.id,
          event.selectedBreadCrumbLocation,
        ),
      );
    }
  }

  Future<void> getStorageLocationByParentId(
    int parentId,
    StorageLocationEntity? storageLocationEntity,
    Emitter<StorageLocationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    if (storageLocationEntity != null) {
      state.breadCrumbEntityList.add(storageLocationEntity);
    }

    final failureOrSuccess = await getStorageLocationByParentIdUseCase
        .getStorageLocationByParentId(parentId);
    failureOrSuccess.fold(
      (failure) {
        state.breadCrumbEntityList.removeLast();
        emit(
          state.copyWith(
            isLoading: false,
            goodsReceiptsFailure: some(
              GoodsReceiptsUnknownFailure(
                code: failure.code,
                message: failure.message,
              ),
            ),
          ),
        );
      },
      (success) {
        if (success.isNotEmpty) {
          emit(
            state.copyWith(
              isLoading: false,
              storageLocationEntity: storageLocationEntity,
              storageLocationEntityList: success, // todo storageLocationListEntity filter where prdId = -1
              storageLocationViewListEntity: success,
              breadCrumbEntityList: state.breadCrumbEntityList,
            ),
          );
        } else {
          state.breadCrumbEntityList.removeLast();
          emit(
            state.copyWith(
              isLoading: false,
              storageLocationEntity: storageLocationEntity,
              breadCrumbEntityList: state.breadCrumbEntityList,
            ),
          );
        }
      },
    );
  }

  Future<void> resetStorageLocation(Emitter<StorageLocationState> emit) async {
    emit(StorageLocationState.initial());
  }

  Future<void> insertStorageLocationEvent() async {
    await insertStorageLocationUseCase.call();
  }


  //Storage location
    Future<void> storageLocationListSearch(
      StorageLocationListSearchEvent event,
      Emitter<StorageLocationState> emit,
      ) async {

    final List<StorageLocationEntity> updatedList;
    if(event.searchText != ""){
      updatedList = state.storageLocationEntityList
          .where((e) => e.code.toLowerCase().contains(
          event.searchText.toLowerCase()),
      ).toList();

    }else{
      updatedList = state.storageLocationEntityList
          // .where((element) => element.parentId == 0)
          .toList();
    }
    emit(state.copyWith(storageLocationViewListEntity: updatedList));

  }

}

