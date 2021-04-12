class User {
    String id;
    String address;
    String avatar;
    String createdAt;
    String deviceId;
    String email;
    bool forgotPassword;
    String gender;
    num isApprovedByAdmin;
    bool isBlocked;
    bool isDeleted;
    num latitude;
    bool loggedIn;
    num longitude;
    String name;
    String phone;
    String socialId;
    num type;
    String updatedAt;
    String usertype;

    User({this.id, this.address, this.avatar, this.createdAt, this.deviceId, this.email, this.forgotPassword, this.gender, this.isApprovedByAdmin, this.isBlocked, this.isDeleted, this.latitude, this.loggedIn, this.longitude, this.name, this.phone, this.socialId, this.type, this.updatedAt, this.usertype});

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            id: json['_id'],
            address: json['address'], 
            avatar: json['avatar'], 
            createdAt: json['createdAt'], 
            deviceId: json['deviceId'], 
            email: json['email'], 
            forgotPassword: json['forgotPassword'], 
            gender: json['gender'], 
            isApprovedByAdmin: json['isApprovedByAdmin'], 
            isBlocked: json['isBlocked'], 
            isDeleted: json['isDeleted'], 
            latitude: json['latitude'], 
            loggedIn: json['loggedIn'], 
            longitude: json['longitude'], 
            name: json['name'], 
            phone: json['phone'], 
            socialId: json['socialId'], 
            type: json['type'], 
            updatedAt: json['updatedAt'], 
            usertype: json['usertype'], 
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
        data['gender'] = this.gender;
        data['isApprovedByAdmin'] = this.isApprovedByAdmin;
        data['isBlocked'] = this.isBlocked;
        data['isDeleted'] = this.isDeleted;
        data['latitude'] = this.latitude;
        data['loggedIn'] = this.loggedIn;
        data['longitude'] = this.longitude;
        data['name'] = this.name;
        data['phone'] = this.phone;
        data['socialId'] = this.socialId;
        data['type'] = this.type;
        data['updatedAt'] = this.updatedAt;
        data['usertype'] = this.usertype;
        return data;
    }
}