import 'dart:async';
import 'package:get/get.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/Utils/loader.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/Login/Login.dart';
import 'package:untitled/model/ResetPassword/ChangePassword.dart';
import 'package:untitled/views/Home/home.dart';

class PasswordController extends GetxController {
  final Repository _repository = Repository();
  var data = ChangePassword().obs;

  Future getPassword(String userId,String password,String newPassword)async {

    if (password.isEmpty) {
      FrequentUtils.getInstance().showMessage("Please enter password");
      return;
    }
    if (password.isEmpty) {
      FrequentUtils.getInstance().showMessage("Please enter confirm password");
      return;
    }

    Get.dialog(Loader(), barrierDismissible: false);
    ChangePassword response = await _repository.getPassword(userId,password,newPassword);
    Get.back();
    if (response.success) {
      data.value = response;
      FrequentUtils.getInstance().showMessage(data.value.message);
      Get.offAll(BottomScreen());
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
