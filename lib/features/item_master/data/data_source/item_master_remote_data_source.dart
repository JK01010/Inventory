import 'dart:developer';

import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../config/default_api_payload.dart';
import '../../../../config/network_config.dart';
import '../../../../core/constants/api_constant.dart';
import '../../../../core/constants/app_encrypted_storage_keys.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/service/db_service/table_data_manipulation/item_master_data_processor.dart';
import '../../../../core/service/network/api_logging_interceptor.dart';
import '../../../../core/utils/app_logger.dart';
import '../models/item_master_api_response_model.dart';
import '../models/ports_list_common_response_model.dart';

abstract interface class ItemMasterRemoteDataSource {
  Future<void> getAllItemMasterPurchase();
  Future<void> getAllItemMasterPms();
}

class ItemMasterRemoteDataSourceImpl implements ItemMasterRemoteDataSource {
  ItemMasterRemoteDataSourceImpl({
    required this.appNetworkClient,
    required this.encryptedSharedPreferences,
    required this.itemMasterDataProcessor,
  });

  final AppNetworkClient appNetworkClient;
  final EncryptedSharedPreferences encryptedSharedPreferences;
  final ItemMasterDataProcessor itemMasterDataProcessor;

  @override
  Future<void> getAllItemMasterPurchase() async {
    var lastModifiedTimeStamp = encryptedSharedPreferences.getString(
      AppEncryptedStorageKeys.lastModifiedTimeStampInsItemMaster,
    );

    var filters = [
      FilterCondition(field: "NoOfPackets", operator: "gt", value: "0"),
    ];

    if (lastModifiedTimeStamp != null) {
      filters.add(
        FilterCondition(
          field: "ModifiedOn",
          operator: "gt",
          value: lastModifiedTimeStamp,
        ),
      );
    }

    DefaultApiPayload apiPayload = DefaultApiPayload(
      /*fields: [
        Field(field: "GroupId"),
        Field(field: "ItemID"),
        Field(field: "ItemCode"),
        Field(field: "ItemName"),
        Field(field: "ItemDescription"),
        Field(field: "UomID"),
        Field(field: "UomCode"),
        Field(field: "UomName"),
        Field(field: "PackagingUOM"),
        Field(field: "IsActive"),
        Field(field: "CategoryID"),
        Field(field: "CategoryCode"),
        Field(field: "CategoryName"),
        Field(field: "SectionID"),
        Field(field: "SectionCode"),
        Field(field: "SectionName"),
        Field(field: "SubSectionID"),
        Field(field: "SubsectionCode"),
        Field(field: "SubsectionName"),
        Field(field: "PartNumber"),
        Field(field: "ItemLinkID"),
        Field(field: "PropertiesID"),
        Field(field: "PropertyVersionNO"),
        Field(field: "VersionNo"),
        Field(field: "ItemSpecification"),
        Field(field: "IsExportControl"),
        Field(field: "IsIHM"),
        Field(field: "IsIMDG"),
        Field(field: "UsContent"),
        Field(field: "IMDGClass"),
        Field(field: "MD"),
        Field(field: "Sdoc"),
        Field(field: "EccnNo"),
        Field(field: "HsCode"),
        Field(field: "CountryOfOrgin"),
        Field(field: "PackSize"),
        Field(field: "TBN"),
        Field(field: "Density"),
        Field(field: "IsAntiPiracy"),
        Field(field: "UOMQuantity"),
        Field(field: "PackagingUOMID"),
        Field(field: "ReOrderQuantity"),
      ],*/
      fields: [
        Field(field: "GroupId"),
        Field(field: "ItemID"),
        Field(field: "ItemCode"),
        Field(field: "ItemName"),
        Field(field: "PartNumber"),
        Field(field: "UomID"),
        Field(field: "UomCode"),
        Field(field: "UomName"),
        Field(field: "CategoryID"),
        Field(field: "SectionID"),
        Field(field: "SubSectionID"),
        Field(field: "IsActive"),
        Field(field: "MD"),
        Field(field: "Sdoc"),
        Field(field: "IsIHM"),
        Field(field: "PackSize"),
        Field(field: "IMDGClass"),
      ],
      filter: FilterGroup(logic: "and", filters: []),
      paginationParams: PaginationParams(pageNo: 0, pageSize: 5000),
    );

    final response = await appNetworkClient.post(
      ApiConstant.fetchItemMasterDetailsPurchase,
      data: apiPayload.toJson(),
    );
    final data = ItemMasterApiResponseModelPurchase.fromJson(response);

    if (data.reportData != null && data.reportData!.isNotEmpty) {
      final List<ItemMasterApiModelPurchase> itemMasterList =
          data.reportData ?? [];
      await itemMasterDataProcessor.insertItemMasterListPurchase(
        itemMasterList: itemMasterList,
      );
    }
  }

  @override
  Future<void> getAllItemMasterPms() async {
    final filters = [
      FilterCondition(field: "ReferenceID", operator: "eq", value: 1),
      FilterCondition(field: "ReferenceSubID", operator: "eq", value: 13),
    ];

    final apiPayload = DefaultApiPayload(
      fields: [
        Field(field: "SpareID"),
        Field(field: "VesselEquipmentID"),
        Field(field: "EquipmentCode"),
        Field(field: "EquipmentName"),
        Field(field: "ParentEquipmentID"),
        Field(field: "ParentEquipmentName"),
        Field(field: "ParentEquipmentCode"),
        Field(field: "MakerID"),
        Field(field: "MakerName"),
        Field(field: "ModelID"),
        Field(field: "Model"),
        Field(field: "EquipmentTypeID"),
        Field(field: "EquipTypeName"),
        Field(field: "DrawingNumber"),
        Field(field: "PositionNumber"),
        Field(field: "PartNumber"),
        Field(field: "Specification"),
        Field(field: "Unit"),
        Field(field: "UomID"),
        Field(field: "ArticleNumber"),
        Field(field: "ItemName"),
        Field(field: "ItemDesc"),
        Field(field: "VersionNo"),
        Field(field: "ItemLinkId"),
        Field(field: "ItemId"),
        Field(field: "IsCritical"),
        Field(field: "IsExportControl"),
        Field(field: "IsIHM"),
        Field(field: "IsIMDG"),
        Field(field: "VesselComponentID"),
        Field(field: "ReferenceID"),
        Field(field: "ReferenceTypeID"),
        Field(field: "ReferenceSubID"),
        Field(field: "MinStock"),
        Field(field: "MaxStock"),
      ],
      /* fields: [
        Field(field: "EquipmentName"),
        Field(field: "EquipmentCode"),
        Field(field: "SpareID"),
        Field(field: "ItemId"),
        Field(field: "MinStock"),
        Field(field: "MaxStock"),
        Field(field: "DrawingNumber"),
        Field(field: "ArticleNumber"),
      ],*/
      filter: FilterGroup(logic: "and", filters: filters),
      paginationParams: PaginationParams(pageNo: 0, pageSize: 5000),
    );

    final response = await appNetworkClient.post(
      ApiConstant.fetchItemMasterDetailsPms,
      data: apiPayload.toJson(),
    );

    final data = ItemMasterApiResponseModelPms.fromJson(response);

    if (data.reportData != null && data.reportData!.isNotEmpty) {
      final List<ItemMasterApiModelPMS> itemMasterList = data.reportData ?? [];
      await itemMasterDataProcessor.insertItemMasterListPms(
        itemMasterList: itemMasterList,
      );
    }
  }
}
