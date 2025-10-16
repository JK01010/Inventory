import 'package:equatable/equatable.dart';

abstract class GoodsReceiptCommonAttachment extends Equatable{
  final String id;
  final String name;
  final String url;
  final String type;

  const GoodsReceiptCommonAttachment({
  required this.id,
  required this.name,
  required this.url,
  required this.type,
  });

  @override
  List<Object?> get props => [id, name, url, type];
}