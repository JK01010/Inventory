import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import '../failures/common_failures.dart';
import '../repositories/common_repository.dart';

abstract interface class GetAllPoItemsUseCase {
  Future<Either<CommonFailures, Unit>> call();
}

class GetAllPoItemsUseCaseImpl implements GetAllPoItemsUseCase {
  GetAllPoItemsUseCaseImpl({required this.commonRepository});

  final CommonRepository commonRepository;

  @override
  Future<Either<CommonFailures, Unit>> call() {
    debugPrint("inside the GetAllPoItemsUseCase **************");
    return commonRepository.getAllPoItems();
  }
}
