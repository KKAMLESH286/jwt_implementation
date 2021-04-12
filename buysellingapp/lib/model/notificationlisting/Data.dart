class NotificationData {
  int v;
  String id;
  String data;
  String body;
  String createAt;
  String notificationId;
  String status;
  String title;
  String type;
  String userId;
  String username;

  NotificationData(
      {this.v,
      this.id,
      this.data,
      this.body,
      this.createAt,
      this.notificationId,
      this.status,
      this.title,
      this.type,
      this.userId,
      this.username});

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      v: json['__v'],
      id: json['_id'],
      data: json['data'],
      body: json['body'],
      createAt: json['createAt'],
      notificationId: json['notificationId'],
      status: json['status'],
      title: json['title'],
      type: json['type'],
      userId: json['userId'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__v'] = this.v;
    data['_id'] = this.id;
    data['data'] = this.data;
    data['body'] = this.body;
    data['createAt'] = this.createAt;
    data['notificationId'] = this.notificationId;
    data['status'] = this.status;
    data['title'] = this.title;
    data['type'] = this.type;
    data['userId'] = this.userId;
    data['username'] = this.username;
    return data;
  }
}
