class Image {
  int v;
  String id;
  String createdAt;
  String image;
  String productId;
  String updatedAt;

  Image(
      {this.v,
      this.id,
      this.createdAt,
      this.image,
      this.productId,
      this.updatedAt});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      v: json['__v'],
      id: json['_id'],
      createdAt: json['createdAt'],
      image: json['image'],
      productId: json['productId'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__v'] = this.v;
    data['_id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['image'] = this.image;
    data['productId'] = this.productId;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
