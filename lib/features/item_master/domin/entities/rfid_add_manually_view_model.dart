import 'dart:convert';

class RfidModel {

  RfidModel({
    required this.rfidCount,
    required this.rfidName,
    this.isSelected = false,
    this.isTaggedWithAnother = false,
  });

  factory RfidModel.fromMap(Map<String, dynamic> map) {
    return RfidModel(
      rfidCount: map['rfidCount'] as int,
      rfidName: map['rfidName'] as String,
      isSelected: map['isSelected'] as bool? ?? false,
      isTaggedWithAnother: map['isTaggedWithAnother'] as bool? ?? false,
    );
  }

  factory RfidModel.fromJson(String source) =>
      RfidModel.fromMap(jsonDecode(source));
  final int rfidCount;
  final String rfidName;
  bool isSelected;
  bool isTaggedWithAnother;

  Map<String, dynamic> toMap() {
    return {
      'rfidCount': rfidCount,
      'rfidName': rfidName,
      'isSelected': isSelected,
      'isTaggedWithAnother': isTaggedWithAnother,
    };
  }

  String toJson() => jsonEncode(toMap());

  RfidModel copyWith({
    int? rfidCount,
    String? rfidName,
    bool? isSelected,
    bool? isTaggedWithAnother,
  }) {
    return RfidModel(
      rfidCount: rfidCount ?? this.rfidCount,
      rfidName: rfidName ?? this.rfidName,
      isSelected: isSelected ?? this.isSelected,
      isTaggedWithAnother: isTaggedWithAnother ?? this.isTaggedWithAnother,
    );
  }
}

