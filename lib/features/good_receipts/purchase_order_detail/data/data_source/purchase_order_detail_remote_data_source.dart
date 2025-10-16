import '../../../../../config/default_api_payload.dart';
import '../../../../../config/network_config.dart';
import '../../../../../core/constants/api_constant.dart';
import '../../../../../core/constants/constant.dart';
import '../../../purchase_order/data/model/purchase_order_attachment_model.dart';
import '../models/purchase_order_items_list_model.dart';

abstract interface class PurchaseOrderDetailRemoteDataSource {
  Future<PurchaseOrderItemsResponseModel?> getPurchaseOrderItems({
    String? lastModifiedDate,
  });

  Future<PurchaseOrderAttachmentModelResponseModel?>
  getPurchaseOrderAttachments();

  Future<List<PurchaseOrderAttachmentModel>>
  getPurchaseOrderAttachmentsMetaData({required List<String> uniqueIdList});
}

class PurchaseOrderDetailRemoteDataSourceImpl
    implements PurchaseOrderDetailRemoteDataSource {
  PurchaseOrderDetailRemoteDataSourceImpl({required this.appNetworkClient});

  final AppNetworkClient appNetworkClient;

  @override
  Future<PurchaseOrderItemsResponseModel?> getPurchaseOrderItems({
    String? lastModifiedDate,
  }) async {
    List<FilterCondition> filters = [];
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
        Field(field: "PODTID"),
        Field(field: "SLNO"),
        Field(field: "PartNumber"),
        Field(field: "ProductName"),
        Field(field: "UOMID"),
        Field(field: "PackSize"),
        Field(field: "Quantity"),
        Field(field: "ROB"),
        Field(field: "ProductDescription"),
        Field(field: "UnitPrice"),
        Field(field: "ContractPrice"),
        Field(field: "DiscountPercentage"),
        Field(field: "Discount"),
        Field(field: "VATID"),
        Field(field: "VATPercentage"),
        Field(field: "AccountID"),
        Field(field: "AccountCode"),
        Field(field: "AccountName"),
        Field(field: "SubAccountID"),
        Field(field: "SubAccountCode"),
        Field(field: "SubAccountName"),
        Field(field: "AnalysisCodeID"),
        Field(field: "AnalysisCode"),
        Field(field: "AnalysisName"),
        Field(field: "LeadDays"),
        Field(field: "VendorDeliveryDate"),
        Field(field: "RemarksToVendor"),
        Field(field: "IsMD"),
        Field(field: "IsSDOC"),
        Field(field: "ZeroDeclaration"),
        Field(field: "IHMMaterialQty"),
        Field(field: "EccnNo"),
        Field(field: "HSCode"),
        Field(field: "CountryName"),
        Field(field: "PARTNO"),
        Field(field: "CategoryName"),
        Field(field: "ItemCategoryID"),
        Field(field: "ItemSectionID"),
        Field(field: "SectionName"),
        Field(field: "itemSubSectionID"),
        Field(field: "SubSectionName"),
        Field(field: "Vessel"),
        Field(field: "Entity"),
        Field(field: "EntityID"),
        Field(field: "POHDID"),
        Field(field: "ItemId"),
        Field(field: "ArticleNumber"),
        Field(field: "ItemUom"),
        Field(field: "PackUOM"),
        Field(field: "ServiceDescription"),
        Field(field: "EquipmentName"),
        Field(field: "EquipmentDescription"),
        Field(field: "EquipmentModelNumber"),
        Field(field: "EquimentSerialNo"),
        Field(field: "EquipmentManufacturer"),
        Field(field: "DeliveryCode"),
        Field(field: "DeliveryTypeName"),
        Field(field: "UniqueItemReference"),
        Field(field: "IsDeleted"),
        Field(field: "ItemLinkID"),
        Field(field: "ItemVersionID"),
        Field(field: "ParentID"),
        Field(field: "ParentItemLinkID"),
        Field(field: "ParentItemVersionID"),
        Field(field: "IMDGCode"),
        Field(field: "IMDGName"),
        Field(field: "ExportControl"),
        Field(field: "DrawingNumber"),
        Field(field: "ModifiedOn"),
      ],
      filter: FilterGroup(logic: "and", filters: filters),
      sort: [SortOption(field: "PODTID", direction: "Desc")],
      paginationParams: PaginationParams(
        pageNo: 1,
        pageSize: AppConstant.pageSize,
      ),
    );

    final response = await appNetworkClient.post(
      ApiConstant.fetchGoodsReceiptPoLineItems,
      data: apiPayload.toJson(),
    );
    return PurchaseOrderItemsResponseModel.fromJson(response);
  }

  @override
  Future<PurchaseOrderAttachmentModelResponseModel?>
  getPurchaseOrderAttachments() async {
    DefaultApiPayload apiPayload = DefaultApiPayload(
      fields: [
        Field(field: "ID"),
        Field(field: "POHDID"),
        Field(field: "ApplicationCode"),
        Field(field: "PageCode"),
        Field(field: "DocumentUniqueID"),
        Field(field: "POSentIntDetailsID"),
        Field(field: "ERCode"),
        Field(field: "CreatedByID"),
        Field(field: "CreatedOn"),
      ],
      filter: FilterGroup(logic: "and", filters: []),
      sort: [],
      paginationParams: PaginationParams(
        pageNo: 1,
        pageSize: AppConstant.pageSize,
      ),
    );

    final response = await appNetworkClient.post(
      ApiConstant.purchaseOrderAttachment,
      data: apiPayload.toJson(),
    );
    return PurchaseOrderAttachmentModelResponseModel.fromJson(response);
  }

  @override
  Future<List<PurchaseOrderAttachmentModel>>
  getPurchaseOrderAttachmentsMetaData({
    required List<String> uniqueIdList,
  }) async {
    final response = await appNetworkClient.post(
      ApiConstant.poMetaData,
      data: {"uniqueId": uniqueIdList},
    );
    final List<Map<String, dynamic>> attachmentData =
        response["documentDetails"];

    final List<PurchaseOrderAttachmentModel> attachmentModelList =
        attachmentData.map(PurchaseOrderAttachmentModel.fromJson).toList();
    return attachmentModelList;
  }
}
