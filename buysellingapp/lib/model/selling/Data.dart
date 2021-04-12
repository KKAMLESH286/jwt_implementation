class Data {
  int v;
  String id;
  String categoryname;
  String image;
  String createdAt;
  String updatedAt;

  Data(
      {this.v,
      this.id,
      this.categoryname,
      this.image,
      this.createdAt,
      this.updatedAt});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      v: json['__v'],
      id: json['_id'],
      categoryname: json['categoryname'],
      image: json['image'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__v'] = this.v;
    data['_id'] = this.id;
    data['categoryname'] = this.categoryname;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
