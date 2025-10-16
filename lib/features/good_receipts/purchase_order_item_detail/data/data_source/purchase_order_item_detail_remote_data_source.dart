import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../../../config/default_api_payload.dart';
import '../../../../../config/dropdown_payload.dart';
import '../../../../../config/network_config.dart';
import '../../../../../core/constants/api_constant.dart';
import '../../../../../core/constants/constant.dart';
import '../../../../common_feature/data/model/fetch_imdg_class_model.dart';
import '../../../../common_feature/data/model/quality_list_model.dart';
import '../models/serial_number_data.dart';

abstract interface class PurchaseOrderItemDetailRemoteDataSource {
  Future<QualityListResponseModel?> getQualityList();

  Future<ImdgClassResponseModel?> getImdgClass();

  Future<List<SerialNumberData>?> generateSerialNumbers({
    required String vesselCode,
    required int referenceTypeId,
    required int referenceId,
    required int referenceSubId,
    required double quantity,
  });
}

class PurchaseOrderItemDetailRemoteDataSourceImpl
    implements PurchaseOrderItemDetailRemoteDataSource {
  PurchaseOrderItemDetailRemoteDataSourceImpl({required this.appNetworkClient});

  final AppNetworkClient appNetworkClient;

  @override
  Future<QualityListResponseModel?> getQualityList() async {
    DefaultApiPayload apiPayload = DefaultApiPayload(
      fields: [
        Field(field: "ID"),
        Field(field: "HDID"),
        Field(field: "HDCode"),
        Field(field: "Code"),
        Field(field: "TypeName"),
        Field(field: "IsActive"),
        Field(field: "SortOrder"),
        Field(field: "Remarks"),
        Field(field: "CreatedByID"),
        Field(field: "CreatedOn"),
        Field(field: "ModifiedByID"),
        Field(field: "ModifiedOn"),
      ],
      filter: FilterGroup(logic: "and", filters: []),
      sort: [],
      paginationParams: PaginationParams(
        pageNo: 1,
        pageSize: AppConstant.pageSize,
      ),
    );

    final response = await appNetworkClient.post(
      ApiConstant.fetchQualityAdmin,
      data: apiPayload.toJson(),
    );
    return QualityListResponseModel.fromJson(response);
  }

  @override
  Future<ImdgClassResponseModel?> getImdgClass() async {
    DropdownApiPayload apiPayload = DropdownApiPayload(
      pagination: PaginationParams(pageNo: 1, pageSize: AppConstant.pageSize),
      tags: ["dropdownSearch"],
    );
    final response = await appNetworkClient.post(
      ApiConstant.fetchIMDGClass,
      data: apiPayload.toJson(),
    );
    return ImdgClassResponseModel.fromJson(response);
  }

  @override
  Future<List<SerialNumberData>?> generateSerialNumbers({
    required String vesselCode,
    required int referenceTypeId,
    required int referenceId,
    required int referenceSubId,
    required double quantity,
  }) async {
    final Map<String, dynamic> apiPayload = {
      "VesselCode": vesselCode,
      "ReferenceTypeID": referenceTypeId,
      "ReferenceID": referenceId,
      "ReferenceSubID": referenceSubId,
      "Quantity": quantity.toInt(),
    };
    debugPrint("generateSerialNumbers apiPayload : $apiPayload");
    final response = await appNetworkClient.post(
      ApiConstant.generateSerialNumbers,
      data: jsonEncode(apiPayload),
    );
    debugPrint("generateSerialNumbers response : $response");
    if (response is List) {
      return response.map((e) => SerialNumberData.fromJson(e)).toList();
    }
    return null;
  }
}
