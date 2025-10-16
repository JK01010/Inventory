import 'package:equatable/equatable.dart';

class ImdgClassEntity extends Equatable {
  const ImdgClassEntity({
    required this.id,
    required this.code,
    required this.typeName,
    required this.isActive,
  });

  factory ImdgClassEntity.initial() {
    return const ImdgClassEntity(
      id: 0,
      code: "",
      typeName: "",
      isActive: true,
    );
  }

  final int id;
  final String code;
  final String typeName;
  final bool isActive;

  @override
  List<Object?> get props => [id, code, typeName, isActive];

}
