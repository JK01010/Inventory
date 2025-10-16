import 'package:fpdart/fpdart.dart';

import '../failures/common_failures.dart';
import '../repositories/common_repository.dart';

abstract interface class GetAllVesselSpecification {
  Future<Either<CommonFailures, Unit>> call();
}

class GetAllVesselSpecificationImpl implements GetAllVesselSpecification {
  GetAllVesselSpecificationImpl({required this.repository});

  final CommonRepository repository;

  @override
  Future<Either<CommonFailures, Unit>> call() {
    return repository.getAllVesselSpecification();
  }
}
