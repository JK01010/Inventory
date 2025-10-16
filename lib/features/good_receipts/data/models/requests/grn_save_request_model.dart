import 'dart:convert';
import 'goods_receipt_dt_model.dart';
import 'goods_receipt_hd_model.dart';
import 'goods_receipt_header_attachment_model.dart';
import 'grn_item_location_mapping_model.dart';
import 'grn_location_serial_mapping_model.dart';
import 'grn_packet_detail_model.dart';


class GrnSaveRequestModel {
  final String? statusCode;
  final GoodsReceiptHDModel? goodsReceiptHd;
  final List<GoodsReceiptDTModel>? goodsReceiptDt;
  final List<GoodsReceiptHeaderAttachmentModel>? goodsReceiptHeaderAttachment;
  final List<GrnItemLocationMappingModel>? grnItemLocationMapping;
  final List<GrnPacketDetailModel>? grnPacketDetail;
  final List<GrnLocationSerialMappingModel>? grnLocationSerialMapping;
  final String? vesselOrOffice;
  final String? vesselCode;
  final String? orderType;
  final String? isUpdateStock;
  final bool? isBaggingTaggingPendingTab;
  final bool? isBagTagCompleted;
  final List<dynamic>? grnhdOtherMapping;
  final List<dynamic>? grnItemUnitConversionFactorConfigMappers;

  GrnSaveRequestModel({
    this.statusCode,
    this.goodsReceiptHd,
    this.goodsReceiptDt,
    this.goodsReceiptHeaderAttachment,
    this.grnItemLocationMapping,
    this.grnPacketDetail,
    this.grnLocationSerialMapping,
    this.vesselOrOffice,
    this.vesselCode,
    this.orderType,
    this.isUpdateStock,
    this.isBaggingTaggingPendingTab,
    this.isBagTagCompleted,
    this.grnhdOtherMapping,
    this.grnItemUnitConversionFactorConfigMappers,
  });

  GrnSaveRequestModel copyWith({
    String? statusCode,
    GoodsReceiptHDModel? goodsReceiptHd,
    List<GoodsReceiptDTModel>? goodsReceiptDt,
    List<GoodsReceiptHeaderAttachmentModel>? goodsReceiptHeaderAttachment,
    List<GrnItemLocationMappingModel>? grnItemLocationMapping,
    List<GrnPacketDetailModel>? grnPacketDetail,
    List<GrnLocationSerialMappingModel>? grnLocationSerialMapping,
    String? vesselOrOffice,
    String? vesselCode,
    String? orderType,
    String? isUpdateStock,
    bool? isBaggingTaggingPendingTab,
    bool? isBagTagCompleted,
    List<dynamic>? grnhdOtherMapping,
    List<dynamic>? grnItemUnitConversionFactorConfigMappers,
  }) =>
      GrnSaveRequestModel(
        statusCode: statusCode ?? this.statusCode,
        goodsReceiptHd: goodsReceiptHd ?? this.goodsReceiptHd,
        goodsReceiptDt: goodsReceiptDt ?? this.goodsReceiptDt,
        goodsReceiptHeaderAttachment: goodsReceiptHeaderAttachment ?? this.goodsReceiptHeaderAttachment,
        grnItemLocationMapping: grnItemLocationMapping ?? this.grnItemLocationMapping,
        grnPacketDetail: grnPacketDetail ?? this.grnPacketDetail,
        grnLocationSerialMapping: grnLocationSerialMapping ?? this.grnLocationSerialMapping,
        vesselOrOffice: vesselOrOffice ?? this.vesselOrOffice,
        vesselCode: vesselCode ?? this.vesselCode,
        orderType: orderType ?? this.orderType,
        isUpdateStock: isUpdateStock ?? this.isUpdateStock,
        isBaggingTaggingPendingTab: isBaggingTaggingPendingTab ?? this.isBaggingTaggingPendingTab,
        isBagTagCompleted: isBagTagCompleted ?? this.isBagTagCompleted,
        grnhdOtherMapping: grnhdOtherMapping ?? this.grnhdOtherMapping,
        grnItemUnitConversionFactorConfigMappers: grnItemUnitConversionFactorConfigMappers ?? this.grnItemUnitConversionFactorConfigMappers,
      );

