part of 'profile_bloc.dart';

@immutable
class ProfileState extends Equatable {
  const ProfileState({
    required this.profileImage,
    required this.userName,
    required this.userEmail,
    required this.isRFIDEnabled,
    required this.isBarCodeEnabled,
  });

  factory ProfileState.initial() => ProfileState(
    profileImage: '',
    userName: '',
    userEmail: '',
    isRFIDEnabled: false,
    isBarCodeEnabled: false,
  );

  final String profileImage;
  final String userName;
  final String userEmail;
  final bool isRFIDEnabled;
  final bool isBarCodeEnabled;

  @override
  List<Object?> get props => [
    profileImage,
    userName,
    userEmail,
    isRFIDEnabled,
    isBarCodeEnabled,
  ];

  ProfileState copyWith({
    String? profileImage,
    String? userName,
    String? userEmail,
    bool? isRFIDEnabled,
    bool? isBarCodeEnabled,
  }) {
    return ProfileState(
      profileImage: profileImage ?? this.profileImage,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      isRFIDEnabled: isRFIDEnabled ?? this.isRFIDEnabled,
      isBarCodeEnabled: isBarCodeEnabled ?? this.isBarCodeEnabled,
    );
  }
}
