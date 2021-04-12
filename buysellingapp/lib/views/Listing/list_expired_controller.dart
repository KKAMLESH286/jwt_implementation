import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:get/get.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/Utils/loader.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/Listing/Expired/ExpiredProducts.dart';

class GetExpiredListingController extends GetxController {
  final Repository _repository = Repository();

  var data = [].obs;

  Future getExpiredListing(String userId) async {
    Get.dialog(Loader(), barrierDismissible: false);
    Map<String, String> map = Map();

    map["userId"] = "5fe34d2bf7fdb22c2c13fb39";
    // SharedPref.getInstance().getUserId();
    ExpiredProducts response = await _repository.getExpiredListing(map);
    Get.back();
    if (response.success) {
      data.value = response.data;
      print(response.toJson());
      print(data.length);
      //   Get.offAll(BottomScreen());
    } else {
//      FrequentUtils.getInstance().showMessage(response.message);
    }
  }

  bool get haveExpiredItems => !data.isNullOrBlank;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
