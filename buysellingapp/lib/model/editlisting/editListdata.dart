import 'dart:io';

import 'package:untitled/model/Listing/Selling/Image.dart';

class EditData {
  File file;
  String url;
  String type;

  EditData({
    this.file,
    this.url,
    this.type,
  });

  factory EditData.fromJson(Map<String, dynamic> json) {
    return EditData(
      file: json['file'],
      url: json['url'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file'] = this.file;
    data['url'] = this.url;
    data['type'] = this.type;

    return data;
  }
}
