part of 'rfid_view_bloc.dart';

class RfidViewState extends Equatable {
  const RfidViewState({
    required this.isLoading,
    required this.itemMasterRfidViewEntity,
    required this.itemMasterFailures,
  });

  factory RfidViewState.initialState() =>
      RfidViewState(
          isLoading: true,
          itemMasterRfidViewEntity: [],
          itemMasterFailures:none()
      );

  final bool isLoading;
  final List<ItemMasterRfidViewEntity> itemMasterRfidViewEntity;
  final Option<ItemMasterFailures> itemMasterFailures;


  @override
  List<Object?> get props => [
    isLoading,
    itemMasterRfidViewEntity,
    itemMasterFailures
  ];

  RfidViewState copyWith({
    bool? isLoading,
    List<ItemMasterRfidViewEntity>? itemMasterRfidViewEntity,
    Option<ItemMasterFailures>? itemMasterFailures
  }) {
    return RfidViewState(
      isLoading: isLoading ?? this.isLoading,
      itemMasterRfidViewEntity: itemMasterRfidViewEntity ?? this.itemMasterRfidViewEntity,
        itemMasterFailures: itemMasterFailures ?? this.itemMasterFailures

    );
  }
}
