sealed class SplashException {
  final  String message;

  SplashException({required this.message});
}

class UserNotAuthenticatedException extends SplashException{
  UserNotAuthenticatedException({required super.message});
}