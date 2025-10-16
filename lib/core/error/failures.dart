import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {

  const Failure({required this.code, required this.message, this.debugMessage});
  final String code; // Unique error code
  final String message;
  final String? debugMessage;

  @override
  List<Object?> get props => [code, message, debugMessage];
}

/// API/server-related failures
class ServerFailure extends Failure {
  const ServerFailure({required super.code, required super.message, super.debugMessage});
}

/// Local cache/storage (e.g., SqfLite, SharedPreferences, local DB)
class CacheFailure extends Failure {
  const CacheFailure({required super.code, required super.message, super.debugMessage});
}

/// Network-related issues (e.g., no connection, timeout)
class NetworkFailure extends Failure {
  const NetworkFailure({required super.code, required super.message, super.debugMessage});
}

/// Unexpected failure or uncaught exception
class UnknownFailure extends Failure {
  const UnknownFailure({required super.code, required super.message, super.debugMessage});
}

/// Failure related to database operations (e.g., insert/update/delete errors)
class DatabaseFailure extends Failure {
  const DatabaseFailure({required super.code, required super.message, super.debugMessage});
}

/// Authentication/authorization errors
class AuthFailure extends Failure {
  const AuthFailure({required super.code, required super.message, super.debugMessage});
}

/// Input validation failure from user
class ValidationFailure extends Failure {
  const ValidationFailure({required super.code, required super.message, super.debugMessage});
}

/// Timeout (e.g., server or network timeout)
class TimeoutFailure extends Failure {
  const TimeoutFailure({required super.code, required super.message, super.debugMessage});
}

/// SSL certificate errors or security issues
class SecurityFailure extends Failure {
  const SecurityFailure({required super.code, required super.message, super.debugMessage});
}

/// External service error (e.g., Firebase)
class ExternalServiceFailure extends Failure {
  const ExternalServiceFailure({required super.code, required super.message, super.debugMessage});
}
