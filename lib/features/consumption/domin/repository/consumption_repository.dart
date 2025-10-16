import 'package:fpdart/fpdart.dart';
import '../entities/con_transaction_view_entity_model.dart';
import '../entities/consumption_location_entity.dart';
import '../entities/consumption_rfid_scanning_view_entity_model.dart';
import '../entities/consumption_transaction_entity_model.dart';
import '../failures/consumption_failures.dart';

abstract interface class ConsumptionRepository {
  ///insert
  Future<Either<ConsumptionFailures, Unit>> insertConsumptionTransaction();
  Future<Either<ConsumptionFailures, Unit>> singleInsertConsumptionTransaction({required ConsumptionTransactionEntityModel model});
  Future<Either<ConsumptionFailures, Unit>> multipleInsertConsumptionTransaction({required List<ConsumptionTransactionEntityModel> list});
  ///save
  Future<Either<ConsumptionFailures, Unit>> saveConsumptionTransactionApiCall();
  ///fetch
  Future<Either<ConsumptionFailures, List<ConTransactionViewEntity>>> fetchAllConsumptionTransactionList();
  Future<Either<ConsumptionFailures, List<ConsumptionRfidListingViewEntity>>> fetchRfidScanningList({required List<String> rfIds});
  Future<Either<ConsumptionFailures, List<ConTransactionViewEntity>>> searchConTransactionDataFromDb({required String searchText});
  ///filter
  Future<Either<ConsumptionFailures, List<ConTransactionViewEntity>>> fetchConsumptionTransactionFilterList(String itemName,String articleNo);
  ///location
  Future<Either<ConsumptionFailures, Unit>> insertConsumptionLocationList();
  Future<Either<ConsumptionFailures, List<ConsumptionLocationEntity>>> fetchAllConsumptionLocationList();
  ///equipment
  Future<Either<ConsumptionFailures, Unit>> insertEquipmentList();
  ///fetch ROB -addConsumptionPage
  Future<Either<ConsumptionFailures, int>> fetchROBDetails({required int itemId});
}