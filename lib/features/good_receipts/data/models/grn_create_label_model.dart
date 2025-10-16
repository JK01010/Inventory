import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../../domain/entities/grn_create_label_entity.dart';

class GRNCreateLabelModel extends Equatable {
  final String? moduleCode;
  final String? entityName;
  final List<GRNCreateLabelReportData>? reportData;
  final int? recordCount;
  final EntityValidation? entityValidation;

  const GRNCreateLabelModel({
    this.moduleCode,
    this.entityName,
    this.reportData,
    this.recordCount,
    this.entityValidation,
  });

  GRNCreateLabelModel copyWith({
    String? moduleCode,
    String? entityName,
    List<GRNCreateLabelReportData>? reportData,
    int? recordCount,
    EntityValidation? entityValidation,
  }) =>
      GRNCreateLabelModel(
        moduleCode: moduleCode ?? this.moduleCode,
        entityName: entityName ?? this.entityName,
        reportData: reportData ?? this.reportData,
        recordCount: recordCount ?? this.recordCount,
        entityValidation: entityValidation ?? this.entityValidation,
      );

  factory GRNCreateLabelModel.fromRawJson(String str) =>
      GRNCreateLabelModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GRNCreateLabelModel.fromJson(Map<String, dynamic> json) =>
      GRNCreateLabelModel(
        moduleCode: json["moduleCode"],
        entityName: json["entityName"],
        reportData: json["reportData"] == null
            ? []
            : List<GRNCreateLabelReportData>.from(
            json["reportData"]!.map((x) => GRNCreateLabelReportData.fromJson(x))),
        recordCount: json["recordCount"],
        entityValidation: json["entityValidation"] == null
            ? null
            : EntityValidation.fromJson(json["entityValidation"]),
      );

  Map<String, dynamic> toJson() => {
    "moduleCode": moduleCode,
    "entityName": entityName,
    "reportData": reportData == null
        ? []
        : List<dynamic>.from(reportData!.map((x) => x.toJson())),
    "recordCount": recordCount,
    "entityValidation": entityValidation?.toJson(),
  };

  @override
  List<Object?> get props => [
    moduleCode,
    entityName,
    reportData,
    recordCount,
    entityValidation,
  ];
}

class EntityValidation extends Equatable {
  final bool? status;
  final List<dynamic>? validationMessages;

  const EntityValidation({
    this.status,
    this.validationMessages,
  });

  EntityValidation copyWith({
    bool? status,
    List<dynamic>? validationMessages,
  }) =>
      EntityValidation(
        status: status ?? this.status,
        validationMessages: validationMessages ?? this.validationMessages,
      );

