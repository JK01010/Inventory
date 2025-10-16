import 'package:equatable/equatable.dart';

class QualityEntity extends Equatable {
  QualityEntity({
    required this.id,
    required this.code,
    required this.qualityName,
  });

  int id;
  String code;
  String qualityName;

  @override
  List<Object?> get props => [id, code, qualityName];
}
