import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/Utils/loader.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'dart:async';

import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/GetUserDetails/GetUserDetailsData.dart';
import 'package:untitled/model/Logout/LogoutData.dart';
import 'package:untitled/model/Logout/LogoutData.dart';
import 'package:untitled/model/Logout/LogoutData.dart';
import 'package:untitled/model/Profile/ProfileData.dart';
import 'package:untitled/navigation_routes.dart';
import 'package:untitled/views/First/first.dart';
import 'package:untitled/views/Home/home.dart';
import 'package:untitled/Utils/my_extensions.dart';
class ProfileController extends GetxController {
  final Repository _repository = Repository();
  RxString avatarUrl="".obs;
  var getUserDetails= GetUserDetailsData().obs;
  var getLogout = LogoutData().obs;
  var data = ProfileData().obs;

  bool isAvatar(){
    print("avatar-->${getUserDetails.value.data!=null && getUserDetails.value.data.avatar.isNotNullOrEmpty()}");
    return (getUserDetails.value.data!=null && getUserDetails.value.data.avatar.isNotNullOrEmpty());
  }

  Future saveProfile(File avatar,String email, String phone,String address) async {
    if (email.isEmpty) {
      FrequentUtils.getInstance().showMessage("Please enter email");
      return;
    }
    if (!GetUtils.isEmail(email)) {
      FrequentUtils.getInstance().showMessage("Please enter valid email id");
      return;
    }
    if (phone.isEmpty) {
      FrequentUtils.getInstance().showMessage("Please enter phone number");
      return;
    }
    if (address.isEmpty) {
      FrequentUtils.getInstance().showMessage("Please enter address");
      return;
    }

//    if (avatar == null) {
//      FrequentUtils.getInstance().showMessage('Please add image');
//      return;
//    }

    Get.dialog(Loader(), barrierDismissible: false);
    ProfileData response = await _repository.getProfile(avatar,email, phone, address);
    Get.back();
    if (response.success) {
      data.value = response;
      SharedPref.getInstance().setAvatar(response.data.avatar);
      SharedPref.getInstance().setEmailId(response.data.email.toString());
      SharedPref.getInstance().setPhone(response.data.phone.toString());
      SharedPref.getInstance().setAddress(response.data.address.toString());

      FrequentUtils.getInstance().showMessage("Profile updated successfully");
    } else {
      FrequentUtils.getInstance().showMessage(response.message);
    }
  }

  Future getUserDetailsData(String userId) async {
    Get.dialog(Loader(), barrierDismissible: false);
    Map<String, String> map = Map();
    map["userId"] = SharedPref.getInstance().getUserId();

    GetUserDetailsData response = await _repository.getUserDetailsData(map);
    Get.back();
    if (response.success) {
      getUserDetails.value=response;
      if(isAvatar()) avatarUrl.value=response.data.avatar;
      print(response.toJson());
    } else {
      //FrequentUtils.getInstance().showMessage(response.message);
    }
  }

  Future getLogoutData(String userId) async {
    Get.dialog(Loader(), barrierDismissible: false);
    LogoutData response = await _repository.getLogoutData(userId);
    Get.back();
    if (response.success) {
      SharedPref.getInstance().clear();
      Get.offNamedUntil(NavigationRoutes.loginScreen, (_) => false);
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
