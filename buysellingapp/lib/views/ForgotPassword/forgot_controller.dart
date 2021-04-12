import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/ForgotPassword/Forgot.dart';

class ForgotController extends GetxController {
  final Repository _repository = Repository();
  final TextEditingController emailTEC = TextEditingController();

  Future getForgot(String email) async {
    if (email.isEmpty) {
      FrequentUtils.getInstance().showMessage("Please enter email id");
      return;
    }
    if (!GetUtils.isEmail(email)) {
      FrequentUtils.getInstance().showMessage("Please enter valid email id");
      return;
    }
    _forgot(email);
  }

  _forgot(String email) async {
    Forgot response = await _repository.getForgot(email);
    print(response.message);
    Get.back();
    if (response.success) {
      FrequentUtils.getInstance().showMessage(response.message);
    } else {
      FrequentUtils.getInstance().showMessage(response.message);
    }
    emailTEC.text = " ";
  }

  @override
  void onClose() {
    emailTEC.dispose();
    super.onClose();
  }
}
