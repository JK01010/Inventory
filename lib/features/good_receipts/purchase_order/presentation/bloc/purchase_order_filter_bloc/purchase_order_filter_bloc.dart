import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../../core/constants/app_enum.dart';
import '../../../../../common_feature/domain/entities/item_category_entity.dart';
import '../../../../../common_feature/domain/entities/port_entity.dart';
import '../../../../../common_feature/domain/failures/common_failures.dart';
import '../../../../../common_feature/domain/usecase/fetch_all_port_list_db_usecase.dart';
import '../../../../../common_feature/domain/usecase/fetch_item_category_usecase.dart';
import '../../../domain/entity/purchase_order_entity.dart';
import '../../../domain/entity/purchase_order_filter_entity.dart';
import '../../../domain/usecase/get_purchase_order_from_db_usecase.dart';

part 'purchase_order_filter_event.dart';
part 'purchase_order_filter_state.dart';

class PurchaseOrderFilterBloc
    extends Bloc<PurchaseOrderFilterEvent, PurchaseOrderFilterState> {
  PurchaseOrderFilterBloc({
    required this.getPurchaseOrderFromDbUsecase,
    required this.getItemCategoryUsecase,
    required this.getAllPortListFromDbUseCase,
  }) : super(PurchaseOrderFilterState.initial()) {
    on<PurchaseOrderFilterEvent>((event, emit) async {
      switch (event) {
        case ChangeSyncFilter():
          await _changeSyncFilter(event, emit);
          break;
        case ClearFilter():
          await _clearFilter(event, emit);
          break;
        case ChangeStartDate():
          await _changeStartDate(event, emit);
          break;
        case ChangeEndDate():
          await _changeEndDate(event, emit);
          break;
        case ChangePoNumberEvent():
          await _changePoNumberEvent(event, emit);
          break;
        case ChangeCategory():
          await _changeCategory(event, emit);
          break;
        case ChangeDeliveryPort():
          await _changeDeliveryPort(event, emit);
          break;
        case ChangeGrnNo():
          await _changeGrnNo(event, emit);
          break;
        case FilterApplyButtonClickEvent():
          await _filterApplyButtonClickEvent(event, emit);
          break;
        case SearchPoNumber():
          await _searchPoNumber(event, emit);
        case FetchAllCategory():
          await _fetchAllCategory(event, emit);
        case ClearCategoryTempFilter():
          await _clearCategoryTempFilter(event, emit);

        case CategoryApplyButtonClick():
          await _categoryApplyButtonClicked(event, emit);
        case AddCategoryListToTempList():
          await _addCategoryListToTempList(event, emit);
        case SearchGrnNo():
          await _searchGrnNo(event, emit);
        case FetchAllPortListFromDb():
          await _fetchAllPortLIstFromDb(event, emit);
      }
    });
  }
  final GetPurchaseOrderFromDbUsecase getPurchaseOrderFromDbUsecase;
  final GetItemCategoryUsecase getItemCategoryUsecase;
  final GetAllPortListFromDbUseCase getAllPortListFromDbUseCase;

  Future<void> _changeSyncFilter(
    ChangeSyncFilter event,
    Emitter<PurchaseOrderFilterState> emit,
  ) async {
    emit(
      state.copyWith(
        purchaseOrderFilterEntity: state.purchaseOrderFilterEntity.copyWith(
          syncFilter: event.syncFilter,
        ),
      ),
    );
  }

  Future<void> _clearFilter(
    ClearFilter event,
    Emitter<PurchaseOrderFilterState> emit,
  ) async {
    emit(PurchaseOrderFilterState.initial());
  }

  Future<void> _changeStartDate(
    ChangeStartDate event,
    Emitter<PurchaseOrderFilterState> emit,
  ) async {
    emit(
      state.copyWith(
        purchaseOrderFilterEntity: state.purchaseOrderFilterEntity.copyWith(
          fromDate: event.dateTime,
        ),
      ),
    );
  }

  Future<void> _changeEndDate(
    ChangeEndDate event,
    Emitter<PurchaseOrderFilterState> emit,
  ) async {
    emit(
      state.copyWith(
        purchaseOrderFilterEntity: state.purchaseOrderFilterEntity.copyWith(
          toDate: event.dateTime,
        ),
      ),
    );
  }

  Future<void> _changePoNumberEvent(
    ChangePoNumberEvent event,
    Emitter<PurchaseOrderFilterState> emit,
  ) async {
    emit(
      state.copyWith(
        purchaseOrderFilterEntity: state.purchaseOrderFilterEntity.copyWith(
          poNumberOrTitle: event.poNumber,
        ),
      ),
    );
  }

  Future<void> _changeCategory(
    ChangeCategory event,
    Emitter<PurchaseOrderFilterState> emit,
  ) async {
    final List<ItemCategoryEntity> currentList = List<ItemCategoryEntity>.from(
      state.tempCategoryList,
    );
    if (currentList.contains(event.categoryEntity)) {
      currentList.remove(event.categoryEntity);
    } else {
      currentList.add(event.categoryEntity);
    }

    emit(state.copyWith(tempCategoryList: currentList));
  }

  Future<void> _changeDeliveryPort(
    ChangeDeliveryPort event,
    Emitter<PurchaseOrderFilterState> emit,
  ) async {
    emit(
      state.copyWith(
        purchaseOrderFilterEntity: state.purchaseOrderFilterEntity.copyWith(
          deliveryPortName: event.deliveryPortName,
        ),
      ),
    );
  }

  Future<void> _changeGrnNo(
    ChangeGrnNo event,
    Emitter<PurchaseOrderFilterState> emit,
  ) async {
    emit(
      state.copyWith(
        purchaseOrderFilterEntity: state.purchaseOrderFilterEntity.copyWith(
          grnNo: event.purchaseOrderHDEntity.grnId.toString(),
        ),
      ),
    );
  }

  Future<void> _filterApplyButtonClickEvent(
    FilterApplyButtonClickEvent event,
    Emitter<PurchaseOrderFilterState> emit,
  ) async {}

  Future<void> _searchPoNumber(
    SearchPoNumber event,
    Emitter<PurchaseOrderFilterState> emit,
  ) async {
    if (event.poNumber.isEmpty) {
      emit(state.copyWith(purchaseOrderList: []));
      return;
    }
    final PurchaseOrderFilterEntity purchaseOrderFilterEntity =
        PurchaseOrderFilterEntity(poNumberOrTitle: event.poNumber);
    final failureOrSuccess = await getPurchaseOrderFromDbUsecase(
      purchaseOrderFilterEntity: purchaseOrderFilterEntity,
    );

    failureOrSuccess.fold((failure) {}, (success) {
      emit(state.copyWith(purchaseOrderList: success));
    });
  }

  Future<void> _fetchAllCategory(
    FetchAllCategory event,
    Emitter<PurchaseOrderFilterState> emit,
  ) async {
    final failureOrSuccess = await getItemCategoryUsecase();

    failureOrSuccess.fold((failure) {}, (success) {
      emit(state.copyWith(itemCategoryList: success));
    });
  }

  Future<void> _clearCategoryTempFilter(
    ClearCategoryTempFilter event,
    Emitter<PurchaseOrderFilterState> emit,
  ) async {
    emit(state.copyWith(tempCategoryList: []));
  }

  Future<void> _categoryApplyButtonClicked(
    CategoryApplyButtonClick event,
    Emitter<PurchaseOrderFilterState> emit,
  ) async {
    emit(
      state.copyWith(
        purchaseOrderFilterEntity: state.purchaseOrderFilterEntity.copyWith(
          categoryList: state.tempCategoryList,
        ),
      ),
    );
  }

  Future<void> _addCategoryListToTempList(
    AddCategoryListToTempList event,
    Emitter<PurchaseOrderFilterState> emit,
  ) async {
    emit(
      state.copyWith(
        tempCategoryList: state.purchaseOrderFilterEntity.categoryList,
      ),
    );
  }

  Future<void> _searchGrnNo(
    SearchGrnNo event,
    Emitter<PurchaseOrderFilterState> emit,
  ) async {
    if (event.grnNo.isEmpty) {
      emit(state.copyWith(grnFilteredList: []));
      return;
    }
    final PurchaseOrderFilterEntity purchaseOrderFilterEntity =
        PurchaseOrderFilterEntity(grnNo: event.grnNo);
    final failureOrSuccess = await getPurchaseOrderFromDbUsecase(
      purchaseOrderFilterEntity: purchaseOrderFilterEntity,
    );

    failureOrSuccess.fold((failure) {}, (success) {
      emit(state.copyWith(grnFilteredList: success));
    });
  }

  Future<void> _fetchAllPortLIstFromDb(
    FetchAllPortListFromDb event,
    Emitter<PurchaseOrderFilterState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(state.copyWith(portEntityList: []));
      return;
    }
    final Either<CommonFailures, List<PortEntity>> failureOrSuccess =
        await getAllPortListFromDbUseCase(query: event.query);

    failureOrSuccess.fold((failure) {}, (success) {
      emit(state.copyWith(portEntityList: success));
    });
  }
}
