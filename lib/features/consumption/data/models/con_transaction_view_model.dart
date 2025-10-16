import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../domin/entities/con_transaction_view_entity_model.dart';


class ConTransactionViewResponseModel extends Equatable {

  const ConTransactionViewResponseModel({required this.conTransactionViewResponseModel});

  final List<ConTransactionViewModel> conTransactionViewResponseModel;

  @override
  List<Object?> get props => [conTransactionViewResponseModel];

}

class ConTransactionViewModel extends Equatable {
  const ConTransactionViewModel({
    required this.itemName,
    required this.quantity,
    required this.articleNumber,
    required this.remarks,
    required this.defaultStorageLocation,
    required this.syncStatus
  });

  /// fromMap
  factory ConTransactionViewModel.fromMap(Map<String, dynamic> map) {
    return ConTransactionViewModel(
        itemName: map['itemName'] as String,
        quantity: map['quantity'] as String,
        articleNumber: map['articleNumber'] as String,
        remarks: map['remarks'] as String,
        defaultStorageLocation: map['defaultStorageLocation'] as String,
        syncStatus: map['syncStatus'] as String
    );
  }



  /// fromJson
/*  factory StockUpdateViewModel.fromJson(String source) =>
      StockUpdateViewModel.fromMap(json.decode(source) as Map<String, dynamic>);*/

  factory ConTransactionViewModel.fromJson(String source) =>
      ConTransactionViewModel.fromMap(json.decode(source));

  factory ConTransactionViewModel.fromEntity({required ConTransactionViewEntity entity,
  }) =>
      ConTransactionViewModel(
          itemName: entity.itemName,
          quantity: entity.quantity,
          articleNumber: entity.articleNumber,
          remarks: entity.remarks,
          defaultStorageLocation: entity.defaultStorageLocation,
          syncStatus: entity.syncStatus
      );


  final String itemName;
  final String quantity;
  final String articleNumber;
  final String remarks;
  final String defaultStorageLocation;
  final String syncStatus;

  /// toMap
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemName': itemName,
      'quantity': quantity,
      'articleNumber': articleNumber,
      'remarks': remarks,
      'defaultStorageLocation': defaultStorageLocation,
      'syncStatus':syncStatus
    };
  }

  /// toJson
  String toJson() => json.encode(toMap());

  ConTransactionViewEntity toEntity() => ConTransactionViewEntity(
      itemName: itemName,
      quantity: quantity,
      articleNumber: articleNumber,
      remarks: remarks,
      defaultStorageLocation: defaultStorageLocation,
      syncStatus: syncStatus
  );

  ConTransactionViewModel copyWith({
    String? itemName,
    String? quantity,
    String? articleNumber,
    String? remarks,
    String? defaultStorageLocation,
    String? syncStatus
  }){
    return ConTransactionViewModel(
      itemName: itemName ?? this.itemName,
      articleNumber: articleNumber ?? this.articleNumber,
      quantity: quantity ?? this.quantity,
      remarks:  remarks ?? this.remarks,
      defaultStorageLocation: defaultStorageLocation ??this.defaultStorageLocation,
      syncStatus : syncStatus ?? this.syncStatus
    );
  }

  @override
  List<Object?> get props =>
      [
        itemName,
        quantity,
        articleNumber,
        defaultStorageLocation,
        remarks,
        syncStatus
      ];

  @override
  bool get stringify => true;
}