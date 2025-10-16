class LocationModelForConfirmation {
  LocationModelForConfirmation({
    required this.locId,
    required this.locName,
    this.isSelected = false,
    required this.itemId,
  });

  factory LocationModelForConfirmation.fromJson(Map<String, dynamic> json) {
    return LocationModelForConfirmation(
      locId: json['locId'] as int,
      locName: json['locName'] as String,
      itemId: json['itemId'] as int,
      isSelected: json['isSelected'] as bool? ?? false,
    );
  }
  final int locId;
  final String locName;
  bool isSelected;
  final int itemId; // Add itemId to the constructor and factory

  Map<String, dynamic> toJson() {
    return {
      'locId': locId,
      'locName': locName,
      'isSelected': isSelected,
      'itemId': itemId, // Include itemId in toJson
    };
  }
}
