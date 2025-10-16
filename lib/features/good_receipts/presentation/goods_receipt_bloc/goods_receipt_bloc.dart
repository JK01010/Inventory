// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/constants/app_enum.dart';
// import '../../domain/goods_list_entity.dart';

// part 'goods_receipt_event.dart';
// part 'goods_receipt_state.dart';

// class GoodsReceiptBloc extends Bloc<GoodsReceiptEvent, GoodsReceiptState> {
//   GoodsReceiptBloc() : super(GoodsReceiptState.initial()) {
//     on<GoodsReceiptEvent>((event, emit) async {
//       switch (event) {
//         case AddToSync():
//           await _addToSync(event, emit);
//           return;
//         case ChangeSelectionEvent():
//           await _changeSelectionMode(event, emit);
//           return;
//         case AddToSyncList():
//           await _addToSyncList(event, emit);
//           return;
//         case SelectAllEvent():
//           await _selectAllEvent(event, emit);
//       }
//     });
//   }

//   Future<void> _addToSync(
//     AddToSync event,
//     Emitter<GoodsReceiptState> emit,
//   ) async {
//     final updatedItems =
//         state.goodsListEntity.map((item) {
//           return item.serialNumber == event.itemId
//               ? item.copyWith(syncStatus: SyncStatus.syncing)
//               : item;
//         }).toList();

//     emit(state.copyWith(goodsListEntity: updatedItems));

//     await Future.delayed(Duration(seconds: 2));

//     final finalItems =
//         updatedItems.map((item) {
//           return item.serialNumber == event.itemId
//               ? item.copyWith(syncStatus: SyncStatus.synced)
//               : item;
//         }).toList();

//     emit(state.copyWith(goodsListEntity: finalItems));
//   }

//   Future<void> _changeSelectionMode(
//     ChangeSelectionEvent event,
//     Emitter<GoodsReceiptState> emit,
//   ) async {
//     if (event.value == false) {
//       emit(
//         state.copyWith(
//           isSelectionModeEnabled: event.value,
//           goodsSyncListEntity: {},
//         ),
//       );
//     } else {
//       emit(state.copyWith(isSelectionModeEnabled: event.value));
//     }
//   }

//   Future<void> _addToSyncList(
//     AddToSyncList event,
//     Emitter<GoodsReceiptState> emit,
//   ) async {
//     final Set<String> data = Set.from(state.goodsSyncListEntity);
//     if (data.contains(event.id)) {
//       data.remove(event.id);
//     } else {
//       data.add(event.id);
//     }

//     emit(state.copyWith(goodsSyncListEntity: data));
//   }

//   Future<void> _selectAllEvent(
//     SelectAllEvent event,
//     Emitter<GoodsReceiptState> emit,
//   ) async {
//     final Set<String> newSet =
//         state.goodsListEntity.map((e) => e.serialNumber).toSet();

//     emit(state.copyWith(goodsSyncListEntity: newSet));
//   }

//   bool isSyncListContains({required String id}) {
//     return state.goodsSyncListEntity.any((element) => element == id);
//   }

//   bool isListEqual() => state.goodsListEntity.every(
//     (element) => state.goodsSyncListEntity.contains(element.serialNumber),
//   );
// }
