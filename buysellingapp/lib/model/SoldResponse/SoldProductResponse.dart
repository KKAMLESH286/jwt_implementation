import 'Data.dart';

class SoldProductResponse {
  SoldProductData data;
  String message;
  bool success;

  SoldProductResponse({this.data, this.message, this.success});

  factory SoldProductResponse.fromJson(Map<String, dynamic> json) {
    return SoldProductResponse(
      data:
          json['data'] != null ? SoldProductData.fromJson(json['data']) : null,
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
