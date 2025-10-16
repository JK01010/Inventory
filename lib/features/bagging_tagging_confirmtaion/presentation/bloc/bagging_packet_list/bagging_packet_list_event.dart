part of 'bagging_packet_list_bloc.dart';


class BaggingPacketListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

//get
class BaggingPacketFetchAllDataEvent extends BaggingPacketListEvent {
  BaggingPacketFetchAllDataEvent({required this.grnId});
  final String grnId;
}