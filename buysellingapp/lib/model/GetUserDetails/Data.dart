class Data {
    String id;
    String address;
    String avatar;
    String createdAt;
    String email;
    bool forgotPassword;
    String gender;
    int isApprovedByAdmin;
    bool isBlocked;
    bool isDeleted;
    int latitude;
    bool loggedIn;
    int longitude;
    String name;
    bool notification;
    String phone;
    String socialId;
    int type;
    String updatedAt;
    String usertype;

    Data({this.id, this.address, this.avatar, this.createdAt, this.email, this.forgotPassword, this.gender, this.isApprovedByAdmin, this.isBlocked, this.isDeleted, this.latitude, this.loggedIn, this.longitude, this.name, this.notification, this.phone, this.socialId, this.type, this.updatedAt, this.usertype});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            id: json['_id'],
            address: json['address'], 
            avatar: json['avatar'], 
            createdAt: json['createdAt'], 

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
            notification: json['notification'], 
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
        data['notification'] = this.notification;
        data['phone'] = this.phone;
        data['socialId'] = this.socialId;
        data['type'] = this.type;
        data['updatedAt'] = this.updatedAt;
        data['usertype'] = this.usertype;

        return data;
    }
}