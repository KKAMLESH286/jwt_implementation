class FilterData {
  String id;
  String categoryId = "";
  String location;
  String minPrice = "";
  String maxPrice = "";
  String distance = "50";
  String userId;

  FilterData({this.id, this.categoryId, this.minPrice,this.maxPrice, this.location, this.distance, this.userId});

  factory FilterData.fromJson(Map<String, dynamic> json) {
    return FilterData(
      id: json['_id'],
      categoryId: json['categoryId'] ?? "",
      minPrice: json['minPrice'] ?? "",
      maxPrice: json['maxPrice'] ?? "",
      location: json['location'],
      distance: json['distance'] ?? "50",
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['categoryId'] = this.categoryId ?? "";
    data['minPrice'] = this.minPrice ?? "";
    data['maxPrice']=this.maxPrice ?? "";
    data['location'] = this.location;
    data['distance'] = this.distance ?? "50";
    data['userId'] = this.userId;

    return data;
  }
}