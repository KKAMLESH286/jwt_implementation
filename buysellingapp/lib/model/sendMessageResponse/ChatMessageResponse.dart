import 'MessageData.dart';

class ChatMessageResponse {
  MessageData data;
  String message;
  bool success;

  ChatMessageResponse({this.data, this.message, this.success});

  factory ChatMessageResponse.fromJson(Map<String, dynamic> json) {
    return ChatMessageResponse(
      data: json['data'] != null ? MessageData.fromJson(json['data']) : null,
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
