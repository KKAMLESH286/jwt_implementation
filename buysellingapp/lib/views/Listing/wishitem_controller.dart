import 'dart:async';
import 'package:get/get.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/Utils/loader.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/Delete/Data.dart' as delete;
import 'package:untitled/model/Delete/DeleteCartData.dart';
import 'package:untitled/model/Listing/Selling/GetSellingListing.dart';
import 'package:untitled/model/Listing/Selling/Data.dart' as sellingData;

class WishItemController extends GetxController {
  final Repository _repository = Repository();
  RxList<sellingData.Data> data = <sellingData.Data>[].obs;

  // Future getWishItem(String userId) async {
  //   Get.dialog(Loader(), barrierDismissible: false);
  //   Map<String, String> map = Map();
  //   map["userId"] = SharedPref.getInstance().getUserId();
  //   GetSellingListing response = await _repository.getWishItem(map);
  //   Get.back();
  //   if (response.success) {
  //     data.assignAll(response.data);
  //   } else {
  //     // FrequentUtils.getInstance().showMessage(response.message);
  //   }
  // }

  Future deleteCartItem(int position, String favoriteId) async {
    print(favoriteId);
    Get.dialog(Loader(), barrierDismissible: false);
    Map<String, String> map = Map();
    map["favoriteId"] = favoriteId;
    DeleteCartData response = await _repository.deleteCartItems(favoriteId);
    Get.back();
    if (response.success) {
      print(response.toJson());
      print(data.length);
      List<sellingData.Data> temp = [];
      temp.addAll(data);
      temp.removeAt(position);
      data.assignAll(temp);
    } else {
      FrequentUtils.getInstance().showMessage(response.message);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
