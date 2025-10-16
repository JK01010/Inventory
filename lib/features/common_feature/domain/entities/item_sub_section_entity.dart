import 'package:equatable/equatable.dart';

class ItemSubSectionEntity extends Equatable {
  const ItemSubSectionEntity({
    required this.id,
    required this.sectionId,
    required this.code,
    required this.subSectionName,
  });

  final int id;
  final int sectionId;
  final String code;
  final String subSectionName;

  @override
  List<Object?> get props => [id,sectionId, code, subSectionName];

  bool? get stringify => true;
}
