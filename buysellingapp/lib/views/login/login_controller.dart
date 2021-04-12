import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/Utils/loader.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/Login/Login.dart';
import 'package:untitled/views/Home/home.dart';

class LoginController extends GetxController {
  final Repository _repository = Repository();
  var data = Login().obs;

  Future getLogin(String email, String password) async {
    if (email.isEmpty) {
      FrequentUtils.getInstance().showMessage("Please enter email id");
      return;
    }

    if (!GetUtils.isEmail(email)) {
      FrequentUtils.getInstance().showMessage("Please enter valid email id");
      return;
    }

    if (password.isEmpty) {
      FrequentUtils.getInstance().showMessage("Please enter password");
      return;
    }

    // if (FrequentUtils.getInstance().isInvalidPassword(password)) {
    //   FrequentUtils.getInstance().showMessage("Please enter valid password");
    //   return;
    // }
    var token = await FirebaseMessaging().getToken();
    // var token = "";

    Get.dialog(Loader(), barrierDismissible: false);
    Login response = await _repository.getLogin(email, password, token);
    Get.back();
    if (response.success) {
      data.value = response;
      print("LoggenIn UserName: ${response.data.name}");


      SharedPref.getInstance().setUserId(response.data.id.toString());
      SharedPref.getInstance().setUserName(response.data.name);
      SharedPref.getInstance().setAvatar(response.data.avatar);
      SharedPref.getInstance().setEmailId(response.data.email.toString());
      SharedPref.getInstance().setPhone(response.data.phone.toString());
      SharedPref.getInstance().setAddress(response.data.address.toString());

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
