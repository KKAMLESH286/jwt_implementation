import 'MySoldProductData.dart';

class MySoldProductsResponse {
  List<MySoldProductData> data;
  String message;
  bool success;

  MySoldProductsResponse({this.data, this.message, this.success});

  factory MySoldProductsResponse.fromJson(Map<String, dynamic> json) {
    return MySoldProductsResponse(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => MySoldProductData.fromJson(i)).toList()
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
