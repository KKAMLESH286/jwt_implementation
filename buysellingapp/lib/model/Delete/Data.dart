class Data {
    int v;
    String id;
    String createdAt;
    String productId;
    String updatedAt;
    String userId;

    Data({this.v, this.id, this.createdAt, this.productId, this.updatedAt, this.userId});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            v: json['__v'],
            id: json['_id'],
            createdAt: json['createdAt'], 
            productId: json['productId'], 
            updatedAt: json['updatedAt'], 
            userId: json['userId'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['__v'] = this.v;
        data['_id'] = this.id;
        data['createdAt'] = this.createdAt;
        data['productId'] = this.productId;
        data['updatedAt'] = this.updatedAt;
        data['userId'] = this.userId;
        return data;
    }
}