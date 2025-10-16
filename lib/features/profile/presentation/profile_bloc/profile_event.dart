part of 'profile_bloc.dart';

@immutable
class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class UpdateRFIDCheckBoxSelectedStatusEvent extends ProfileEvent {
  const UpdateRFIDCheckBoxSelectedStatusEvent({required this.isRFIDSelected});

  final bool isRFIDSelected;
}

class UpdateBarCodeCheckBoxSelectedStatusEvent extends ProfileEvent {
  const UpdateBarCodeCheckBoxSelectedStatusEvent({
    required this.isBarCodeSelected,
  });

  final bool isBarCodeSelected;
}
