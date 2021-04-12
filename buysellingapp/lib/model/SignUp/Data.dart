class Data {
  String id;
  String address;
  String avatar;
  String createdAt;
  String deviceId;
  String email;
  bool forgotPassword;
  int isApprovedByAdmin;
  bool isBlocked;
  bool isDeleted;
  int latitude;
  bool loggedIn;
  int longitude;
  String name;
  int phone;
  String socialId;
  String token;
  String updatedAt;
  int userType;

  Data(
      {this.id,
      this.address,
      this.avatar,
      this.createdAt,
      this.deviceId,
      this.email,
      this.forgotPassword,
      this.isApprovedByAdmin,
      this.isBlocked,
      this.isDeleted,
      this.latitude,
      this.loggedIn,
      this.longitude,
      this.name,
      this.phone,
      this.socialId,
      this.token,
      this.updatedAt,
      this.userType});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['_id'],
      address: json['address'],
      avatar: json['avatar'],
      createdAt: json['createdAt'],
      deviceId: json['deviceId'],
      email: json['email'],
      forgotPassword: json['forgotPassword'],
      isApprovedByAdmin: json['isApprovedByAdmin'],
      isBlocked: json['isBlocked'],
      isDeleted: json['isDeleted'],
      latitude: json['latitude'],
      loggedIn: json['loggedIn'],
      longitude: json['longitude'],
      name: json['name'],
      phone: json['phone'],
      socialId: json['socialId'],
      token: json['token'],
      updatedAt: json['updatedAt'],
      userType: json['userType'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['address'] = this.address;
    data['avatar'] = this.avatar;
    data['createdAt'] = this.createdAt;
    data['deviceId'] = this.deviceId;
    data['email'] = this.email;
    data['forgotPassword'] = this.forgotPassword;
    data['isApprovedByAdmin'] = this.isApprovedByAdmin;
    data['isBlocked'] = this.isBlocked;
    data['isDeleted'] = this.isDeleted;
    data['latitude'] = this.latitude;
    data['loggedIn'] = this.loggedIn;
    data['longitude'] = this.longitude;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['socialId'] = this.socialId;
    data['token'] = this.token;
    data['updatedAt'] = this.updatedAt;
    data['userType'] = this.userType;
    return data;
  }
}
