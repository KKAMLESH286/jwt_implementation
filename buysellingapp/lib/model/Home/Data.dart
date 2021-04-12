class Data {
    String id;
    String image;
    String imageType; //all or anything
    String categoryname;
    String createdAt;
    String updatedAt;

    Data({this.id, this.image, this.imageType, this.categoryname, this.createdAt, this.updatedAt});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            id: json['_id'],
            image: json['image'],
            imageType: json['imageType'],
            categoryname: json['categoryname'],
            createdAt: json['createdAt'], 
            updatedAt: json['updatedAt'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this.id;
        data['image'] = this.image;
        data['imageType'] = this.imageType;
        data['categoryname'] = this.categoryname;
        data['createdAt'] = this.createdAt;
        data['updatedAt'] = this.updatedAt;
        return data;
    }
}