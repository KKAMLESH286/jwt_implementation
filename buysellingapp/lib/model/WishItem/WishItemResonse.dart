// import 'package:untitled/model/WishItem/Data.dart';
// import 'package:untitled/model/Listing/Selling/Data.dart' as sellingData;
//
// class WishItemData {
//   List<sellingData.Data> data;
//   String message;
//   bool success;
//
//   WishItemData({this.data, this.message, this.success});
//
//   factory WishItemData.fromJson(Map<String, dynamic> json) {
//     return WishItemData(
//       data: json['data'] != null
//           ? (json['data'] as List).map((i) => WishListData.fromJson(i)).toList()
//           : null,
//       message: json['message'],
//       success: json['success'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     data['success'] = this.success;
//     if (this.data != null) {
//       data['data'] = this.data.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
