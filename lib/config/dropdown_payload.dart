import 'default_api_payload.dart';

class DropdownApiPayload {
  final List<String> tags;
  final PaginationParams pagination;

  DropdownApiPayload({required this.tags, required this.pagination});

  factory DropdownApiPayload.fromJson(Map<String, dynamic> json) {
    return DropdownApiPayload(
      tags: (json['Tags'] as List).map((e) => e.toString()).toList(),
      pagination: PaginationParams.fromJson(json['PaginationParams']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'Tags': tags, 'PaginationParams': pagination.toJson()};
  }
}

// class Pagination {
//   final int pageNumber;
//   final int pageSize;
//
//   Pagination({required this.pageNumber, required this.pageSize});
//
//   factory Pagination.fromJson(Map<String, dynamic> json) =>
//       Pagination(pageNumber: json['PageNumber'], pageSize: json['PageSize']);
//
//   Map<String, dynamic> toJson() => {
//     'PageNumber': pageNumber,
//     'PageSize': pageSize,
//   };
// }
