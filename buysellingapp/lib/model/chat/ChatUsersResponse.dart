import 'ChatUserData.dart';

class ChatUsersResponse {
    List<ChatUserData> data;
    String message;
    bool success;

    ChatUsersResponse({this.data, this.message, this.success});

    factory ChatUsersResponse.fromJson(Map<String, dynamic> json) {
        return ChatUsersResponse(
            data: json['data'] != null ? (json['data'] as List).map((i) => ChatUserData.fromJson(i)).toList() : null,
            message: json['message'], 
            success: json['success'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['success'] = this.success;
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        return data;
    }
}