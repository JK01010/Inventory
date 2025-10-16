import 'package:equatable/equatable.dart';

/// For parsing the full response (list of LocationModel)
class LocationListApiModel extends Equatable {

  const LocationListApiModel({required this.locationList});

  factory LocationListApiModel.fromJson(List<dynamic> jsonList) {
    return LocationListApiModel(
      locationList: jsonList.map((item) => LocationModel.fromJson(item)).toList(),
    );
  }
  final List<LocationModel> locationList;

  List<Map<String, dynamic>> toJson() {
    return locationList.map((e) => e.toJson()).toList();
  }

  @override
  List<Object?> get props => [locationList];
}


class LocationModel extends Equatable {

  const LocationModel({
    required this.id,
    required this.parentId,
    required this.parentName,
    required this.code,
    required this.name,
    required this.activeFlag,
    required this.type,
    required this.sortOrder,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] as int,
      parentId: json['parentID'] as int,
      parentName: json['parentName'] ?? '',
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      activeFlag: json['activeFlag'] ?? '',
      type: json['type'] ?? '',
      sortOrder: json['sortOrder'] as int,
    );
  }
  final int id;
  final int parentId;
  final String parentName;
  final String code;
  final String name;
  final String activeFlag;
  final String type;
  final int sortOrder;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parentID': parentId,
      'parentName': parentName,
      'code': code,
      'name': name,
      'activeFlag': activeFlag,
      'type': type,
      'sortOrder': sortOrder,
    };
  }

  @override
  List<Object?> get props => [
        id,
        parentId,
        parentName,
        code,
        name,
        activeFlag,
        type,
        sortOrder,
      ];
}



