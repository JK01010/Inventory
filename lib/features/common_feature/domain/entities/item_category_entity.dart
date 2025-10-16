// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ItemCategoryEntity extends Equatable {
  const ItemCategoryEntity({
    required this.id,
    required this.code,
    required this.categoryName,
  });

  final int id;
  final String code;
  final String categoryName;

  @override
  List<Object?> get props => [id, code, categoryName];

  @override
  bool? get stringify => true;
}
