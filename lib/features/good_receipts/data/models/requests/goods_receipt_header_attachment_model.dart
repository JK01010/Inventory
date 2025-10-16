import 'dart:convert';

class GoodsReceiptHeaderAttachmentModel {
  final String? applicationCode;
  final int? attachmentTypeId;
  final String? documentUniqueId;
  final int? gRnhdid;
  final int? iD;
  final String? operationType;
  final int? orgId;
  final String? pageCode;
  final int? versionIdentifier;

  GoodsReceiptHeaderAttachmentModel({
    this.applicationCode,
    this.attachmentTypeId,
    this.documentUniqueId,
    this.gRnhdid,
    this.iD,
    this.operationType,
    this.orgId,
    this.pageCode,
    this.versionIdentifier,
  });

  GoodsReceiptHeaderAttachmentModel copyWith({
    String? applicationCode,
    int? attachmentTypeId,
    String? documentUniqueId,
    int? gRnhdid,
    int? iD,
    String? operationType,
    int? orgId,
    String? pageCode,
    int? versionIdentifier,
  }) =>
      GoodsReceiptHeaderAttachmentModel(
        applicationCode: applicationCode ?? this.applicationCode,
        attachmentTypeId: attachmentTypeId ?? this.attachmentTypeId,
        documentUniqueId: documentUniqueId ?? this.documentUniqueId,
        gRnhdid: gRnhdid ?? this.gRnhdid,
        iD: iD ?? this.iD,
        operationType: operationType ?? this.operationType,
        orgId: orgId ?? this.orgId,
        pageCode: pageCode ?? this.pageCode,
        versionIdentifier: versionIdentifier ?? this.versionIdentifier,
      );

  factory GoodsReceiptHeaderAttachmentModel.fromRawJson(String str) => GoodsReceiptHeaderAttachmentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GoodsReceiptHeaderAttachmentModel.fromJson(Map<String, dynamic> json) => GoodsReceiptHeaderAttachmentModel(
    applicationCode: json["applicationCode"],
    attachmentTypeId: json["attachmentTypeID"],
    documentUniqueId: json["documentUniqueID"],
    gRnhdid: json["gRNHDID"],
    iD: json["iD"],
    operationType: json["operationType"],
    orgId: json["orgID"],
    pageCode: json["pageCode"],
    versionIdentifier: json["versionIdentifier"],
  );

  Map<String, dynamic> toJson() => {
    "applicationCode": applicationCode,
    "attachmentTypeID": attachmentTypeId,
    "documentUniqueID": documentUniqueId,
    "gRNHDID": gRnhdid,
    "iD": iD,
    "operationType": operationType,
    "orgID": orgId,
    "pageCode": pageCode,
    "versionIdentifier": versionIdentifier,
  };
}