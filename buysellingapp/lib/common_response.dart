class CommonResponse {
  String message;
  int status;
  bool success;

  CommonResponse({
    this.message,
    this.status,
    this.success,
  });
  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    return CommonResponse(
      message: json['message'],
      status: json['status'],
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['success'] = this.success;
    return data;
  }
}
