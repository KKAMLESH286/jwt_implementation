import 'package:untitled/model/Login/Data.dart';

import 'LastMessage.dart';


class ChatListData {
    String created_at;
    int id;
    LastMessage last_message;
    UserData receiver_detail;
    int receiver_id;
    UserData sender_detail;
    int sender_id;
    String updated_at;

    ChatListData({this.created_at, this.id, this.last_message, this.receiver_detail, this.receiver_id, this.sender_detail, this.sender_id, this.updated_at});

    factory ChatListData.fromJson(Map<String, dynamic> json) {
        return ChatListData(
            created_at: json['created_at'], 
            id: json['id'], 
            last_message: json['last_message'] != null ? LastMessage.fromJson(json['last_message']) : null, 
            receiver_detail: json['receiver_detail'] != null ? UserData.fromJson(json['receiver_detail']) : null, 
            receiver_id: json['receiver_id'], 
            sender_detail: json['sender_detail'] != null ? UserData.fromJson(json['sender_detail']) : null, 
            sender_id: json['sender_id'], 
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['receiver_id'] = this.receiver_id;
        data['sender_id'] = this.sender_id;
        data['updated_at'] = this.updated_at;
        if (this.last_message != null) {
            data['last_message'] = this.last_message.toJson();
        }
        if (this.receiver_detail != null) {
            data['receiver_detail'] = this.receiver_detail.toJson();
        }
        if (this.sender_detail != null) {
            data['sender_detail'] = this.sender_detail.toJson();
        }
        return data;
    }
}