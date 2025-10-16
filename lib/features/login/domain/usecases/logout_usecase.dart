import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../repositories/login_repository.dart';

abstract interface class LogoutUseCase {
  Future<Either<Failure, bool>> call();
}

class LogoutUseCaseImpl implements LogoutUseCase {
  LogoutUseCaseImpl({required LoginRepository loginRepository})
    : _loginRepository = loginRepository;

  final LoginRepository _loginRepository;

  @override
  Future<Either<Failure, bool>> call() {
    return _loginRepository.logout();
  }
}
