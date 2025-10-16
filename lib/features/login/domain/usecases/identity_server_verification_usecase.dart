import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/identity_server_model.dart';
import '../repositories/login_repository.dart';

abstract interface class IdentityServerVerificationUseCase {
  Future<Either<Failure, bool>> call({
    required IdentityServerVerificationParams params,
  });
}

class IdentityServerVerificationUseCaseImpl
    implements IdentityServerVerificationUseCase {
  IdentityServerVerificationUseCaseImpl({
    required LoginRepository loginRepository,
  }) : _loginRepository = loginRepository;

  final LoginRepository _loginRepository;

  @override
  Future<Either<Failure, bool>> call({
    required IdentityServerVerificationParams params,
  }) {
    return _loginRepository.identityServerLoginVerification(params);
  }
}

class IdentityServerVerificationParams {
  IdentityServerVerificationParams({
    required this.identityServerResponse,
    required this.verificationBaseUrl,
  });

  final IdentityServerResponse identityServerResponse;
  final String verificationBaseUrl;
}
