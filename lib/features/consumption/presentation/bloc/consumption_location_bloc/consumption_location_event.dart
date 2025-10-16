part of 'consumption_location_bloc.dart';

class ConsumptionLocationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

//insert
class InsertLocationDataEvent extends ConsumptionLocationEvent {}

//get
class FetchAllLocationDataEvent extends ConsumptionLocationEvent {}
