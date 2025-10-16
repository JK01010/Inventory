class DefaultApiPayload {
  final List<Field> fields;
  final FilterGroup? filter;
  final List<SortOption>? sort;
  final PaginationParams? paginationParams;
  final List<String>? groupBy;

  DefaultApiPayload({
    required this.fields,
    this.filter,
    this.sort,
    this.paginationParams,
    this.groupBy,
  });

  factory DefaultApiPayload.fromJson(Map<String, dynamic> json) {
    return DefaultApiPayload(
      fields: (json['Fields'] as List<dynamic>)
          .map((e) => Field.fromJson(e))
          .toList(),
      filter: json['Filter'] != null ? FilterGroup.fromJson(json['Filter']) : null,
      sort: (json['Sort'] as List<dynamic>?)
          ?.map((e) => SortOption.fromJson(e))
          .toList(),
      paginationParams: json['PaginationParams'] != null
          ? PaginationParams.fromJson(json['PaginationParams'])
          : null,
      groupBy: (json['GroupBy'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'Fields': fields.map((e) => e.toJson()).toList(),
    'Filter': filter?.toJson(),
    'Sort': sort?.map((e) => e.toJson()).toList() ?? [],
    'PaginationParams': paginationParams?.toJson(),
    'GroupBy': groupBy,
  };
}

class Field {
  final String field;
  final String? aggregate;
  final String? aliasName;

  Field({
    required this.field,
    this.aggregate,
    this.aliasName,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
    field: json['field'],
    aggregate: json['aggregate'],
    aliasName: json['AliasName'],
  );

  Map<String, dynamic> toJson() => {
    'field': field,
    'aggregate': aggregate,
    if (aliasName != null) 'AliasName': aliasName,
  };
}

// ✅ Abstract base for filters
abstract class Filter {
  Map<String, dynamic> toJson();
}

class FilterCondition extends Filter {
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

  @override
  Map<String, dynamic> toJson() => {
    'field': field,
    'operator': operator,
    'value': value,
  };
}

class FilterGroup extends Filter {
  final String logic;
  final List<Filter> filters;

  FilterGroup({
    required this.logic,
    required this.filters,
  });

  factory FilterGroup.fromJson(Map<String, dynamic> json) => FilterGroup(
    logic: json['logic'],
    filters: (json['filters'] as List<dynamic>).map((e) {
      if (e.containsKey('logic')) {
        return FilterGroup.fromJson(e);
      } else {
        return FilterCondition.fromJson(e);
      }
    }).toList(),
  );

  @override
  Map<String, dynamic> toJson() => {
    'logic': logic,
    'filters': filters.map((f) => f.toJson()).toList(),
  };
}

class SortOption {
  final String field;
  final String direction;

  SortOption({required this.field, required this.direction});

  factory SortOption.fromJson(Map<String, dynamic> json) =>
      SortOption(field: json['field'], direction: json['Direction']);

  Map<String, dynamic> toJson() => {
    'field': field,
    'Direction': direction,
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

  Map<String, dynamic> toJson() => {
    'pageNo': pageNo,
    'pageSize': pageSize,
  };
}
