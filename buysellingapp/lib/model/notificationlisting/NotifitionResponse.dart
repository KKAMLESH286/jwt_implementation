import 'Data.dart';

class NotificationListingResponse {
  List<NotificationData> data;
  String message;
  bool success;

  NotificationListingResponse({this.data, this.message, this.success});

  factory NotificationListingResponse.fromJson(Map<String, dynamic> json) {
    return NotificationListingResponse(
      data: json['data'] != null
          ? (json['data'] as List)
              .map((i) => NotificationData.fromJson(i))
              .toList()
          : null,
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
