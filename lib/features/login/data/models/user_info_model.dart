class UserInfoModel {
  String? amr;
  String? sub;
  int? authTime;
  String? idp;
  String? name;
  String? email;
  String? loginName;
  String? userId;
  String? defaultCompanyName;
  String? displayName;
  String? userType;

  UserInfoModel({
    this.amr,
    this.sub,
    this.authTime,
    this.idp,
    this.name,
    this.email,
    this.loginName,
    this.userId,
    this.defaultCompanyName,
    this.displayName,
    this.userType,
  });

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    amr = json['amr'];
    sub = json['sub'];
    authTime = json['auth_time'];
    idp = json['idp'];
    name = json['name'];
    email = json['Email'];
    loginName = json['LoginName'];
    userId = json['UserId'];
    defaultCompanyName = json['DefaultCompanyName'];
    displayName = json['DisplayName'];
    userType = json['UserType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amr'] = amr;
    data['sub'] = sub;
    data['auth_time'] = authTime;
    data['idp'] = idp;
    data['name'] = name;
    data['Email'] = email;
    data['LoginName'] = loginName;
    data['UserId'] = userId;
    data['DefaultCompanyName'] = defaultCompanyName;
    data['DisplayName'] = displayName;
    data['UserType'] = userType;
    return data;
  }

  UserInfoModel getResponse() {
    return this;
  }
}