  factory EntityValidation.fromRawJson(String str) =>
      EntityValidation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EntityValidation.fromJson(Map<String, dynamic> json) =>
      EntityValidation(
        status: json["status"],
        validationMessages: json["validationMessages"] == null
            ? []
            : List<dynamic>.from(json["validationMessages"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "validationMessages": validationMessages == null
        ? []
        : List<dynamic>.from(validationMessages!.map((x) => x)),
  };

  @override
  List<Object?> get props => [status, validationMessages];
}

class GRNCreateLabelReportData extends Equatable {
  final int? itemId;
  final String? articleCode;
  final String? itemName;
  final int? uomId;
  final String? uom;
  final String? partNumber;
  final String? drawingNumber;
  final String? drawingPositionNumber;
  final String? receiptDate;
  final int? storageLocationId;
  final String? storageLocationName;
  final String? serialNumber;
  final int? grnhdid;

  const GRNCreateLabelReportData({
    this.itemId,
    this.articleCode,
    this.itemName,
    this.uomId,
    this.uom,
    this.partNumber,
    this.drawingNumber,
    this.drawingPositionNumber,
    this.receiptDate,
    this.storageLocationId,
    this.storageLocationName,
    this.serialNumber,
    this.grnhdid,
  });

  GRNCreateLabelReportData copyWith({
    int? itemId,
    String? articleCode,
    String? itemName,
    int? uomId,
    String? uom,
    String? partNumber,
    String? drawingNumber,
    String? drawingPositionNumber,
    String? receiptDate,
    int? storageLocationId,
    String? storageLocationName,
    String? serialNumber,
    int? grnhdid,
  }) =>
      GRNCreateLabelReportData(
        itemId: itemId ?? this.itemId,
        articleCode: articleCode ?? this.articleCode,
        itemName: itemName ?? this.itemName,
        uomId: uomId ?? this.uomId,
        uom: uom ?? this.uom,
        partNumber: partNumber ?? this.partNumber,
        drawingNumber: drawingNumber ?? this.drawingNumber,
        drawingPositionNumber: drawingPositionNumber ?? this.drawingPositionNumber,
        receiptDate: receiptDate ?? this.receiptDate,
        storageLocationId: storageLocationId ?? this.storageLocationId,
        storageLocationName: storageLocationName ?? this.storageLocationName,
        serialNumber: serialNumber ?? this.serialNumber,
        grnhdid: grnhdid ?? this.grnhdid,
      );

  factory GRNCreateLabelReportData.fromRawJson(String str) =>
      GRNCreateLabelReportData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GRNCreateLabelReportData.fromJson(Map<String, dynamic> json) =>
      GRNCreateLabelReportData(
        itemId: json["ItemID"],
        articleCode: json["ArticleCode"],
        itemName: json["ItemName"],
        uomId: json["UomID"],
        uom: json["UOM"],
        partNumber: json["PartNumber"],
        drawingNumber: json["DrawingNumber"],
        drawingPositionNumber: json["DrawingPositionNumber"],
        receiptDate: json["ReceiptDate"],
        storageLocationId: json["StorageLocationID"],
        storageLocationName: json["StorageLocationName"],
        serialNumber: json["SerialNumber"],
        grnhdid: json["GRNHDID"],
      );

  Map<String, dynamic> toJson() => {
    "ItemID": itemId,
    "ArticleCode": articleCode,
    "ItemName": itemName,
    "UomID": uomId,
    "UOM": uom,
    "PartNumber": partNumber,
    "DrawingNumber": drawingNumber,
    "DrawingPositionNumber": drawingPositionNumber,
    "ReceiptDate": receiptDate,
    "StorageLocationID": storageLocationId,
    "StorageLocationName": storageLocationName,
    "SerialNumber": serialNumber,
    "GRNHDID": grnhdid,
  };




  /// Convert Model → Entity
  GRNCreateLabelEntity toEntity() {
    return GRNCreateLabelEntity(
      itemId: itemId ?? 0,
      articleCode: articleCode ?? '',
      itemName: itemName ?? '',
      uomId: uomId ?? 0,
      uom: uom ?? '',
      partNumber: partNumber ?? '',
      drawingNumber: drawingNumber ?? '',
      drawingPositionNumber: drawingPositionNumber ?? '',
      receiptDate: receiptDate ?? '',
      storageLocationId: storageLocationId ?? 0,
      storageLocationName: storageLocationName ?? '',
      serialNumber: serialNumber ?? '',
      grnHdId: grnhdid ?? 0,
    );
  }

  /// Convert Entity → Model
  factory GRNCreateLabelReportData.fromEntity(GRNCreateLabelEntity entity) {
    return GRNCreateLabelReportData(
      itemId: entity.itemId,
      articleCode: entity.articleCode,
      itemName: entity.itemName,
      uomId: entity.uomId,
      uom: entity.uom,
      partNumber: entity.partNumber,
      drawingNumber: entity.drawingNumber,
      drawingPositionNumber: entity.drawingPositionNumber,
      receiptDate: entity.receiptDate,
      storageLocationId: entity.storageLocationId,
      storageLocationName: entity.storageLocationName,
      serialNumber: entity.serialNumber,
      grnhdid: entity.grnHdId,
    );
  }

  @override
  List<Object?> get props => [
    itemId,
    articleCode,
    itemName,
    uomId,
    uom,
    partNumber,
    drawingNumber,
    drawingPositionNumber,
    receiptDate,
    storageLocationId,
    storageLocationName,
    serialNumber,
    grnhdid,
  ];
}