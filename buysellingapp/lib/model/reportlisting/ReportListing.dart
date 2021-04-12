import 'Data.dart';

class ReportListing {
  List<ReportData> data;
  String message;
  bool success;

  ReportListing({this.data, this.message, this.success});

  factory ReportListing.fromJson(Map<String, dynamic> json) {
    return ReportListing(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => ReportData.fromJson(i)).toList()
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
