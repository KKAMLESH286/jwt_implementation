class SendMessageRequest {
  String chatId;
  String message;
  String productId;
  String receiverId;
  String receiverPic;
  String receivername;
  String type;
  String userId;
  String userPic;
  String username;

  SendMessageRequest({this.chatId, this.message, this.productId, this.receiverId, this.receiverPic, this.receivername, this.type, this.userId, this.userPic, this.username});

  factory SendMessageRequest.fromJson(Map<String, dynamic> json) {
    return SendMessageRequest(
      chatId: json['chatId'],
      message: json['message'],
      productId: json['productId'],
      receiverId: json['receiverId'],
      receiverPic: json['receiverPic'],
      receivername: json['receivername'],
      type: json['type'],
      userId: json['userId'],
      userPic: json['userPic'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chatId'] = this.chatId;
    data['message'] = this.message;
    data['productId'] = this.productId;
    data['receiverId'] = this.receiverId;
    data['receiverPic'] = this.receiverPic;
    data['receivername'] = this.receivername;
    data['type'] = this.type;
    data['userId'] = this.userId;
    data['userPic'] = this.userPic;
    data['username'] = this.username;
    return data;
  }
}