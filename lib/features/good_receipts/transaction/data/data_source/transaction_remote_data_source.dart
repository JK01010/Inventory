import 'dart:developer';

import 'package:encrypt_shared_preferences/provider.dart';

import '../../../../../config/default_api_payload.dart';
import '../../../../../config/network_config.dart';
import '../../../../../core/constants/api_constant.dart';
import '../../../../../core/constants/app_encrypted_storage_keys.dart';
import '../../../data/models/transaction_filter_model.dart';
import '../model/transaction_model.dart';

abstract interface class TransactionRemoteDataSource {
  Future<List<TransactionModel>> getAllTransactions({
    TransactionFilterModel? transactionFilterModel,
  });
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  TransactionRemoteDataSourceImpl({
    required this.encryptedSharedPreferences,
    required this.appNetworkClient,
  });

  final EncryptedSharedPreferences encryptedSharedPreferences;
  final AppNetworkClient appNetworkClient;

  @override
  Future<List<TransactionModel>> getAllTransactions({
    TransactionFilterModel? transactionFilterModel,
  }) async {
    // String? lastModifiedTimeStamp = encryptedSharedPreferences.getString(
    //   AppEncryptedStorageKeys.lastModifiedTimeStampInsList,
    // );
    var filters = [
      FilterCondition(field: "GrnId", operator: "gt", value: "0"),
      // FilterCondition(
      //   field: "ModifiedOn",
      //   operator: "gt",
      //   value: lastModifiedTimeStamp,
      // ),
    ];

    DefaultApiPayload apiPayload = DefaultApiPayload(
      fields: [
        Field(field: "GrnId"),
        Field(field: "ReceiptNo"),
        Field(field: "ReceiptDate"),
        Field(field: "PoNo"),
        Field(field: "PoId"),
        Field(field: "Insights"),
        Field(field: "ReqCategoryID"),
        Field(field: "Category"),
        Field(field: "PriorityID"),
        Field(field: "Priority"),
        Field(field: "VendorID"),
        Field(field: "VendorName"),
        Field(field: "DelivryDate"),
        Field(field: "DeliveryToID"),
        Field(field: "DlvryTO"),
        Field(field: "POtitle"),
        Field(field: "TotalNOofprudcts"),
        Field(field: "PlannedNoOfPdcts"),
        Field(field: "EntityID"),
        Field(field: "Entity"),
        Field(field: "RemarksForVendor"),
        Field(field: "pocost"),
        Field(field: "Weight"),
        Field(field: "Actualvolume"),
        Field(field: "CurrencyName"),
        Field(field: "NoOfPackets"),
        Field(field: "PresentProperties"),
        Field(field: "DeliveryToLocationID"),
        Field(field: "DeliveryToLocation"),
        Field(field: "TotalAmountReportingCurrency"),
        Field(field: "PoRemarks"),
        Field(field: "IsBaggingCompleted"),
        Field(field: "WorkFlowID"),
        Field(field: "WorkFlowStatusID"),
        Field(field: "ModifiedOn"),
        Field(field: "PortID"),
        Field(field: "IsFull"),
        Field(field: "DeliveryReference"),
        Field(field: "IsBaggingTaggingApplicable"),
      ],
      filter: FilterGroup(logic: "and", filters: filters),
      sort: [SortOption(field: "PoId", direction: "Desc")],
      paginationParams: PaginationParams(pageNo: 1, pageSize: 1000),
    );

    final response = await appNetworkClient.post(
      ApiConstant.fetchGoodsReceiptTransactionGRNItems,
      data: apiPayload.toJson(),
    );

    final data = TransactionResponseModel.fromJson(response);

    final List<TransactionModel> goodsReceiptTransactionList =
        data.reportData ?? [];

    return goodsReceiptTransactionList;
  }
}
