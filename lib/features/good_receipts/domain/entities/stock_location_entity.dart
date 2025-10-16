import 'package:equatable/equatable.dart';

class StockLocationEntity extends Equatable {
  StockLocationEntity({
    required this.id,
    required this.itemId,
    required this.storageLocationId,
    required this.quantity,
    required this.tags,
  });

  int id;
  int itemId;
  int storageLocationId;
  int quantity;
  String tags;

  @override
  List<Object?> get props => [id, itemId, storageLocationId, quantity, tags];
}
