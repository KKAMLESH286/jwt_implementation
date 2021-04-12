//import 'dart:convert';
//import 'dart:io';
//import 'dart:async';
//import 'package:get/get.dart';
//import 'package:untitled/Utils/frequent_utils.dart';
//import 'package:untitled/Utils/loader.dart';
//import 'package:untitled/Utils/sharedpref.dart';
//import 'package:untitled/WebServices/repository.dart';
//import 'package:untitled/model/Home/GetProduct/RequestProductData.dart';
//import 'package:untitled/model/Home/GetProduct/GetProduct.dart';
//import 'package:untitled/model/SignUp/SignUp.dart';
//
//import 'package:untitled/views/Home/home.dart';
//
//class GetProductController extends GetxController {
//  final Repository _repository = Repository();
//  RxList<Data> data = <Data>[].obs;
// //var data = [].obs;
//
//  Future getProduct(String userId, String distance, String latitude,String longitude,String categoryId,String minprice,String maxprice) async {
//
//     Get.dialog(Loader(), barrierDismissible: false);
//     Map<String,String> map = Map();
//     map["userId"] = SharedPref.getInstance().getUserId();
//     map["distance"] = distance;
//     map["latitude"] = latitude;
//     map["longitude"] = longitude;
//     map["categoryId"] = categoryId;
//     map["minprice"] = minprice;
//     map["maxprice"] = maxprice;
//    GetProduct response = await _repository.getProduct(map);
//    Get.back();
//    if (response.success) {
//      data.assignAll(response.data);
//    print(response.toJson());
//     print(data.length);
//   //   Get.offAll(BottomScreen());
//    } else {
//      FrequentUtils.getInstance().showMessage(response.message);
//    }
//  }
//
//  @override
//  void onInit() {
//    super.onInit();
//  }
//
//  @override
//  void onClose() {
//    super.onClose();
//  }
//}
