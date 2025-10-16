import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/failures/goods_receipts_failures.dart';
import '../../../domain/entity/purchase_order_entity.dart';
import '../../../domain/entity/purchase_order_filter_entity.dart';
import '../../../domain/usecase/get_purchase_order_from_db_usecase.dart';

part 'purchase_order_search_event.dart';

part 'purchase_order_search_state.dart';

class PurchaseOrderSearchBloc
    extends Bloc<PurchaseOrderSearchEvent, PurchaseOrderSearchState> {
  PurchaseOrderSearchBloc({required this.fetchPurchaseOrderFromDbUsecase})
    : super(PurchaseOrderSearchInitial()) {
    on<PurchaseOrderItemSearchEvent>((event, emit) async {
      emit(PurchaseOrderSearchLoading());

      final PurchaseOrderFilterEntity purchaseOrderFilterEntity =
          PurchaseOrderFilterEntity(poNumberOrTitle: event.query);
      final failureOrSuccess = await fetchPurchaseOrderFromDbUsecase(
        purchaseOrderFilterEntity: purchaseOrderFilterEntity,
      );

      failureOrSuccess.fold((failure) {}, (pendingPoList) {
        emit(PurchaseOrderSearchLoaded(purchaseOrderEntityList: pendingPoList));
      });
    });
  }

  final GetPurchaseOrderFromDbUsecase fetchPurchaseOrderFromDbUsecase;
}
