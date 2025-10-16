import '../../../../core/error/failures.dart';
import '../../../common_feature/domain/failures/common_failures.dart';

sealed class ItemMasterFailures extends Failure implements CommonFailures {
  const ItemMasterFailures({required super.code, required super.message});
}

class ItemMasterServerFailure extends ItemMasterFailures {
  const ItemMasterServerFailure({required super.code, required super.message});
}

class ItemMasterGetAllDbFailure extends ItemMasterFailures {
  const ItemMasterGetAllDbFailure({
    required super.code,
    required super.message,
  });
}

class ItemMasterInsertPoFailure extends ItemMasterFailures {
  const ItemMasterInsertPoFailure({
    required super.code,
    required super.message,
  });
}

class GetAllEquipmentFailure extends ItemMasterFailures {
  const GetAllEquipmentFailure({required super.code, required super.message});
}

class ItemDetailsStorageLocationIdFailure extends ItemMasterFailures {
  const ItemDetailsStorageLocationIdFailure({
    required super.code,
    required super.message,
  });
}

class ImdgClassEventGetAllDataFailure extends ItemMasterFailures {
  const ImdgClassEventGetAllDataFailure({
    required super.code,
    required super.message,
  });
}

class ItemSubSectionFetchAllDataFailure extends ItemMasterFailures {
  const ItemSubSectionFetchAllDataFailure({
    required super.code,
    required super.message,
  });
}

class ItemSectionFetchAllDataFailure extends ItemMasterFailures {
  const ItemSectionFetchAllDataFailure({
    required super.code,
    required super.message,
  });
}

class ItemCategoryFetchAllDataFailure extends ItemMasterFailures {
  const ItemCategoryFetchAllDataFailure({
    required super.code,
    required super.message,
  });
}

// class ItemMasterUnknownFailure extends ItemMasterFailures {
//   const ItemMasterUnknownFailure({
//     required super.code,
//     required super.message,
//   });
// }
