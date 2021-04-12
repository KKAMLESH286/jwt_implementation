class Data {
  int v;
  String id;
  String categoryId;
  String createdAt;
  String subcategoryname;
  String updatedAt;

  Data(
      {this.v,
      this.id,
      this.categoryId,
      this.createdAt,
      this.subcategoryname,
      this.updatedAt});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      v: json['__v'],
      id: json['_id'],
      categoryId: json['categoryId'],
      createdAt: json['createdAt'],
      subcategoryname: json['Subcategoryname'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__v'] = this.v;
    data['_id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['createdAt'] = this.createdAt;
    data['Subcategoryname'] = this.subcategoryname;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
