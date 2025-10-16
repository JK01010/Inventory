// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'rfid_bloc.dart';

class RfidState extends Equatable {
  const RfidState({required this.isConnected, required this.tags});
  final bool isConnected;
  final List<RfidTag> tags;

  @override
  List<Object?> get props => [isConnected, tags];

  RfidState copyWith({bool? isConnected, List<RfidTag>? tags}) {
    return RfidState(
      isConnected: isConnected ?? this.isConnected,
      tags: tags ?? this.tags,
    );
  }

  factory RfidState.initial() => RfidState(isConnected: false, tags: []);
}
