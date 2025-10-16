import 'dart:developer';

import 'package:get_storage/get_storage.dart';

class ApiConstant {
  ApiConstant() {
    GetStorage storage = GetStorage();
    String? url = storage.read('vesselURL');
    if (url != null) {
      baseUrl = '$url/ApiGateway/Core/api/Entity/SPS/';
      baseUrl1 = url;
      apiPath = url;
      log("baseUrl = > $baseUrl");
      log("baseUrl1 = > $baseUrl1");
    }
  }

  static String apiPath = "";
  static String baseUrl = "$apiPath/ApiGateway/Core/api/Entity/SPS/";
  static final String pmsBaseUrl = "$apiPath/ApiGateway/Core/api/Entity/PMS/";

  // "https://ng-web.mariapps.com/apigateway/Core/api/Entity/SPS/";
  //  "https://palng-qa-vsl.mariapps.com/ApiGateway/Core/api/Entity/SPS/";

  static String baseUrl1 = apiPath;

  static const String pathOfGetApiBaseUrl = "/ApiGateway/mdm/api/";
  static const String pathOfGetApi = "/ApiGateway/mdm/api/Section/";
  static const String pathOfPostApi = "/ApiGateway/Core/api/Entity/SPS/";
  static const String pathOfPMSApi = "/ApiGateway/Core/api/Entity/PMS/";

  //IMDG class master
  static final String fetchIMDGClass = "${baseUrl}IMDGClass";

  //transaction listing with GRN
  static final String fetchGoodsReceiptTransactionGRNItems =
      "${baseUrl}POGRNDetails";

  //transaction GRN Item listing
  static String fetchAllGRNTransactionItems = "${baseUrl}GRNItemDetails";

  //storage location master
  static String fetchStorageLocation = "${baseUrl}StorageLocation";

  //item master
  static String fetchItemMaster = "${baseUrl}GRNItemDetails";

  //item Category
  static String fetchItemCategory = "${baseUrl}Itemcategory";

  //item section
  static String fetchItemSection = "${baseUrl}Itemsection";

  //item SubSection
  static String fetchItemSubSection = "${baseUrl}ItemSubSection";

  //Quality
  static String fetchQualityAdmin = "${baseUrl}AdminQualityInfo";

  ///FetchConsumptionTrn & FetchStockUpdateTrn
  static String stockTransactionHistory = "${baseUrl}StockTransactionHistory";

  ///SaveConsumptionTrn & SaveStockUpdateTrn
  // static const String stockTransaction = "${baseUrl}stockTransaction";
  static final String stockTransaction =
      "$apiPath/ApiGateway/SPS/api/Inventory/stockTransaction";

  ///FetchLocation
  static String fetchLocation =
      "$baseUrl1${pathOfGetApi}HierarchicalLocationLibrary";

  ///FetchEquipment
  static String fetchEquipment =
      "$baseUrl1${pathOfPMSApi}VesselComponentDetails";

  ///Port
  static String fetchPort = "$baseUrl1${pathOfGetApiBaseUrl}Port";

  // static final String fetchPort = "$baseUrl1${pathOfGetApiBaseUrl}Port";

  ///stock location
  static final String stockLocation = "${baseUrl}ItemRobDetails";

  ///GrnPacketDetails
  static final String fetchGrnPacketDetails = "${baseUrl}GRNPacketDetails";

  ///defaultLocation
  static final String defaultLocation = "${baseUrl}DefaultLocation";

  // static final String grnLocationMapping1 = "${baseUrl}GRNLocationMapping";
  static const String grnLocationMapping1 =
      "https://palng-qa-vsl.mariapps.com/ApiGateway/Core/api/Entity/SPS/GRNLocationMapping";

  ///grnLocationMapping
  // static final String grnLocationMapping = "${baseUrl}GRNLocationMapping";

  ///GRNLocationSerialMapping
  static final String grnLocationSerialMapping =
      "${baseUrl}GRNLocationSerialMapping";

  ///ItemDetailsList
  static final String fetchItemMasterDetailsPurchase =
      "${baseUrl}ItemDetailsList";
  static final String fetchItemMasterDetailsPms = "${pmsBaseUrl}PmsItem";

  ///ItemConfigEntity
  static final String fetchItemConfigEntity =
      "${baseUrl}ItemCategoryConfigEntity";

  ///

  //Pending Order list
  static final String fetchGoodsReceiptPoHeaderItems =
      "${baseUrl}poheaderdetails";

  //Pending Order list
  static final String fetchGoodsReceiptPoLineItems =
      "${baseUrl}POLineItemDetails";

  ///GrnCreateLabelEntity
  static final String grnCreateLabelEntity = "${baseUrl}GrnCreateLabelEntity";

  static String saveGoodsReceiptsApi =
      '$apiPath/ApiGateway/SPS/api/GoodsReceipt/GoodsReceiptNotePopulateAll';

  static String getAllVesselSpecification =
      '$apiPath/ApiGateway/mdm/api/VesselSpecification/AllVesselSpecifications';

  static String poMetaData =
      '$apiPath/ApiGateway/document/api/SPS/SPS_TRN_PO/metadata';
  static String purchaseOrderAttachment =
      '$apiPath/ApiGateway/Core/api/Entity/SPS/POAttachmentDetails';

  static String generateSerialNumbers = '$apiPath/ApiGateway/SPS/api/GoodsReceipt/GoodsReceiptInputSerial';

  static String adminStructure =
      '$apiPath/ApiGateway/SPS/api/AdminStructure/All';
}
