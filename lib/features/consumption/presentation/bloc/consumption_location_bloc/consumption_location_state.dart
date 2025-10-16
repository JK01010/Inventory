part of 'consumption_location_bloc.dart';

class ConsumptionLocationState extends Equatable {
  const ConsumptionLocationState({
    required this.isLoading,
    required this.consumptionFailures,
    required this.consumptionLocationEntity,
  });

  factory ConsumptionLocationState.initial() => ConsumptionLocationState(
    consumptionLocationEntity: [],
    isLoading: false,
    consumptionFailures: none(),
  );

  final List<ConsumptionLocationEntity> consumptionLocationEntity;
  final bool isLoading;
  final Option<ConsumptionFailures> consumptionFailures;

  @override
  List<Object?> get props => [
    consumptionFailures,
    isLoading,
    consumptionLocationEntity,
  ];

  ConsumptionLocationState copyWith({
    List<ConsumptionLocationEntity>? consumptionLocationEntity,
    bool? isLoading,
    Option<ConsumptionFailures>? consumptionFailures,
  }) {
    return ConsumptionLocationState(
      consumptionLocationEntity:
          consumptionLocationEntity ?? this.consumptionLocationEntity,
      isLoading: isLoading ?? this.isLoading,
      consumptionFailures: consumptionFailures ?? this.consumptionFailures,
    );
  }
}
