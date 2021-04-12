import 'package:untitled/model/Home/Data.dart';
class HomeData {
    List<Data> data;
    String message;
    bool success;

    HomeData({this.data, this.message, this.success});

    factory HomeData.fromJson(Map<String, dynamic> json) {
        return HomeData(
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