import 'package:untitled/model/Setting/Data.dart';

class NotificationResponse {
    Data data;
    String message;
    bool success;

    NotificationResponse({this.data, this.message, this.success});

    factory NotificationResponse.fromJson(Map<String, dynamic> json) {
        return NotificationResponse(
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