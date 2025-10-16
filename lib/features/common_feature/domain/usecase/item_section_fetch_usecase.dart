import 'package:fpdart/fpdart.dart';

import '../entities/item_section_entity.dart';
import '../failures/common_failures.dart';
import '../repositories/common_repository.dart';

abstract interface class ItemSectionFetchUsecase {
  Future<Either<CommonFailures, List<ItemSectionEntity>>> call();
}

class ItemSectionFetchUsecaseImpl implements ItemSectionFetchUsecase {
  ItemSectionFetchUsecaseImpl({required this.commonRepository});

  final CommonRepository commonRepository;
  @override
  Future<Either<CommonFailures, List<ItemSectionEntity>>> call() {
    return commonRepository.fetchAllItemSection();
  }
}
