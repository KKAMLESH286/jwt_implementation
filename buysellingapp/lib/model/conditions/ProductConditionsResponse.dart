import 'ConditionData.dart';

class ProductConditionsResponse {
    List<ConditionData> data;
    String message;
    bool success;

    ProductConditionsResponse({this.data, this.message, this.success});

    factory ProductConditionsResponse.fromJson(Map<String, dynamic> json) {
        return ProductConditionsResponse(
            data: json['data'] != null ? (json['data'] as List).map((i) => ConditionData.fromJson(i)).toList() : null,
            message: json['message'], 
            success: json['success'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['success'] = this.success;
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        return data;
    }
}