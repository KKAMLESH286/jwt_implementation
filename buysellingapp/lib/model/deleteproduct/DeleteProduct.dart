import 'Data.dart';

class DeleteProduct {
  DeleteProductData data;
  bool success;
  String message;

  DeleteProduct({this.data, this.success, this.message});

  factory DeleteProduct.fromJson(Map<String, dynamic> json) {
    return DeleteProduct(
      data: json['data'] != null
          ? DeleteProductData.fromJson(json['data'])
          : null,
      success: json['success'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
