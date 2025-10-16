part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class IdentityServerLoginVerification extends LoginEvent {
  const IdentityServerLoginVerification({
    required this.identityServerResponse,
    required this.verificationBaseUrl,
  });

  final IdentityServerResponse identityServerResponse;
  final String verificationBaseUrl;
}
