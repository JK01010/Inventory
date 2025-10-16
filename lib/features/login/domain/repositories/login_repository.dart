import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../usecases/identity_server_verification_usecase.dart';

abstract interface class LoginRepository {
  Future<Either<Failure, bool>> identityServerLoginVerification(
    IdentityServerVerificationParams params,
  );

  Future<Either<Failure, bool>> logout();
}
