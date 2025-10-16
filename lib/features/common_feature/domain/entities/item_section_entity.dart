import 'package:equatable/equatable.dart';

class ItemSectionEntity extends Equatable {
  const ItemSectionEntity({
    required this.id,
    required this.categoryId,
    required this.code,
    required this.sectionName,
  });

  final int id;
  final int categoryId;
  final String code;
  final String sectionName;

  @override
  List<Object?> get props => [id,categoryId, code, sectionName];

  bool? get stringify => true;
}
