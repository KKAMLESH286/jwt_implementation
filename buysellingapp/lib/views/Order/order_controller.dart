import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/Utils/loader.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/Login/Data.dart';
import 'package:untitled/model/Login/Login.dart';
import 'package:untitled/model/sendMessageResponse/ChatMessageResponse.dart';

class OrderController extends GetxController {
  final Repository _repository = Repository();
  TextEditingController chatController = TextEditingController();
  FocusNode chatControllerFN = FocusNode();
  RxString isreported = "1".obs;

  RxBool canSendMessage = false.obs;
  Rx<UserData> receiverData = UserData().obs;

  Future sendMessage(
    String userId,
    String username,
    String userPic,
    String receiverId,
    String productId,
    String message,
  ) async {
    if (message.isEmpty) {
      FrequentUtils.getInstance().showMessage("Please type a message");
      return;
    }

    Get.dialog(Loader(), barrierDismissible: false);
    ChatMessageResponse response = await _repository.sendMessage(
        userId,
        username,
        userPic,
        receiverId,
        receiverData.value.name,
        receiverData.value.avatar,
        productId,
        userId + productId + receiverId,
        "buyer",
        message);
    Get.back();
    FrequentUtils.getInstance().showMessage(response.message);
    chatController.clear();
  }

  Future getUserDetails(String userId) async {
    Get.dialog(Loader(), barrierDismissible: false);
    Login response = await _repository.getUserDetails(userId);
    Get.back();
    if (response.success) {
      chatController.clear();
      receiverData.value = response.data;
    } else {
      FrequentUtils.getInstance().showMessage(response.message);
    }
  }

  bool get haveReceiverImage {
    return (receiverData.value != null &&
        !receiverData.value.avatar.isNullOrBlank);
  }

  get receiverImage => receiverData.value.avatar;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    chatController.dispose();
    super.onClose();
  }
}
