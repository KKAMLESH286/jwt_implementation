//import 'dart:async';
//import 'package:get/get.dart';
//import 'package:untitled/Utils/frequent_utils.dart';
//import 'package:untitled/Utils/loader.dart';
//import 'package:untitled/WebServices/repository.dart';
//import 'package:untitled/model/Home/AddToCart/AddToCart.dart';
//
//
//class AddToCartController extends GetxController {
//  final Repository _repository = Repository();
//  var data = AddToCart().obs;
//
//  Future getAddCart(String userId,String productId)async {
//
//    Get.dialog(Loader(), barrierDismissible: false);
//    AddToCart response = await _repository.getAddCart(userId, productId);
//    Get.back();
//    if (response.success) {
//      data.value = response;
//      FrequentUtils.getInstance().showMessage(data.value.message);
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
