import 'package:fpdart/fpdart.dart';
import '../splash_failure/splash_failure.dart';

abstract interface class SplashRepository {
  Future<Either<SplashFailure, Unit>> checkUserAuthentication();
}
