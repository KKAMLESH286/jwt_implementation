import 'package:untitled/model/Listing/Selling/Data.dart';

class GetSellingListing {
    List<Data> data;
    String message;
    bool success;

    GetSellingListing({this.data, this.message, this.success});

    factory GetSellingListing.fromJson(Map<String, dynamic> json) {
        return GetSellingListing(
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