// import 'dart:convert';
//
// class GrnCreateLabelRequestModel {
//   final String? code;
//   final String? entityName;
//   final String? moduleCode;
//   final List<FieldModel>? fields;
//   final List<SortModel>? sort;
//   final List<dynamic>? groupBy;
//   final FilterModel? filter;
//   final PaginationParamsModel? paginationParams;
//
//   GrnCreateLabelRequestModel({
//     this.code,
//     this.entityName,
//     this.moduleCode,
//     this.fields,
//     this.sort,
//     this.groupBy,
//     this.filter,
//     this.paginationParams,
//   });
//
//   factory GrnCreateLabelRequestModel.fromRawJson(String str) =>
//       GrnCreateLabelRequestModel.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory GrnCreateLabelRequestModel.fromJson(Map<String, dynamic> json) =>
//       GrnCreateLabelRequestModel(
//         code: json["Code"],
//         entityName: json["EntityName"],
//         moduleCode: json["ModuleCode"],
//         fields: json["Fields"] == null
//             ? []
//             : List<FieldModel>.from(
//             json["Fields"]!.map((x) => FieldModel.fromJson(x))),
//         sort: json["Sort"] == null
//             ? []
//             : List<SortModel>.from(
//             json["Sort"]!.map((x) => SortModel.fromJson(x))),
//         groupBy: json["GroupBy"] == null
//             ? []
//             : List<dynamic>.from(json["GroupBy"]!.map((x) => x)),
//         filter: json["Filter"] == null
//             ? null
//             : FilterModel.fromJson(json["Filter"]),
//         paginationParams: json["PaginationParams"] == null
//             ? null
//             : PaginationParamsModel.fromJson(json["PaginationParams"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//     "Code": code,
//     "EntityName": entityName,
//     "ModuleCode": moduleCode,
//     "Fields": fields == null
//         ? []
//         : List<dynamic>.from(fields!.map((x) => x.toJson())),
//     "Sort": sort == null
//         ? []
//         : List<dynamic>.from(sort!.map((x) => x.toJson())),
//     "GroupBy":
//     groupBy == null ? [] : List<dynamic>.from(groupBy!.map((x) => x)),
//     "Filter": filter?.toJson(),
//     "PaginationParams": paginationParams?.toJson(),
//   };
// }
//
// class FieldModel {
//   final String? field;
//
//   FieldModel({
//     this.field,
//   });
//
//   factory FieldModel.fromRawJson(String str) =>
//       FieldModel.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory FieldModel.fromJson(Map<String, dynamic> json) => FieldModel(
//     field: json["field"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "field": field,
//   };
// }
//
// class FilterModel {
//   final String? logic;
//   final List<FilterItemModel>? filters;
//
//   FilterModel({
//     this.logic,
//     this.filters,
//   });
//
//   factory FilterModel.fromRawJson(String str) =>
//       FilterModel.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
//     logic: json["logic"],
//     filters: json["filters"] == null
//         ? []
//         : List<FilterItemModel>.from(
//         json["filters"]!.map((x) => FilterItemModel.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "logic": logic,
//     "filters": filters == null
//         ? []
//         : List<dynamic>.from(filters!.map((x) => x.toJson())),
//   };
// }
//
// class FilterItemModel {
//   final String? field;
//   final String? operator;
//   final dynamic value;
//
//   FilterItemModel({
//     this.field,
//     this.operator,
//     this.value,
//   });
//
//   factory FilterItemModel.fromRawJson(String str) =>
//       FilterItemModel.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory FilterItemModel.fromJson(Map<String, dynamic> json) =>
//       FilterItemModel(
//         field: json["field"],
//         operator: json["operator"],
//         value: json["value"],
//       );
//
//   Map<String, dynamic> toJson() => {
//     "field": field,
//     "operator": operator,
//     "value": value,
//   };
// }
//
// class PaginationParamsModel {
//   final int? pageNo;
//   final int? pageSize;
//
//   PaginationParamsModel({
//     this.pageNo,
//     this.pageSize,
//   });
//
//   factory PaginationParamsModel.fromRawJson(String str) =>
//       PaginationParamsModel.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory PaginationParamsModel.fromJson(Map<String, dynamic> json) =>
//       PaginationParamsModel(
//         pageNo: json["pageNo"],
//         pageSize: json["pageSize"],
//       );
//
//   Map<String, dynamic> toJson() => {
//     "pageNo": pageNo,
//     "pageSize": pageSize,
//   };
// }
//
// class SortModel {
//   final String? field;
//   final String? direction;
//
//   SortModel({
//     this.field,
//     this.direction,
//   });
//
//   factory SortModel.fromRawJson(String str) =>
//       SortModel.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory SortModel.fromJson(Map<String, dynamic> json) => SortModel(
//     field: json["field"],
//     direction: json["Direction"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "field": field,
//     "Direction": direction,
//   };
// }