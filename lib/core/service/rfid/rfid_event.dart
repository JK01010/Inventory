part of 'rfid_bloc.dart';

sealed class RfidEvent extends Equatable {
  const RfidEvent();
}

class InitRfidEvent extends RfidEvent {
  @override
  List<Object?> get props => [];
}

class StartScanEvent extends RfidEvent {
  @override
  List<Object?> get props => [];
}

class SetPowerLevelEvent extends RfidEvent {
  const SetPowerLevelEvent({required this.powerLevel});

  final int powerLevel;
  @override
  List<Object?> get props => [powerLevel];
}

class StopScanEvent extends RfidEvent {
  @override
  List<Object?> get props => [];
}

class ConnectScannerEvent extends RfidEvent {
  @override
  List<Object?> get props => [];
}

class DisconnectScannerEvent extends RfidEvent {
  @override
  List<Object?> get props => [];
}

class StartTrackEvent extends RfidEvent {
  @override
  List<Object?> get props => [];
}

class RequestTagCountEvent extends RfidEvent {
  @override
  List<Object?> get props => [];
}

class DispatchScanResultEvent extends RfidEvent {
  DispatchScanResultEvent({required this.tags})
    : _id = DateTime.now().toIso8601String();
  final List<RfidTag> tags;
  final String _id;

  @override
  List<Object?> get props => [tags, _id];
}

class DispatchConnectionStatusEvent extends RfidEvent {
  DispatchConnectionStatusEvent() : _id = DateTime.now().toIso8601String();
  final String _id;

  @override
  List<Object?> get props => [_id];
}
