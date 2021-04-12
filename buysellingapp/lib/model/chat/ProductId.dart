class ProductId {
    String id;
    String categoryId;
    String conditionId;
    String createdAt;
    String description;
    bool expireDate;
    String favorite;
    List<String> images;
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

    ProductId({this.id, this.categoryId, this.conditionId, this.createdAt, this.description, this.expireDate, this.favorite, this.images, this.isBlocked, this.items, this.latitude, this.location, this.longitude, this.price, this.sold, this.title, this.updatedAt, this.userId});

    factory ProductId.fromJson(Map<String, dynamic> json) {
        return ProductId(
            id: json['_id'],
            categoryId: json['categoryId'], 
            conditionId: json['conditionId'], 
            createdAt: json['createdAt'], 
            description: json['description'], 
            expireDate: json['expireDate'], 
            favorite: json['favorite'], 
            images: json['images'] != null ? new List<String>.from(json['images']) : null, 
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
        data['_id'] = this.id;
        data['categoryId'] = this.categoryId;
        data['conditionId'] = this.conditionId;
        data['createdAt'] = this.createdAt;
        data['description'] = this.description;
        data['expireDate'] = this.expireDate;
        data['favorite'] = this.favorite;
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
            data['images'] = this.images;
        }
        return data;
    }
}