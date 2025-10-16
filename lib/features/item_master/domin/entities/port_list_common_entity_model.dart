import 'package:equatable/equatable.dart';

class PortListEntityModel {
  const PortListEntityModel({required this.portEntityList});

  final List<PortEntityModel> portEntityList;
}

class PortEntityModel extends Equatable {
  const PortEntityModel({
    required this.id,
    required this.code,
    required this.name,
    required this.active
  });

  final int id;
  final String code;
  final String name;
  final String active;


  @override
  List<Object?> get props => [
    id,
    code,
    name,
    active
  ];

  @override
  bool get stringify => true;
}
