import 'Data.dart';

class GetProduct {
    List<Data> data;
    String message;
    bool success;

    GetProduct({this.data, this.message, this.success});

    factory GetProduct.fromJson(Map<String, dynamic> json) {
        return GetProduct(
            data: json['data'] != null ? (json['data'] as List).map((i) => Data.fromJson(i)).toList() : null,
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