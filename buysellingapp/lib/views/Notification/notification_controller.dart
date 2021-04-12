import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/Utils/loader.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/notificationlisting/Data.dart';
import 'package:untitled/model/notificationlisting/NotifitionResponse.dart';
import 'package:untitled/Utils/my_extensions.dart';

class NotificationController extends GetxController {
  final Repository _repository = Repository();

  RxList<NotificationData> notificationList = <NotificationData>[].obs;

  Future getNotification() async {
    Get.dialog(Loader(), barrierDismissible: false);
    NotificationListingResponse response =
        await _repository.getnotificationListing();
    Get.back();
    if (response.success) {
      notificationList.assignAll(response.data.reversed);
    }
  }

  bool get haveNotificationListing => notificationList.isNotNullOrEmpty();
}
