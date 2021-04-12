import 'Data.dart';

class ChangePassword {
    Data data;
    String message;
    bool success;

    ChangePassword({this.data, this.message, this.success});

    factory ChangePassword.fromJson(Map<String, dynamic> json) {
        return ChangePassword(
            data: json['data'] != null ? Data.fromJson(json['data']) : null,
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