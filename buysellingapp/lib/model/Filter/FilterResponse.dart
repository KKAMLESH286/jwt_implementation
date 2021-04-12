import 'package:untitled/model/Filter/Data.dart';

class AddFourResponse {
  List<Data> data;
  String message;
  bool success;

  AddFourResponse({this.data, this.message, this.success});

  factory AddFourResponse.fromJson(Map<String, dynamic> json) {
    return AddFourResponse(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Data.fromJson(i)).toList()
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
