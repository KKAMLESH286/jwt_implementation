import 'Data.dart';

class LogoutData {
    Data data;
    String message;
    bool success;

    LogoutData({this.data, this.message, this.success});

    factory LogoutData.fromJson(Map<String, dynamic> json) {
        return LogoutData(
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