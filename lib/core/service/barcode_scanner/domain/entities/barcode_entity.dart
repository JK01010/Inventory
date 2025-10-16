import 'package:equatable/equatable.dart';

class BarcodeEntity extends Equatable {
  const BarcodeEntity({
    required this.rawValue,
    required this.type,
    this.image,
  });
  final String? rawValue;
  final String? type;
  final String? image;


  @override
  List<Object?> get props => [rawValue, type, image];
}