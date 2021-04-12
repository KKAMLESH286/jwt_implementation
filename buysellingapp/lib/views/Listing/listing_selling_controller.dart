import 'dart:async';
import 'package:get/get.dart';
import 'package:untitled/Utils/loader.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/Listing/Selling/GetSellingListing.dart';

class GetSellingListingController extends GetxController {
  final Repository _repository = Repository();

  var data = [].obs;
  Future getSellingListing(String userId) async {
    Get.dialog(Loader(), barrierDismissible: false);
    Map<String, String> map = Map();
    map["userId"] = SharedPref.getInstance().getUserId();

    GetSellingListing response = await _repository.getMySellingList(map);
    Get.back();
    if (response.success) {
      data.assignAll(response.data);
      print(response.toJson());
      print(data.length);
      //   Get.offAll(BottomScreen());
    } else {
      //FrequentUtils.getInstance().showMessage(response.message);
    }
  }

  bool get haveSellingItems => !data.isNullOrBlank;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
