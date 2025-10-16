class ChooseItemsListEntityModel {
  //add stock item details choose items search list model
  ChooseItemsListEntityModel({required this.chooseItemsEntity});

  final List<ChooseItemsEntity> chooseItemsEntity;
}

class ChooseItemsEntity {
  ChooseItemsEntity({
    required this.itemId,
    required this.itemName,
    required this.isSelected,
    required this.umoName,
    this.totalRob,
    this.newStock,
    this.reconditionStock,
  });

  final int itemId;
  final String itemName;
  final String umoName;
  final double? totalRob;
  final double? newStock;
  final double? reconditionStock;

  bool? isSelected;

  ChooseItemsEntity copyWith({
    int? itemId,
    String? umoName,
    String? itemName,
    bool? isSelected,
    double? totalRob,
    double? newStock,
    double? reconditionStock,
  }) {
    return ChooseItemsEntity(
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      isSelected: isSelected ?? this.isSelected,
      umoName: umoName ?? this.umoName,
      totalRob: totalRob ?? this.totalRob,
      newStock: newStock ?? this.newStock,
      reconditionStock: reconditionStock ?? this.reconditionStock,
    );
  }
}
