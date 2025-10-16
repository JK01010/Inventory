import 'package:fpdart/fpdart.dart';

import '../repositories/splash_repository.dart';
import '../splash_failure/splash_failure.dart';

abstract class CheckAuthenticationUseCase {
  Future<Either<SplashFailure, Unit>> call();
}

class CheckAuthenticationUseCaseImpl extends CheckAuthenticationUseCase {
  CheckAuthenticationUseCaseImpl({required SplashRepository splashRepository})
    : _splashRepository = splashRepository;
  final SplashRepository _splashRepository;

  @override
  Future<Either<SplashFailure, Unit>> call() async {
    return _splashRepository.checkUserAuthentication();
  }
}
