import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import '../../../domain/entities/bagging_tagging_purchase_list_view_entity.dart';
import '../../../domain/failures/bagging_and_tagging_failures.dart';
import '../../../domain/usecase/fetch_rfid_listing_view_list_usecase.dart';
import '../../../domain/usecase/get_all_bagging_purchase_list_usecase.dart';
import '../../../domain/usecase/insert_bagging_purchase_list_usecase.dart';

part 'bagging_tagging_purchase_list_event.dart';

part 'bagging_tagging_purchase_list_state.dart';

class BaggingTaggingPurchaseListBloc
    extends
        Bloc<BaggingTaggingPurchaseListEvent, BaggingTaggingPurchaseListState> {
  BaggingTaggingPurchaseListBloc({
    required this.insertPurchaseUseCase,
    required this.getPurchaseUseCase,
    required this.fetchRfidViewUseCase,
  }) : super(BaggingTaggingPurchaseListState.initial()) {
    // Use `on<T>` to register event handlers for specific event types
    on<BaggingTaggingPurchaseListInsertDataEvent>((event, emit) async {
      await insertPurchaseDataList(event, emit);
    });

    on<BaggingTaggingPurchaseListGetAllDataEvent>((event, emit) async {
      await getAllPurchaseDataList(event, emit);
    });

    on<BaggingTaggingRFIDViewEvent>((event, emit) async {
      await rfidView(event, emit);
    });

    on<IsCheckBoxSelectedEvent>(isCheckBoxSelectedEvent);

    on<IsAllItemsSelectEvent>(isAllItemsSelectEvent);

    on<BaggingTaggingPurchaseInitialEvent>(baggingTaggingPurchaseInitalEvent);

    //serial number
    on<BaggingAutoGenerateNumberCheckboxEvent>((event, emit) async {
      await baggingAutoGenerateNumberCheckboxEvent(event, emit);
    });

    on<OnBaggingSerialNoUpdateEvent>((event, emit) async {
      await onBaggingSerialNoUpdateEvent(event, emit);
    });
  }

  final GetAllBaggingPurchaseListUsecase getPurchaseUseCase;
  final InsertBaggingPurchaseListUsecase insertPurchaseUseCase;
  final FetchRfidListingViewListUsecase fetchRfidViewUseCase;

  Future<void> insertPurchaseDataList(
    BaggingTaggingPurchaseListInsertDataEvent event,
    Emitter<BaggingTaggingPurchaseListState> emit,
  ) async {
    await insertPurchaseUseCase();
  }

  Future<void> getAllPurchaseDataList(
    BaggingTaggingPurchaseListGetAllDataEvent event,
    Emitter<BaggingTaggingPurchaseListState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    final failureOrSuccess = await getPurchaseUseCase(poHDId: event.poHDId);
    failureOrSuccess.fold(
      (failure) {
        emit(state.copyWith(failureOption: some(failure), isLoading: false));
      },
      (success) {
        emit(
          state.copyWith(baggingTaggingPurchaseList: success, isLoading: false),
        );
      },
    );
  }

  Future<void> rfidView(
    BaggingTaggingRFIDViewEvent event,
    Emitter<BaggingTaggingPurchaseListState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    final failureOrSuccess = await fetchRfidViewUseCase(itemId: event.itemId);
    failureOrSuccess.fold(
      (failure) {
        emit(state.copyWith(rfidIds: [], isLoading: false));
      },
      (success) {
        emit(state.copyWith(rfidIds: success, isLoading: false));
      },
    );
  }

  Future<void> isCheckBoxSelectedEvent(
    IsCheckBoxSelectedEvent event,
    Emitter<BaggingTaggingPurchaseListState> emit,
  ) async {
    final List<BaggingTaggingPurchaseListViewEntity>
    currentBaggingTaggingPurchaseList = List.from(
      state.baggingTaggingPurchaseList,
    );
    final updatedListItem = currentBaggingTaggingPurchaseList[event.index]
        .copyWith(isSelected: event.isSelectedValue);
    currentBaggingTaggingPurchaseList[event.index] = updatedListItem;
    bool isCompleteSelected = false;
    if (currentBaggingTaggingPurchaseList
        .where((element) => element.isSelected == true)
        .isEmpty) {
      isCompleteSelected = false;
    } else {
      isCompleteSelected = true;
    }
    emit(
      state.copyWith(
        baggingTaggingPurchaseList: currentBaggingTaggingPurchaseList,
        isCompleteSelected: isCompleteSelected,
      ),
    );
  }

  void isAllItemsSelectEvent(
    IsAllItemsSelectEvent event,
    Emitter<BaggingTaggingPurchaseListState> emit,
  ) {
    final List<BaggingTaggingPurchaseListViewEntity>
    currentBaggingTaggingPurchaseList = List.from(
      state.baggingTaggingPurchaseList,
    );
    List<BaggingTaggingPurchaseListViewEntity> updatedList = [];
    if (event.isSelected == true) {
      updatedList =
          currentBaggingTaggingPurchaseList.map((element) {
            element.isSelected = true;
            return element;
          }).toList();
    } else {
      updatedList =
          currentBaggingTaggingPurchaseList.map((element) {
            element.isSelected = false;
            return element;
          }).toList();
    }
    emit(
      state.copyWith(
        isCompleteSelected: event.isSelected,
        baggingTaggingPurchaseList: updatedList,
      ),
    );
  }

  void baggingTaggingPurchaseInitalEvent(
    BaggingTaggingPurchaseInitialEvent event,
    Emitter<BaggingTaggingPurchaseListState> emit,
  ) {
    emit(BaggingTaggingPurchaseListState.initial());
  }

  //serial number

  Future<void> onBaggingSerialNoUpdateEvent(
    OnBaggingSerialNoUpdateEvent event,
    Emitter emit,
  ) async {
    state.baggingTaggingPurchaseEntityList = event.articleNo;
    emit(
      state.copyWith(
        baggingTaggingPurchaseEntityList:
            state.baggingTaggingPurchaseEntityList,
      ),
    );
  }

  Future<void> baggingAutoGenerateNumberCheckboxEvent(
    BaggingAutoGenerateNumberCheckboxEvent event,
    Emitter<BaggingTaggingPurchaseListState> emit,
  ) async {
    String vesselName = "VESL";
    List<String> serialNoList = [];

    for (int i = 1; i <= 10; i++) {
      serialNoList.add('$vesselName - 00 $i');
    }

    emit(
      state.copyWith(
        isBaggingAutoSerialNumber: event.isBaggingAutoGenerateNumberEnabled,
        autoSerialNumberList: serialNoList,
      ),
    );
  }
}
