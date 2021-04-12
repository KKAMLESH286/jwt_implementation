import 'ProductId.dart';

class ChatUserData {
  String id;
  String chatId;
  String username;
  String userPic;
  String receivername;
  String receiverPic;
  String count;
  String createdAt;
  bool isBlocked;
  String isSeen;
  String message;
  ProductId productId;
  String receiverId;
  String type;
  String updatedAt;
  String userId;

  ChatUserData(
      {this.id,
      this.chatId,
      this.username,
      this.userPic,
      this.receivername,
      this.receiverPic,
      this.count,
      this.createdAt,
      this.isBlocked,
      this.isSeen,
      this.message,
      this.productId,
      this.receiverId,
      this.type,
      this.updatedAt,
      this.userId});

  factory ChatUserData.fromJson(Map<String, dynamic> json) {
    return ChatUserData(
      id: json['_id'],
      username: json['username'],
      userPic: json['userPic'],
      receivername: json['receivername'],
      receiverPic: json['receiverPic'],
      chatId: json['chatId'],
      count: json['count'],
      createdAt: json['createdAt'],
      isBlocked: json['isBlocked'],
      isSeen: json['isSeen'],
      message: json['message'],
      productId: _product(json['productId']),
      receiverId: json['receiverId'],
      type: json['type'],
      updatedAt: json['updatedAt'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['chatId'] = this.chatId;
    data['username'] = this.username;
    data['userPic'] = this.userPic;
    data['receivername'] = this.receivername;
    data['receiverPic'] = this.receiverPic;
    data['count'] = this.count;
    data['createdAt'] = this.createdAt;
    data['isBlocked'] = this.isBlocked;
    data['isSeen'] = this.isSeen;
    data['message'] = this.message;
    data['receiverId'] = this.receiverId;
    data['type'] = this.type;
    data['updatedAt'] = this.updatedAt;
    data['userId'] = this.userId;
    if (this.productId != null) {
      data['productId'] = this.productId.toJson();
    }
    return data;
  }

  static _product(jsonData) {
    try {
      return jsonData != null
          ? ProductId.fromJson(jsonData)
          : null;
    } catch (e) {
      print("ChatUserData: json['productId'] :- "+e.toString());
      return null;
    }
  }
}
