import '../../../../core/error/failures.dart';

abstract class CommonFailures extends Failure {
  const CommonFailures({required super.code, required super.message});
}

class ServerFailure extends CommonFailures {
  const ServerFailure({required super.code, required super.message});
}

class PortFailure extends CommonFailures {
  const PortFailure({required super.code, required super.message});
}

class EquipmentServerFailure extends CommonFailures {
  const EquipmentServerFailure({required super.code, required super.message});
}

class EquipmentListInsertDetailsExceptionFailure extends CommonFailures {
  const EquipmentListInsertDetailsExceptionFailure({
    required super.code,
    required super.message,
  });
}

class EquipmentListGetAllDetailsExceptionFailure extends CommonFailures {
  const EquipmentListGetAllDetailsExceptionFailure({
    required super.code,
    required super.message,
  });
}

class FetchImdgInsertAllDetailsExceptionFailure extends CommonFailures {
  const FetchImdgInsertAllDetailsExceptionFailure({
    required super.code,
    required super.message,
  });
}

class FetchImdgFetchAllDetailsExceptionFailure extends CommonFailures {
  const FetchImdgFetchAllDetailsExceptionFailure({
    required super.code,
    required super.message,
  });
}

class StorageLocationInsertExceptionFailure extends CommonFailures {
  const StorageLocationInsertExceptionFailure({
    required super.code,
    required super.message,
  });
}

class FetchStorageLocationsExceptionFailure extends CommonFailures {
  const FetchStorageLocationsExceptionFailure({
    required super.code,
    required super.message,
  });
}

class InsertQualitytFailure extends CommonFailures {
  const InsertQualitytFailure({required super.code, required super.message});
}


class QualityListDbFailure extends CommonFailures {
  const QualityListDbFailure({required super.code, required super.message});
}

class QualityListNetworkFailure extends CommonFailures {
  const QualityListNetworkFailure({required super.code, required super.message});
}

class QualityListUnknownFailure extends CommonFailures {
  const QualityListUnknownFailure({required super.code, required super.message});
}
