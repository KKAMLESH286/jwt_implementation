import 'Data.dart';

class Login {
    UserData data;
    String message;
    bool success;

    Login({this.data, this.message, this.success});

    factory Login.fromJson(Map<String, dynamic> json) {
        return Login(
            data: json['data'] != null ? UserData.fromJson(json['data']) : null,
            message: json['message'], 
            success: json['success'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['success'] = this.success;
        if (this.data != null) {
            data['data'] = this.data.toJson();
        }
        return data;
    }
}