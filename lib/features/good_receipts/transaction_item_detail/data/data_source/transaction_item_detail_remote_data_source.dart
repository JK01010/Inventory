import '../../../../../config/default_api_payload.dart';
import '../../../../../config/network_config.dart';
import '../../../../../core/constants/api_constant.dart';
import '../../../../../core/constants/constant.dart';
import '../models/split_location_model.dart';
import '../models/transaction_item_detail_model.dart';

abstract interface class TransactionItemDetailRemoteDataSource {
  Future<TransactionItemDetailResponseModel?> getAllTransactionItemDetail({
    String? lastModifiedDate,
  });

  Future<SplitLocationModel?> getSplitLocationData();
}

class TransactionItemDetailRemoteDataSourceImpl
    implements TransactionItemDetailRemoteDataSource {
  TransactionItemDetailRemoteDataSourceImpl({required this.appNetworkClient});

  final AppNetworkClient appNetworkClient;

  @override
  Future<TransactionItemDetailResponseModel?> getAllTransactionItemDetail({
    String? lastModifiedDate,
  }) async {
    List<FilterCondition> filters = [
      FilterCondition(field: "grnID", operator: "gt", value: 0),
    ];
    if (lastModifiedDate != null) {
      filters.add(
        FilterCondition(
          field: "ModifiedOn",
          operator: "gt",
          value: lastModifiedDate,
        ),
      );
    }

    DefaultApiPayload apiPayload = DefaultApiPayload(
      fields: [
        Field(field: "PoID"),
        Field(field: "poNo"),
        Field(field: "grnID"),
        Field(field: "GRNDTID"),
        Field(field: "grnNo"),
        Field(field: "itemID"),
        Field(field: "itemVersionID"),
        Field(field: "itemLinkID"),
        Field(field: "parentItemID"),
        Field(field: "parentItemVersionID"),
        Field(field: "parentItemLinkID"),
        Field(field: "receivedQty"),
        Field(field: "convertedStockQty"),
        Field(field: "newStock"),
        Field(field: "damagedOrwrongSupply"),
        Field(field: "reconditionedStock"),
        Field(field: "expiryDate"),
        Field(field: "uomID"),
        Field(field: "qualityID"),
        Field(field: "batchNo"),
        Field(field: "remarks"),
        Field(field: "isMD"),
        Field(field: "isSDOC"),
        Field(field: "zeroDeclaration"),
        Field(field: "ihmMaterialQty"),
        Field(field: "articleNo"),
        Field(field: "productName"),
        Field(field: "productDescription"),
        Field(field: "eccnNo"),
        Field(field: "hsCode"),
        Field(field: "countryName"),
        Field(field: "isAntiPiracy"),
        Field(field: "isPyroTechnics"),
        Field(field: "imdgClassID"),
        Field(field: "className"),
        Field(field: "partNo"),
        Field(field: "categoryName"),
        Field(field: "itemCategoryID"),
        Field(field: "itemSectionID"),
        Field(field: "sectionName"),
        Field(field: "itemSubSectionID"),
        Field(field: "subSectionName"),
        Field(field: "itemUom"),
        Field(field: "isExportControl"),
        Field(field: "isIHM"),
        Field(field: "isCritical"),
        Field(field: "isIMDG"),
        Field(field: "vessel"),
        Field(field: "POQuantity"),
        Field(field: "isBagTagItem"),
        Field(field: "DrawingPositionNumber"),
        Field(field: "DrawingNumber"),
        Field(field: "UnitPrice"),
        Field(field: "EquipmentID"),
        Field(field: "EquipmentName"),
        Field(field: "podtid"),
        Field(field: "ModifiedOn"),
      ],
      filter: FilterGroup(logic: "and", filters: filters),
      sort: [SortOption(field: "grnID", direction: "Asc")],
      paginationParams: PaginationParams(
        pageNo: 1,
        pageSize: AppConstant.pageSize,
      ),
    );

    final response = await appNetworkClient.post(
      ApiConstant.fetchAllGRNTransactionItems,
      data: apiPayload.toJson(),
    );

    final TransactionItemDetailResponseModel
    transactionItemDetailResponseModel =
        TransactionItemDetailResponseModel.fromJson(response);

    return transactionItemDetailResponseModel;
  }

  @override
  Future<SplitLocationModel?> getSplitLocationData() async {
    DefaultApiPayload apiPayload = DefaultApiPayload(
      fields: [
        Field(field: "ID"),
        Field(field: "GRNHDID"),
        Field(field: "GRNDTID"),
        Field(field: "StorageLocationID"),
        Field(field: "Code"),
        Field(field: "LocationName"),
        Field(field: "Description"),
        Field(field: "ItemID"),
        Field(field: "ParentItemID"),
        Field(field: "TypeID"),
        Field(field: "Quantity"),
        Field(field: "ParentID"),
        Field(field: "IsActive"),
        Field(field: "LocationHierarchy"),
      ],
      filter: FilterGroup(logic: "and", filters: []),
      paginationParams: PaginationParams(
        pageNo: 1,
        pageSize: AppConstant.pageSize,
      ),
    );
    final response = await appNetworkClient.post(
      ApiConstant.grnLocationMapping1,
      data: apiPayload.toJson(),
    );
    return SplitLocationModel.fromJson(response);
  }
}
