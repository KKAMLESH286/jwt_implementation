import 'Data.dart';

class AddToCart {
    Data data;
    String message;
    bool success;

    AddToCart({this.data, this.message, this.success});

    factory AddToCart.fromJson(Map<String, dynamic> json) {
        return AddToCart(
            data: json['data'] != null ? Data.fromJson(json['data']) : null,
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