import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/Utils/loader.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/ForgotPassword/Forgot.dart';

class EditSellingController extends GetxController {
  final Repository _repository = Repository();

  Future editProduct(
      File avatar, String price, String description, String location) async {
    if (avatar == null) {
      FrequentUtils.getInstance().showMessage('Please add image');
      return;
    }
    // if (category.isEmpty) {
    //   FrequentUtils.getInstance().showMessage("Please enter category");
    //   return;
    // }
    // if (subcategory.isEmpty) {
    //   FrequentUtils.getInstance().showMessage("Please enter subcategory");
    //   return;
    // }
    if (price.isEmpty) {
      FrequentUtils.getInstance().showMessage("Please enter price");
      return;
    }

    Get.dialog(Loader(), barrierDismissible: false);
    // ProfileData response =
    //     await _repository.getProfile(avatar, category, subcategory, price);
    Get.back();
    // if (response.success) {
    //   data.value = response;
    //   SharedPref.getInstance().setAddress(response.data.address.toString());
    //
    //   FrequentUtils.getInstance().showMessage("Profile updated successfully");
    // }
    // else {
    //   FrequentUtils.getInstance().showMessage(response.message);
    // }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
