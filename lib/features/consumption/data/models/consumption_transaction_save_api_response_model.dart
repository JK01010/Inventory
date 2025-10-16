import 'package:equatable/equatable.dart';

class ConsumptionTransactionSaveResponseModel extends Equatable {
  const ConsumptionTransactionSaveResponseModel({
    required this.status,
    required this.statusMsg,
    required this.transactionHD,
  });

  factory ConsumptionTransactionSaveResponseModel.fromJson(Map<String, dynamic> map) {
    return ConsumptionTransactionSaveResponseModel(
      status: map['status'] ?? '',
      statusMsg: map['statusMsg'] ?? '',
      transactionHD: List<TransactionHdModel>.from(
        (map['transactionHD'] as List).map(
              (x) => TransactionHdModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  final String status;
  final String statusMsg;
  final List<TransactionHdModel> transactionHD;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': status,
      'statusMsg': statusMsg,
      'transactionHD': transactionHD.map((x) => x.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [status, statusMsg, transactionHD];
}

class TransactionHdModel extends Equatable {
  const TransactionHdModel({
    required this.id,
    required this.code,
    required this.transactionTypeID,
    required this.transactionType,
    this.frequencyID,
    required this.transactionDate,
    this.remarks,
    this.versionIdentifier,
    required this.operationType,
    this.orgID,
  });

  factory TransactionHdModel.fromJson(Map<String, dynamic> map) {
    return TransactionHdModel(
      id: map['id'] ?? 0,
      code: map['code'] ?? '',
      transactionTypeID: map['transactionTypeID'] ?? 0,
      transactionType: map['transactionType'] ?? '',
      frequencyID: map['frequencyID'],
      transactionDate: map['transactionDate'] ?? '',
      remarks: map['remarks'],
      versionIdentifier: map['versionIdentifier'],
      operationType: map['operationType'] ?? '',
      orgID: map['orgID'],
    );
  }

  final int id;
  final String code;
  final int transactionTypeID;
  final String transactionType;
  final int? frequencyID;
  final String transactionDate;
  final String? remarks;
  final String? versionIdentifier;
  final String operationType;
  final int? orgID;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'transactionTypeID': transactionTypeID,
      'transactionType': transactionType,
      'frequencyID': frequencyID,
      'transactionDate': transactionDate,
      'remarks': remarks,
      'versionIdentifier': versionIdentifier,
      'operationType': operationType,
      'orgID': orgID,
    };
  }

  @override
  List<Object?> get props => [
    id,
    code,
    transactionTypeID,
    transactionType,
    frequencyID,
    transactionDate,
    remarks,
    versionIdentifier,
    operationType,
    orgID,
  ];
}
