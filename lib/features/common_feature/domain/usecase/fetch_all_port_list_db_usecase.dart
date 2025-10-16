import 'package:fpdart/fpdart.dart';

import '../entities/port_entity.dart';
import '../failures/common_failures.dart';
import '../repositories/common_repository.dart';

abstract interface class GetAllPortListFromDbUseCase {
  Future<Either<CommonFailures, List<PortEntity>>> call({
    required String query,
  });
}

class GetAllPortListFromDbUseCaseImpl implements GetAllPortListFromDbUseCase {
  const GetAllPortListFromDbUseCaseImpl({required this.commonRepository});

  final CommonRepository commonRepository;

  @override
  Future<Either<CommonFailures, List<PortEntity>>> call({
    required String query,
  }) {
    return commonRepository.fetchPortFromDb(query: query);
  }
}
