part of 'bagging_item_section_bloc.dart';

class BaggingItemSectionState extends Equatable {
  const BaggingItemSectionState({
    required this.isLoading,
    required this.itemMasterFailures,
    required this.itemSectionEntity
  });

  factory BaggingItemSectionState.initial() => BaggingItemSectionState(
    itemSectionEntity: [],
    isLoading: false,
    itemMasterFailures: none(),
  );

  final List<ItemSectionEntity> itemSectionEntity;
  final bool isLoading;
  final Option<ItemMasterFailures> itemMasterFailures;



  @override
  List<Object?> get props => [
    itemMasterFailures,
    isLoading,
    itemSectionEntity,

  ];

  BaggingItemSectionState copyWith({
    List<ItemSectionEntity>? itemSectionEntity,
    bool? isLoading,
    Option<ItemMasterFailures>? itemMasterFailures,
  }) {
    return BaggingItemSectionState(
      itemSectionEntity: itemSectionEntity ?? this.itemSectionEntity,
      isLoading: isLoading ?? this.isLoading,
      itemMasterFailures: itemMasterFailures ?? this.itemMasterFailures,
    );
  }
}
