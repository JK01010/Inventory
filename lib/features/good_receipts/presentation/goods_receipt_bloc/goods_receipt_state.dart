// // ignore_for_file: public_member_api_docs, sort_constructors_first
// part of 'goods_receipt_bloc.dart';

// class GoodsReceiptState extends Equatable {
//   final List<GoodsListEntity> goodsListEntity;
//   final Set<String> goodsSyncListEntity;
//   final bool isSelectionModeEnabled;

//   const GoodsReceiptState({
//     required this.goodsListEntity,
//     required this.isSelectionModeEnabled,
//     required this.goodsSyncListEntity,
//   });

//   factory GoodsReceiptState.initial() {
//     return GoodsReceiptState(
//       goodsListEntity: goodsList,
//       isSelectionModeEnabled: false,
//       goodsSyncListEntity: {},
//     );
//   }

//   @override
//   List<Object> get props => [
//     goodsListEntity,
//     isSelectionModeEnabled,
//     goodsSyncListEntity,
//   ];

//   @override
//   bool get stringify => true;

//   GoodsReceiptState copyWith({
//     List<GoodsListEntity>? goodsListEntity,
//     Set<String>? goodsSyncListEntity,
//     bool? isSelectionModeEnabled,
//   }) {
//     return GoodsReceiptState(
//       goodsListEntity: goodsListEntity ?? this.goodsListEntity,
//       goodsSyncListEntity: goodsSyncListEntity ?? this.goodsSyncListEntity,
//       isSelectionModeEnabled:
//           isSelectionModeEnabled ?? this.isSelectionModeEnabled,
//     );
//   }
// }
