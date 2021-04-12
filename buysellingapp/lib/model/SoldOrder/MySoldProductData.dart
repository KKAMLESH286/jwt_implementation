
import 'package:untitled/model/Home/GetProduct/Image.dart';

class MySoldProductData {
  int v;
  String id;
  String categoryId;
  String conditionId;
  String createdAt;
  String description;
  bool expireDate;
  List<Image> images;
  bool isBlocked;
  String items;
  num latitude;
  String location;
  num longitude;
  String price;
  bool sold;
  String title;
  String updatedAt;
  String userId;

  MySoldProductData(
      {this.v,
      this.id,
      this.categoryId,
      this.conditionId,
      this.createdAt,
      this.description,
      this.expireDate,
      this.images,
      this.isBlocked,
      this.items,
      this.latitude,
      this.location,
      this.longitude,
      this.price,
      this.sold,
      this.title,
      this.updatedAt,
      this.userId});

  factory MySoldProductData.fromJson(Map<String, dynamic> json) {
    return MySoldProductData(
      v: json['__v'],
      id: json['_id'],
      categoryId: json['categoryId'],
      conditionId: json['conditionId'],
      createdAt: json['createdAt'],
      description: json['description'],
      expireDate: json['expireDate'],
      images: json['images'] != null
          ? (json['images'] as List).map((i) => Image.fromJson(i)).toList()
          : null,
      isBlocked: json['isBlocked'],
      items: json['items'],
      latitude: json['latitude'],
      location: json['location'],
      longitude: json['longitude'],
      price: json['price'],
      sold: json['sold'],
      title: json['title'],
      updatedAt: json['updatedAt'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__v'] = this.v;
    data['_id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['conditionId'] = this.conditionId;
    data['createdAt'] = this.createdAt;
    data['description'] = this.description;
    data['expireDate'] = this.expireDate;
    data['isBlocked'] = this.isBlocked;
    data['items'] = this.items;
    data['latitude'] = this.latitude;
    data['location'] = this.location;
    data['longitude'] = this.longitude;
    data['price'] = this.price;
    data['sold'] = this.sold;
    data['title'] = this.title;
    data['updatedAt'] = this.updatedAt;
    data['userId'] = this.userId;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
