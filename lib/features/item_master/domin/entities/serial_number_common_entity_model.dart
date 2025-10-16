import 'package:equatable/equatable.dart';

class SerialNumberCommonEntityModel {
  const SerialNumberCommonEntityModel({required this.portEntityList});

  final List<SerialNumberEntityModel> portEntityList;
}

class SerialNumberEntityModel extends Equatable {
  const SerialNumberEntityModel({
    required this.id,
    required this.itemId,
    required this.poId,
    required this.transactionId
  });

  final int id;
  final int itemId;
  final int poId;
  final int transactionId;


  @override
  List<Object?> get props => [
    id,
    itemId,
    poId,
    transactionId
  ];

  @override
  bool get stringify => true;
}
