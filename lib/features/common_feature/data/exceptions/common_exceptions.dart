sealed class CommonExceptions implements Exception {}

class ServerException extends CommonExceptions {}

class PortException extends CommonExceptions {}

class EquipmentListServerException extends CommonExceptions {}

class EquipmentListInsertDetailsException extends CommonExceptions {}

class EquipmentListGetAllDetailsException extends CommonExceptions {}

class FetchImdgInsertAllDetailsException extends CommonExceptions {}

class FetchImdgFetchAllDetailsException extends CommonExceptions {}

class StorageLocationInsertException extends CommonExceptions {}

class StorageLocationGetLocationsByIdFailure extends CommonExceptions {}

class InsertQualityItemException extends CommonExceptions {}

class QualityListItemDbException extends CommonExceptions {}

class QualityListNetworkException extends CommonExceptions {}

class QualityListUnknownException extends CommonExceptions {}
