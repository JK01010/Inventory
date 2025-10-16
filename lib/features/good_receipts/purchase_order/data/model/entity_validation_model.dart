import 'package:equatable/equatable.dart';

class EntityValidationModel extends Equatable {
  const EntityValidationModel(this.status, this.validationMessages);

  factory EntityValidationModel.fromJson(Map<String, dynamic> map) {
    return EntityValidationModel(
      map['status'] != null ? map['status'] as bool : null,
      List<dynamic>.from((map['validationMessages'] as List<dynamic>)),
    );
  }

  final bool? status;
  final List<dynamic> validationMessages;
  @override
  List<Object?> get props => [status, validationMessages];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': status,
      'validationMessages': validationMessages,
    };
  }

  @override
  bool? get stringify => true;
}
