import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/Utils/loader.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/SignUp/SignUp.dart';

import 'package:untitled/views/Home/home.dart';

class SignupController extends GetxController {
  final Repository _repository = Repository();
  var data = SignUp().obs;

  Future getSignUp(String name, String email,
      String password, String phone, String address, bool valuefirst, String gender) async {
    if (name.isEmpty) {
      FrequentUtils.getInstance().showMessage("Please enter name");
      return;
    }
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

    if (FrequentUtils.getInstance().isInvalidPassword(password)) {
      FrequentUtils.getInstance().showMessage(
          "Password must contain atleast 8 characters,including special character, numbers & lower case");
      return;
    }

    if (phone.isEmpty) {
      FrequentUtils.getInstance().showMessage("Please enter your phone number");
      return;
    }

    if (!GetUtils.isPhoneNumber(phone)) {
      FrequentUtils.getInstance()
          .showMessage("Please enter valid phone number");
      return;
    }

    if (address.isEmpty) {
      FrequentUtils.getInstance().showMessage("Please enter your address");
      return;
    }

    if (gender.isNullOrBlank) {
      FrequentUtils.getInstance()
          .showMessage("Please select your gender");
      return;
    }

    if (valuefirst != true) {
      FrequentUtils.getInstance()
          .showMessage("Please select the terms & services");
      return;
    }

    var token = await FirebaseMessaging().getToken();
    // var token = "";
    print("token: $token");

    Get.dialog(Loader(), barrierDismissible: false);
    SignUp response =
        await _repository.getSignUp(name, email, password, phone, address, gender, token);
    Get.back();
    if (response.success) {
      data.value = response;
      SharedPref.getInstance().setUserId(response.data.id.toString());
      SharedPref.getInstance().setUserName(response.data.name);
      SharedPref.getInstance().setAvatar(response.data.avatar);
      SharedPref.getInstance().setEmailId(response.data.email.toString());
      SharedPref.getInstance().setPhone(response.data.phone.toString());
      SharedPref.getInstance().setAddress(response.data.address.toString());

      Get.offAll(BottomScreen());
    } else {
      print("sign_up_err: ${response.message}");
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
