class Image {
    String id;
    String createdAt;
    String image;
    String productId;
    String updatedAt;

    Image({this.id, this.createdAt, this.image, this.productId, this.updatedAt});

    factory Image.fromJson(Map<String, dynamic> json) {
        return Image(
            id: json['_id'],
            createdAt: json['createdAt'], 
            image: json['image'], 
            productId: json['productId'], 
            updatedAt: json['updatedAt'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this.id;
        data['createdAt'] = this.createdAt;
        data['image'] = this.image;
        data['productId'] = this.productId;
        data['updatedAt'] = this.updatedAt;
        return data;
    }
}