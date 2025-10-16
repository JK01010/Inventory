part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({required this.loginSuccess, required this.errorMessage});

  factory LoginState.initial() {
    return LoginState(loginSuccess: false, errorMessage: '');
  }

  final bool loginSuccess;
  final String errorMessage;

  @override
  List<Object> get props => [loginSuccess];

  LoginState copyWith({bool? loginSuccess, String? errorMessage}) {
    return LoginState(
      loginSuccess: loginSuccess ?? this.loginSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
