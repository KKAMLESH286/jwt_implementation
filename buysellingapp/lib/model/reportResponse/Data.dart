class ReportResponseData {
  int v;
  String id;
  String createdAt;
  bool isBlocked;
  String productId;
  String reportId;
  String updatedAt;
  String userId;

  ReportResponseData(
      {this.v,
      this.id,
      this.createdAt,
      this.isBlocked,
      this.productId,
      this.reportId,
      this.updatedAt,
      this.userId});

  factory ReportResponseData.fromJson(Map<String, dynamic> json) {
    return ReportResponseData(
      v: json['__v'],
      id: json['_id'],
      createdAt: json['createdAt'],
      isBlocked: json['isBlocked'],
      productId: json['productId'],
      reportId: json['reportId'],
      updatedAt: json['updatedAt'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__v'] = this.v;
    data['_id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['isBlocked'] = this.isBlocked;
    data['productId'] = this.productId;
    data['reportId'] = this.reportId;
    data['updatedAt'] = this.updatedAt;
    data['userId'] = this.userId;
    return data;
  }
}
