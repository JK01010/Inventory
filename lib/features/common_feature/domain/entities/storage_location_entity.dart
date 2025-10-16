import 'package:equatable/equatable.dart';

class StorageLocationEntity extends Equatable {
  StorageLocationEntity({
    required this.id,
    required this.parentId,
    required this.code,
    required this.locName,
    required this.description,
    required this.vesselLocationID,
    required this.isActive,
    required this.referenceTypeID,
    required this.referenceID,
    required this.referenceSubID,
    required this.parentLocName,
  });

  int id;
  int parentId;
  String code;
  String locName;
  String description;
  int vesselLocationID;
  bool isActive;
  int referenceTypeID;
  int referenceID;
  int referenceSubID;
  String parentLocName;

  @override
  List<Object?> get props => [
    id,
    parentId,
    code,
    locName,
    description,
    vesselLocationID,
    isActive,
    referenceTypeID,
    referenceID,
    referenceSubID,
    parentLocName,
  ];
}
