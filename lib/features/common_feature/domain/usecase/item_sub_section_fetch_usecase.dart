import 'package:fpdart/fpdart.dart';

import '../entities/item_sub_section_entity.dart';
import '../failures/common_failures.dart';
import '../repositories/common_repository.dart';

abstract interface class ItemSubSectionFetchUsecase {
  Future<Either<CommonFailures, List<ItemSubSectionEntity>>> call();
}

class ItemSubSectionFetchUsecaseImpl implements ItemSubSectionFetchUsecase {
  ItemSubSectionFetchUsecaseImpl({required this.commonRepository});

  final CommonRepository commonRepository;
  @override
  Future<Either<CommonFailures, List<ItemSubSectionEntity>>> call() {
    return commonRepository.fetchAllItemSubSection();
  }
}
