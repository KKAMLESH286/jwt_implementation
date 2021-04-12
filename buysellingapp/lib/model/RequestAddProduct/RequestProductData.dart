import 'dart:io';

class RequestProductData {
  String id;
  String categoryId;
  String conditionId;
  String description;
  double latitude;
  double longitude;
  List<File> images;
  String items;
  String location;
  String price;
  String subcategoryId;
  String title;
  String userId;

  RequestProductData({this.id, this.categoryId, this.conditionId, this.description, this.latitude = 0.0, this.longitude = 0.0, this.images, this.items, this.location, this.price, this.subcategoryId, this.title, this.userId});

//  factory RequestProductData.fromJson(Map<String, dynamic> json) {
//    return RequestProductData(
//      id: json['_id'],
//      categoryId: json['categoryId'],
//      conditionId: json['conditionId'],
//      description: json['description'],
//  latitude:json['latitude'],
//  longitude:json['longitude'],
////      images: json['images'] != null ? new List<File>.from(json['images']) : null,
//      items: json['items'],
//      location: json['location'],
//      price: json['price'],
//      subcategoryId: json['subcategoryId'],
//      title: json['title'],
//      userId: json['userId'],
//    );
//  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['conditionId'] = this.conditionId;
    data['description'] = this.description;
    data['latitude']=this.latitude;
    data['longitude']=this.longitude;
    data['items'] = this.items;
    data['location'] = this.location;
    data['price'] = this.price;
    data['subcategoryId'] = this.subcategoryId;
    data['title'] = this.title;
    data['userId'] = this.userId;
    if (this.images != null) {
      data['images'] = this.images;
    }
    return data;
  }
}