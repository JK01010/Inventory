sealed class SplashFailure {
  final String message;

  SplashFailure({required this.message});
}

class UserNotAuthenticatedFailure extends SplashFailure {
  UserNotAuthenticatedFailure({required super.message});
}


