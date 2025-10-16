class FailedCommonApiModel {
  FailedCommonApiModel({
    required this.apiEndPoint,
    required this.apiPayLoad,
    required this.id,
  });

  factory FailedCommonApiModel.fromJson(Map<String, dynamic> json) {
    return FailedCommonApiModel(
      apiEndPoint: json['apiEndPoint'] ?? '',
      apiPayLoad: json['apiPayLoad'] ?? '',
      id: json['id'] ?? 0,
    );
  }

  final String apiEndPoint;
  final String apiPayLoad;
  final int id;

  // Convert FailedCommonApiModel to JSON
  Map<String, dynamic> toJson() {
    return {'apiEndPoint': apiEndPoint, 'apiPayLoad': apiPayLoad};
  }

  // Convert a list of JSON objects to a list of FailedCommonApiModel
  static List<FailedCommonApiModel> toList(List<dynamic> jsonList) {
    return jsonList.map((json) => FailedCommonApiModel.fromJson(json)).toList();
  }
}
