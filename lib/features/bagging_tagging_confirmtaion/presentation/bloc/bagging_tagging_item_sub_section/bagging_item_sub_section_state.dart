part of 'bagging_item_sub_section_bloc.dart';

class BaggingItemSubSectionState extends Equatable {
  const BaggingItemSubSectionState({
    required this.isLoading,
    required this.itemMasterFailures,
    required this.itemSubSectionEntity
  });

  factory BaggingItemSubSectionState.initial() => BaggingItemSubSectionState(
    itemSubSectionEntity: [],
    isLoading: false,
    itemMasterFailures: none(),
  );

  final List<ItemSubSectionEntity> itemSubSectionEntity;
  final bool isLoading;
  final Option<ItemMasterFailures> itemMasterFailures;



  @override
  List<Object?> get props => [
    itemMasterFailures,
    isLoading,
    itemSubSectionEntity,

  ];

  BaggingItemSubSectionState copyWith({
    List<ItemSubSectionEntity>? itemSubSectionEntity,
    bool? isLoading,
    Option<ItemMasterFailures>? itemMasterFailures,
  }) {
    return BaggingItemSubSectionState(
      itemSubSectionEntity: itemSubSectionEntity ?? this.itemSubSectionEntity,
      isLoading: isLoading ?? this.isLoading,
      itemMasterFailures: itemMasterFailures ?? this.itemMasterFailures,
    );
  }
}
