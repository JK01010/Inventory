import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import '../../../common_feature/domain/entities/port_entity.dart';
import '../../../common_feature/domain/usecase/fetch_all_port_list_db_usecase.dart';
import '../../domain/entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../../purchase_order/domain/entity/purchase_order_filter_entity.dart';
import '../../domain/entities/purchase_order_hd_entity.dart';
import '../../domain/failures/goods_receipts_failures.dart';
import '../../domain/use_cases/goods_receipts_po_usecase/get_goods_receipt_details_by_id_usecase.dart';
import '../../domain/use_cases/goods_receipts_po_usecase/goods_receipt_get_all_po_line_items_data_use_case.dart';
import '../../domain/use_cases/goods_receipts_po_usecase/save_goods_receipts_usecase.dart';
import '../../domain/use_cases/goods_receipts_po_usecase/update_goods_receipts_po_detail_use_case.dart';

part 'goods_receipts_po_event.dart';

part 'goods_receipts_po_state.dart';

class GoodsReceiptsPoBloc
    extends Bloc<GoodsReceiptsPoEvent, GoodsReceiptsPoState> {
  GoodsReceiptsPoBloc({
    required this.updateGoodsReceiptsPoDetailUseCase,
    required this.getGoodsReceiptDetailsByIdUseCase,
    required this.goodsReceiptGetAllPoLineItemsDataUseCase,
    required this.saveGoodReceiptsUseCase,
  }) : super(GoodsReceiptsPoState.initial()) {
    on<GoodsReceiptsPoEvent>((event, emit) async {
      switch (event) {
        case UpdateGoodsReceiptDetailForDraftEvent():
          await updateGoodsReceiptsPoDetail(event, emit);
          break;
        case GetGoodsReceiptDetailEventById():
          await getGoodsReceiptItemDetail(event, emit);
          break;
        case ChangeReceivedDate():
          changeReceivedDate(event, emit);
          break;
        case GoodsReceiptsPoGetAllPoLineItemsDataEvent():
          await goodsReceiptsPoGetAllPoLineItemsData(emit);
          break;
        case SaveOrDraftGoodsReceiptEvent():
          await saveOrDraftGoodsReceipt(event, emit);
          break;
      }
    });
  }

  final UpdateGoodsReceiptsPoDetailUseCase updateGoodsReceiptsPoDetailUseCase;
  final GetGoodsReceiptDetailsByIdUseCase getGoodsReceiptDetailsByIdUseCase;
  final GoodsReceiptGetAllPoLineItemsDataUseCase
  goodsReceiptGetAllPoLineItemsDataUseCase;
  final SaveGoodReceiptsUseCase saveGoodReceiptsUseCase;

  void changeReceivedDate(
    ChangeReceivedDate event,
    Emitter<GoodsReceiptsPoState> emit,
  ) {
    if (event.index != -1) {
      final List<PurchaseOrderHDEntity> poList = List.from(
        state.goodsReceiptsHdEntityList,
      );

      final updatePo = poList[event.index].copyWith(
        deliveryDate: event.receivedDate.toString(),
      );
      poList[event.index] = updatePo;
      emit(state.copyWith(goodsReceiptsHdEntityList: poList));
    }
  }

  Future<void> updateGoodsReceiptsPoDetail(
    UpdateGoodsReceiptDetailForDraftEvent event,
    Emitter<GoodsReceiptsPoState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 2));
    final failureOrSuccess = await updateGoodsReceiptsPoDetailUseCase.call(
      event.purchaseOrderHDEntity,
    );
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(
            goodsReceiptsFailures: some(failure),
            isLoading: false,
          ),
        );
      },
      (success) {
        emit(state.copyWith(purchaseOrderHDEntity: success, isLoading: false));
      },
    );
  }

  Future<void> getGoodsReceiptItemDetail(
    GetGoodsReceiptDetailEventById event,
    Emitter<GoodsReceiptsPoState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 2));
    final failureOrSuccess = await getGoodsReceiptDetailsByIdUseCase
        .getGoodsReceiptDetailsById(int.parse(event.pendingOrderId));
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(
            goodsReceiptsFailures: some(failure),
            isLoading: false,
          ),
        );
      },
      (success) {
        emit(state.copyWith(purchaseOrderHDEntity: success, isLoading: false));
      },
    );
  }

  Future<void> goodsReceiptsPoGetAllPoLineItemsData(
    Emitter<GoodsReceiptsPoState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    final failureOrSuccess = await goodsReceiptGetAllPoLineItemsDataUseCase();
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(
            goodsReceiptsFailures: some(failure),
            isLoading: false,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(goodsReceiptPoLineItemList: success, isLoading: false),
        );
      },
    );
  }

  Future<void> saveOrDraftGoodsReceipt(
    SaveOrDraftGoodsReceiptEvent event,
    Emitter<GoodsReceiptsPoState> emit,
  ) async {
    emit(state.copyWith(isSaveLoading: true));
    final failureOrSuccess = await saveGoodReceiptsUseCase(
      SaveGoodsReceiptsParams(
        purchaseOrderHDEntity: event.purchaseOrderHDEntity,
        statusType: event.statusType,
      ),
    );
    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(
            goodsReceiptsFailures: some(failure),
            isSaveLoading: false,
          ),
        );
      },
      (success) {
        emit(state.copyWith(isFinalizeDone: true));
        emit(state.copyWith(isFinalizeDone: false));
        emit(state.copyWith(isSaveLoading: false));
      },
    );
  }
}
