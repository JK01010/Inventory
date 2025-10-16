class DashboardIcons {

  DashboardIcons({this.dashboardIconList});

  DashboardIcons.fromJson(Map<String, dynamic> json) {
    if (json['dashboardIconList'] != null) {
      dashboardIconList = <DashboardIconList>[];
      json['dashboardIconList'].forEach((v) {
        dashboardIconList!.add(DashboardIconList.fromJson(v));
      });
    }
  }
  List<DashboardIconList>? dashboardIconList;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dashboardIconList != null) {
      data['dashboardIconList'] =
          dashboardIconList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DashboardIconList {

  DashboardIconList({this.id, this.iconName, this.iconPath,required this.route});

  DashboardIconList.fromJson(Map<String, dynamic> json) {
    id = json[' id'];
    iconName = json['iconName'];
    iconPath = json['iconPath'];
    route = json['route'];
  }
  int? id;
  String? iconName;
  String? iconPath;
  String route = "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' id'] = id;
    data['iconName'] = iconName;
    data['iconPath'] = iconPath;
    data['route'] = route;
    return data;
  }
}
