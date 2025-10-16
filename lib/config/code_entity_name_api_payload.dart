class EntityPayload {
  final String code;
  final String entityName;
  final String moduleCode;
  final List<EntitySchema> entitySchema;
  final List<Field> fields;
  final List<dynamic> sort;
  final List<dynamic> groupBy;
  final FilterGroup? filter;
  final PaginationParams? paginationParams;

  EntityPayload({
    required this.code,
    required this.entityName,
    required this.moduleCode,
    required this.entitySchema,
    required this.fields,
    required this.sort,
    required this.groupBy,
    this.filter,
    this.paginationParams,
  });

  factory EntityPayload.fromJson(Map<String, dynamic> json) {
    return EntityPayload(
      code: json['Code'],
      entityName: json['EntityName'],
      moduleCode: json['ModuleCode'],
      entitySchema: (json['EntitySchema'] as List)
          .map((e) => EntitySchema.fromJson(e))
          .toList(),
      fields: (json['Fields'] as List)
          .map((e) => Field.fromJson(e))
          .toList(),
      sort: (json['Sort'] as List? ?? []),
      groupBy: (json['GroupBy'] as List? ?? []),
      filter: json['Filter'] != null ? FilterGroup.fromJson(json['Filter']) : null,
      paginationParams: json['PaginationParams'] != null
          ? PaginationParams.fromJson(json['PaginationParams'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'Code': code,
    'EntityName': entityName,
    'ModuleCode': moduleCode,
    'EntitySchema': entitySchema.map((e) => e.toJson()).toList(),
    'Fields': fields.map((e) => e.toJson()).toList(),
    'Sort': sort,
    'GroupBy': groupBy,
    'Filter': filter?.toJson(),
    'PaginationParams': paginationParams?.toJson(),
  };
}

class EntitySchema {
  final String name;
  final String type;
  final int? maxLength;
  final String isNullable;
  final String displayName;
  final String description;

  EntitySchema({
    required this.name,
    required this.type,
    this.maxLength,
    required this.isNullable,
    required this.displayName,
    required this.description,
  });

  factory EntitySchema.fromJson(Map<String, dynamic> json) => EntitySchema(
    name: json['name'],
    type: json['type'],
    maxLength: json['maxLength'],
    isNullable: json['isNullable'],
    displayName: json['displayName'],
    description: json['description'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'type': type,
    'maxLength': maxLength,
    'isNullable': isNullable,
    'displayName': displayName,
    'description': description,
  };
}

class Field {
  final String field;

  Field({required this.field});

  factory Field.fromJson(Map<String, dynamic> json) =>
      Field(field: json['field']);

  Map<String, dynamic> toJson() => {'field': field};
}

class FilterGroup {
  final String logic;
  final List<FilterCondition> filters;

  FilterGroup({required this.logic, required this.filters});

  factory FilterGroup.fromJson(Map<String, dynamic> json) => FilterGroup(
    logic: json['logic'],
    filters: (json['filters'] as List)
        .map((e) => FilterCondition.fromJson(e))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'logic': logic,
    'filters': filters.map((e) => e.toJson()).toList(),
  };
}

class FilterCondition {
  final String field;
  final String operator;
  final dynamic value;

  FilterCondition({
    required this.field,
    required this.operator,
    required this.value,
  });

  factory FilterCondition.fromJson(Map<String, dynamic> json) =>
      FilterCondition(
        field: json['field'],
        operator: json['operator'],
        value: json['value'],
      );

  Map<String, dynamic> toJson() => {
    'field': field,
    'operator': operator,
    'value': value,
  };
}

class PaginationParams {
  final int pageNo;
  final int pageSize;

  PaginationParams({required this.pageNo, required this.pageSize});

  factory PaginationParams.fromJson(Map<String, dynamic> json) =>
      PaginationParams(
        pageNo: json['pageNo'],
        pageSize: json['pageSize'],
      );

  Map<String, dynamic> toJson() => {'pageNo': pageNo, 'pageSize': pageSize};
}
