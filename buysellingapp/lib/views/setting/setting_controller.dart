import 'dart:async';
import 'package:get/get.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/Utils/loader.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/Logout/LogoutData.dart';
import 'package:untitled/model/Setting/NotificationResponse.dart';
import 'package:untitled/views/First/first.dart';


class SettingController extends GetxController {
  final Repository _repository = Repository();
  var data = NotificationResponse().obs;
  RxBool isSwitched = false.obs;
  var getLogout = LogoutData().obs;
  String isSuccess = 'no';


  Future postNotification() async {
    Get.dialog(Loader(), barrierDismissible: false);
    NotificationResponse response = await _repository.notification(isSwitched.value);
    Get.back();
    if (response.success) {
      data.value = response;
      isSuccess = "success";
      SharedPref.getInstance().setBoolean("push", response.data.notification);
      FrequentUtils.getInstance().showMessage(data.value.message);
    } else {
      FrequentUtils.getInstance().showMessage(response.message);
    }
  }

  Future getLogoutData(String userId) async {
    Get.dialog(Loader(), barrierDismissible: false);
    LogoutData response = await _repository.getLogoutData(userId);
    Get.back();
    if (response.success) {
      SharedPref.getInstance().clear();
      Get.offAll(FirstScreen());
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
