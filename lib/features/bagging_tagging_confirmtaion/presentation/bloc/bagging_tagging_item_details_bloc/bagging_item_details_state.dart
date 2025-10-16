part of 'bagging_item_details_bloc.dart';

class BaggingItemDetailsState extends Equatable {
  const BaggingItemDetailsState({
    required this.splitLocationEntity,
    required this.isLoading,
    required this.baggingAndTaggingFailures,
    required this.purchaseDetailsEntity,
  });

  factory BaggingItemDetailsState.initial() => BaggingItemDetailsState(
    splitLocationEntity: [],
    isLoading: false,
    baggingAndTaggingFailures: none(),
    purchaseDetailsEntity: [],
  );

  final List<SplitLocationEntity> splitLocationEntity;
  final List<PurchaseDetailsEntity> purchaseDetailsEntity;
  final bool isLoading;
  final Option<BaggingAndTaggingFailures> baggingAndTaggingFailures;

  @override
  List<Object> get props => [
    splitLocationEntity,
    purchaseDetailsEntity,
    isLoading,
    baggingAndTaggingFailures,
  ];

  BaggingItemDetailsState copyWith({
    List<SplitLocationEntity>? splitLocationEntity,
    List<PurchaseDetailsEntity>? purchaseDetailsEntity,
    bool? isLoading,
    Option<BaggingAndTaggingFailures>? baggingAndTaggingFailures,
  }) {
    return BaggingItemDetailsState(
      splitLocationEntity:
      splitLocationEntity ?? this.splitLocationEntity,
      isLoading: isLoading ?? this.isLoading,
      baggingAndTaggingFailures:
          baggingAndTaggingFailures ?? this.baggingAndTaggingFailures,
      purchaseDetailsEntity:
          purchaseDetailsEntity ?? this.purchaseDetailsEntity,
    );
  }
}
