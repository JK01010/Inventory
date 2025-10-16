import 'package:equatable/equatable.dart';

class EntityValidation extends Equatable {
  const EntityValidation({
    required this.status,
    required this.validationMessages,
  });

  final bool status;
  final List<String> validationMessages;

  factory EntityValidation.fromMap(Map<String, dynamic> map) {
    return EntityValidation(
      status: map['status'] ?? false,
      validationMessages: List<String>.from(map['validationMessages'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {'status': status, 'validationMessages': validationMessages};
  }

  @override
  List<Object?> get props => [status, validationMessages];
}
