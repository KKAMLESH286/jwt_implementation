class ConditionData {
    String id;
    String condition;
    String createdAt;
    String image;
    bool isBlocked;
    String title;
    String updatedAt;

    ConditionData({this.id, this.condition, this.createdAt, this.image, this.isBlocked, this.title, this.updatedAt});

    factory ConditionData.fromJson(Map<String, dynamic> json) {
        return ConditionData(
            id: json['_id'], 
            condition: json['condition'], 
            createdAt: json['createdAt'], 
            image: json['image'], 
            isBlocked: json['isBlocked'], 
            title: json['title'], 
            updatedAt: json['updatedAt'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this.id;
        data['condition'] = this.condition;
        data['createdAt'] = this.createdAt;
        data['image'] = this.image;
        data['isBlocked'] = this.isBlocked;
        data['title'] = this.title;
        data['updatedAt'] = this.updatedAt;
        return data;
    }
}