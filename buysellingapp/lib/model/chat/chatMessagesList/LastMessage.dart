class LastMessage {
    String file;
    int chat_id;
    String created_at;
    String file_type;
    int id;
    String is_viewed;
    String message;
    String type;
    String updated_at;

    LastMessage({this.file, this.chat_id, this.created_at, this.file_type, this.id, this.is_viewed, this.message, this.type, this.updated_at});

    factory LastMessage.fromJson(Map<String, dynamic> json) {
        return LastMessage(
            file: json['file'], 
            chat_id: json['chat_id'], 
            created_at: json['created_at'], 
            file_type: json['file_type'], 
            id: json['id'], 
            is_viewed: json['is_viewed'], 
            message: json['message'], 
            type: json['type'], 
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['file'] = this.file;
        data['chat_id'] = this.chat_id;
        data['created_at'] = this.created_at;
        data['file_type'] = this.file_type;
        data['id'] = this.id;
        data['is_viewed'] = this.is_viewed;
        data['message'] = this.message;
        data['type'] = this.type;
        data['updated_at'] = this.updated_at;
        return data;
    }
}