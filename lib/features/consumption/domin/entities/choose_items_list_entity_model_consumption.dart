class ChooseItemsListEntityModelConsumption {
  //add stock item details choose items search list model
  ChooseItemsListEntityModelConsumption({required this.chooseItemsEntity});

  final List<ChooseItemsConEntity> chooseItemsEntity;
}

class ChooseItemsConEntity {
  ChooseItemsConEntity({
    required this.itemId,
    required this.itemName,
    required this.isSelected,
    required this.umo,
  });

  final int itemId;
  final String itemName;
  final String umo;
  bool? isSelected;

  ChooseItemsConEntity copyWith({
    int? itemId,
    String? umo,
    String? itemName,
    bool? isSelected,
  }) {
    return ChooseItemsConEntity(
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      isSelected: isSelected ?? this.isSelected,
      umo: umo ?? this.umo,
    );
  }
}
