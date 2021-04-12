class MessageData {
  String id;
  String chatId;
  String count;
  String createdAt;
  bool isBlocked;
  String isSeen;
  String message;
  String productId;
  String receiverId;
  String type;
  String updatedAt;
  String userId;

  MessageData(
      {
      this.id,
      this.chatId,
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

  factory MessageData.fromJson(Map<String, dynamic> json) {
    return MessageData(
      id: json['id'],
      chatId: json['chatId'],
      count: json['count'],
      createdAt: json['createdAt'],
      isBlocked: json['isBlocked'],
      isSeen: json['isSeen'],
      message: json['message'],
      productId: json['productId'],
      receiverId: json['receiverId'],
      type: json['type'],
      updatedAt: json['updatedAt'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chatId'] = this.chatId;
    data['count'] = this.count;
    data['createdAt'] = this.createdAt;
    data['isBlocked'] = this.isBlocked;
    data['isSeen'] = this.isSeen;
    data['message'] = this.message;
    data['productId'] = this.productId;
    data['receiverId'] = this.receiverId;
    data['type'] = this.type;
    data['updatedAt'] = this.updatedAt;
    data['userId'] = this.userId;
    return data;
  }
}
