class AddProductData {
  // ProductData data;
  String message;
  bool success;

  AddProductData(
      { //this.data,
      this.message,
      this.success});

  factory AddProductData.fromJson(Map<String, dynamic> json) {
    return AddProductData(
      // data: json['data'] != null ? ProductData.fromJson(json['data']) : null,
      message: json['message'],
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    // if (this.data != null) {
    //     data['data'] = this.data.toJson();
    // }
    return data;
  }
}
