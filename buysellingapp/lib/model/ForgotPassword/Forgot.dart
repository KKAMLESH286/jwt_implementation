import 'User.dart';

class Forgot {
    String message;
    bool success;
    User user;

    Forgot({this.message, this.success, this.user});

    factory Forgot.fromJson(Map<String, dynamic> json) {
        return Forgot(
            message: json['message'], 
            success: json['success'], 
            user: json['user'] != null ? User.fromJson(json['user']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['success'] = this.success;
        if (this.user != null) {
            data['user'] = this.user.toJson();
        }
        return data;
    }
}