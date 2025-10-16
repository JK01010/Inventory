import '../../../../../config/default_api_payload.dart';
import '../../../../../config/network_config.dart';
import '../../../../../core/constants/api_constant.dart';
import '../../../../../core/constants/constant.dart';
import '../model/purchase_order_model.dart';

abstract class PurchaseOrderNetworkDataSource {
  Future<PurchaseOrderResponseModel?> getAllPurchaseOrderFromApi();
}

class PurchaseOrderNetworkDataSourceImpl
    implements PurchaseOrderNetworkDataSource {
  PurchaseOrderNetworkDataSourceImpl({required this.appNetworkClient});

  final AppNetworkClient appNetworkClient;
  @override
  Future<PurchaseOrderResponseModel?> getAllPurchaseOrderFromApi() async {
    List<FilterCondition> filters = [
      FilterCondition(
        field: "DeliveryStatusID",
        operator: "isnull",
        value: null,
      ),
    ];

    DefaultApiPayload apiPayload = DefaultApiPayload(
      fields: [
        Field(field: "POCode"),
        Field(field: "POHDID"),
        Field(field: "RequisitionCategory"),
        Field(field: "VendorName"),
        Field(field: "Title"),
        Field(field: "Priority"),
        Field(field: "VendorDeliveryDate"),
        Field(field: "VendorReference"),
        Field(field: "BudgetDate"),
        Field(field: "Entity"),
        Field(field: "Currency"),
        Field(field: "Payment"),
        Field(field: "PaymentTerms"),
        Field(field: "RemarksToVendor"),
        Field(field: "PaymentDueAfterDays"),
        Field(field: "CreatedBy"),
        Field(field: "PostInvoicePO"),
        Field(field: "ExportControl"),
        Field(field: "ExportControlBlock"),
        Field(field: "RemarksFromVendor"),
        Field(field: "DeliveryTo"),
        Field(field: "PlaceOfProcurement"),
        Field(field: "LeadDays"),
        Field(field: "DeliveryTerms"),
        Field(field: "DeliveryPort"),
        Field(field: "WareHouseName"),
        Field(field: "POCreatedOn"),
        Field(field: "Vessel"),
        Field(field: "PortCode"),
        Field(field: "PortCountryName"),
        Field(field: "PortCountryCode"),
        Field(field: "TotalAmount"),
        Field(field: "TotalAmountBaseCurrency"),
        Field(field: "TotalAmountReportingCurrency"),
        Field(field: "HeaderDiscount"),
        Field(field: "VesselIMO"),
        Field(field: "VesselCode"),
        Field(field: "PriorityCode"),
        Field(field: "DeliveryTermsCode"),
        Field(field: "ReqCategoryCode"),
        Field(field: "CurrencyCode"),
        Field(field: "VendorEmail"),
        Field(field: "VendorShortName"),
        Field(field: "ShipservQuoteId"),
        Field(field: "SiteId"),
        Field(field: "VendorID"),
        Field(field: "SupplierZipCode"),
        Field(field: "ReferenceTypeID"),
        Field(field: "ReferenceID"),
        Field(field: "ReferenceSubID"),
        Field(field: "RequisitionCategoryId"),
        Field(field: "BuyerName"),
        Field(field: "RevisionNo"),
        Field(field: "RecSparesToBring"),
        Field(field: "ServiceDescription"),
        Field(field: "RoleCode"),
        Field(field: "PortID"),
        Field(field: "DeliveryToID"),
      ],
      filter: FilterGroup(logic: "and", filters: filters),
      sort: [SortOption(field: "POHDID", direction: "desc")],
      paginationParams: PaginationParams(
        pageNo: 1,
        pageSize: AppConstant.pageSize,
      ),
    );

    final response = await appNetworkClient.post(
      ApiConstant.fetchGoodsReceiptPoHeaderItems,
      data: apiPayload.toJson(),
    );

    final PurchaseOrderResponseModel purchaseOrderResponseModel =
        PurchaseOrderResponseModel.fromJson(response);

    return purchaseOrderResponseModel;
  }
}
