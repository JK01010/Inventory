import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domin/entities/consumption_transaction_response_entity.dart';

class ConsumptionTransactionResponseModelDummy extends Equatable {
  const ConsumptionTransactionResponseModelDummy({required this.consumptionTransactionModel});

  factory ConsumptionTransactionResponseModelDummy.fromJson(String source) =>
      ConsumptionTransactionResponseModelDummy.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  factory ConsumptionTransactionResponseModelDummy.fromMap(Map<String, dynamic> map) {
    return ConsumptionTransactionResponseModelDummy(
      consumptionTransactionModel: List<ConsumptionTransactionModelDummy>.from(
        (map['consumptionTransactionEntity'] as List<dynamic>).map<ConsumptionTransactionModelDummy>(
              (x) => ConsumptionTransactionModelDummy.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  final List<ConsumptionTransactionModelDummy> consumptionTransactionModel;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'consumptionTransactionEntity':
      consumptionTransactionModel.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [consumptionTransactionModel];

  @override
  bool? get stringify => true;
}

class ConsumptionTransactionModelDummy extends ConsumptionTransactionEntity {
  const ConsumptionTransactionModelDummy({
    required super.conTransactionItem,
    required super.consumedQty,
    required super.articleNumber,
    required super.storageLocation,
    required super.remarks,
    required super.isSync,
  });

  factory ConsumptionTransactionModelDummy.fromMap(Map<String, dynamic> map) {
    return ConsumptionTransactionModelDummy(
      conTransactionItem: map['conTransactionItem'] as String,
      consumedQty: map['consumedQty'] as String,
      articleNumber: map['articleNumber'] as String,
      storageLocation: map['storageLocation'] as String,
      remarks: map['remarks'] as String,
      isSync: map['isSync'] as String,
    );
  }

  factory ConsumptionTransactionModelDummy.fromJson(String source) =>
      ConsumptionTransactionModelDummy.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'conTransactionItem': conTransactionItem,
      'consumedQty': consumedQty,
      'articleNumber': articleNumber,
      'storageLocation': storageLocation,
      'remarks': remarks,
      'isSync': isSync,
    };
  }

  String toJson() => json.encode(toMap());
}