  factory GrnSaveRequestModel.fromRawJson(String str) => GrnSaveRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GrnSaveRequestModel.fromJson(Map<String, dynamic> json) => GrnSaveRequestModel(
    statusCode: json["StatusCode"],
    goodsReceiptHd: json["GoodsReceiptHD"] == null ? null : GoodsReceiptHDModel.fromJson(json["GoodsReceiptHD"]),
    goodsReceiptDt: json["GoodsReceiptDT"] == null ? [] : List<GoodsReceiptDTModel>.from(json["GoodsReceiptDT"]!.map((x) => GoodsReceiptDTModel.fromJson(x))),
    goodsReceiptHeaderAttachment: json["GoodsReceiptHeaderAttachment"] == null ? [] : List<GoodsReceiptHeaderAttachmentModel>.from(json["GoodsReceiptHeaderAttachment"]!.map((x) => GoodsReceiptHeaderAttachmentModel.fromJson(x))),
    grnItemLocationMapping: json["GRNItemLocationMapping"] == null ? [] : List<GrnItemLocationMappingModel>.from(json["GRNItemLocationMapping"]!.map((x) => GrnItemLocationMappingModel.fromJson(x))),
    grnPacketDetail: json["GRNPacketDetail"] == null ? [] : List<GrnPacketDetailModel>.from(json["GRNPacketDetail"]!.map((x) => GrnPacketDetailModel.fromJson(x))),
    grnLocationSerialMapping: json["grnLocationSerialMapping"] == null ? [] : List<GrnLocationSerialMappingModel>.from(json["grnLocationSerialMapping"]!.map((x) => GrnLocationSerialMappingModel.fromJson(x))),
    vesselOrOffice: json["VesselOrOffice"],
    vesselCode: json["VesselCode"],
    orderType: json["OrderType"],
    isUpdateStock: json["IsUpdateStock"],
    isBaggingTaggingPendingTab: json["isBaggingTaggingPendingTab"],
    isBagTagCompleted: json["isBagTagCompleted"],
    grnhdOtherMapping: json["grnhdOtherMapping"] == null ? [] : List<dynamic>.from(json["grnhdOtherMapping"]!.map((x) => x)),
    grnItemUnitConversionFactorConfigMappers: json["GRNItemUnitConversionFactorConfigMappers"] == null ? [] : List<dynamic>.from(json["GRNItemUnitConversionFactorConfigMappers"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "StatusCode": statusCode,
    "GoodsReceiptHD": goodsReceiptHd?.toJson(),
    "GoodsReceiptDT": goodsReceiptDt == null ? [] : List<dynamic>.from(goodsReceiptDt!.map((x) => x.toJson())),
    "GoodsReceiptHeaderAttachment": goodsReceiptHeaderAttachment == null ? [] : List<dynamic>.from(goodsReceiptHeaderAttachment!.map((x) => x.toJson())),
    "GRNItemLocationMapping": grnItemLocationMapping == null ? [] : List<dynamic>.from(grnItemLocationMapping!.map((x) => x.toJson())),
    "GRNPacketDetail": grnPacketDetail == null ? [] : List<dynamic>.from(grnPacketDetail!.map((x) => x.toJson())),
    "grnLocationSerialMapping": grnLocationSerialMapping == null ? [] : List<dynamic>.from(grnLocationSerialMapping!.map((x) => x.toJson())),
    "VesselOrOffice": vesselOrOffice,
    "VesselCode": vesselCode,
    "OrderType": orderType,
    "IsUpdateStock": isUpdateStock,
    "isBaggingTaggingPendingTab": isBaggingTaggingPendingTab,
    "isBagTagCompleted": isBagTagCompleted,
    "grnhdOtherMapping": grnhdOtherMapping == null ? [] : List<dynamic>.from(grnhdOtherMapping!.map((x) => x)),
    "GRNItemUnitConversionFactorConfigMappers": grnItemUnitConversionFactorConfigMappers == null ? [] : List<dynamic>.from(grnItemUnitConversionFactorConfigMappers!.map((x) => x)),
  };
}