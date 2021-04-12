import 'package:untitled/model/Home/GetProduct/Image.dart';

class ProductData {
  String id;
  String categoryId;
  String conditionId;
  String createdAt;
  String description;
  bool expireDate;
  String favorite;
  List<Image> images;
  String address;
  bool isBlocked;
  String items;
  num latitude;
  String location;
  num longitude;
  String price;
  String subcategoryId;
  String title;
  String updatedAt;
  String userId;
  String reports;

  ProductData(
      {this.id,
      this.categoryId,
      this.conditionId,
      this.createdAt,
      this.description,
      this.expireDate,
      this.favorite,
      this.images,
      this.address,
      this.isBlocked,
      this.items,
      this.latitude,
      this.location,
      this.longitude,
      this.price,
      this.subcategoryId,
      this.title,
      this.updatedAt,
      this.reports,
      this.userId});

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['_id'],
      categoryId: json['categoryId'],
      conditionId: json['conditionId'],
      createdAt: json['createdAt'],
      description: json['description'],
      expireDate: json['expireDate'],
      favorite: (json['favorite'] != null)
          ? (json['favorite'] is String)
              ? json['favorite']
              : json['favorite'].toString()
          : null,
      images: _objectImages(json['images']),
      address: json['address'],
      isBlocked: json['isBlocked'],
      items: json['items'],
      latitude: json['latitude'],
      location: json['location'],
      longitude: json['longitude'],
      price: json['price'],
      subcategoryId: json['subcategoryId'],
      title: json['title'],
      updatedAt: json['updatedAt'],
      reports: json['reports'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['conditionId'] = this.conditionId;
    data['createdAt'] = this.createdAt;
    data['description'] = this.description;
    data['expireDate'] = this.expireDate;
    data['favorite'] = this.favorite;
    data['address'] = this.address;
    data['isBlocked'] = this.isBlocked;
    data['items'] = this.items;
    data['latitude'] = this.latitude;
    data['location'] = this.location;
    data['longitude'] = this.longitude;
    data['price'] = this.price;
    data['subcategoryId'] = this.subcategoryId;
    data['title'] = this.title;
    data['updatedAt'] = this.updatedAt;
    data['userId'] = this.userId;
    data['reports'] = this.reports;
    if (this.images != null) {
      data['images'] = this.images;
    }
    return data;
  }

  static List<String> _stringImages(dynamic jsonData) {
    try {
      return (jsonData != null) ? new List<String>.from(jsonData) : [];
    } catch (e) {
      return [];
    }
  }

  static List<Image> _objectImages(dynamic jsonData) {
    try {
      return jsonData != null
          ? (jsonData as List).map((i) => Image.fromJson(i)).toList()
          : null;
    } catch (e) {
      return null;
    }
  }

  // List<String> get getImages {
  //   if (images.isNotNullOrEmpty()) {
  //     return images;
  //   } else if (imagesObjs.isNotNullOrEmpty()) {
  //     imagesObjs.forEach((e) {
  //       images.add(e.image);
  //     });
  //     return images;
  //   } else {
  //     return [];
  //   }
  // }
}
