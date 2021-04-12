import 'Data.dart';

class ReportResponse {
  ReportResponseData data;
  String message;
  bool success;

  ReportResponse({this.data, this.message, this.success});

  factory ReportResponse.fromJson(Map<String, dynamic> json) {
    return ReportResponse(
      data: json['data'] != null
          ? ReportResponseData.fromJson(json['data'])
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
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
