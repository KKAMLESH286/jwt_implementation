class ReportData {
  int v;
  String id;
  String createdAt;
  String image;
  bool isBlocked;
  String reportname;
  String updatedAt;

  ReportData(
      {this.v,
      this.id,
      this.createdAt,
      this.image,
      this.isBlocked,
      this.reportname,
      this.updatedAt});

  factory ReportData.fromJson(Map<String, dynamic> json) {
    return ReportData(
      v: json['__v'],
      id: json['_id'],
      createdAt: json['createdAt'],
      image: json['image'],
      isBlocked: json['isBlocked'],
      reportname: json['reportname'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__v'] = this.v;
    data['_id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['image'] = this.image;
    data['isBlocked'] = this.isBlocked;
    data['reportname'] = this.reportname;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
