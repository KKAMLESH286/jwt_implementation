import 'dart:async';
import 'package:get/get.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/Utils/loader.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/Utils/my_extensions.dart';
import 'package:untitled/model/Listing/Selling/Data.dart' as sellingData;
import 'package:untitled/model/Listing/Expired/Data.dart' as expiredData;
import 'package:untitled/model/SoldOrder/MySoldProductData.dart' as soldData;
import 'package:untitled/model/SoldResponse/Data.dart' as soldProductList;
import 'package:untitled/model/chat/ChatUserData.dart';
import 'package:untitled/model/chat/ChatUsersResponse.dart';

class ChatScreenController extends GetxController {
  final Repository _repository = Repository();

  RxList<ChatUserData> chatList = <ChatUserData>[].obs;

  Future getMessages(String userId, String receiverId, String productId) async {
    if (haveSellingItems.not()) {
      Get.dialog(Loader(), barrierDismissible: false);
      ChatUsersResponse response =
          await _repository.getChats(userId, receiverId, productId);
      Get.back();
      if (response.success) {
        chatList.assignAll(response.data.reversed);
      } else {
        FrequentUtils.getInstance().showMessage(response.message);
      }
    }
  }

  addMessage(Map<String, dynamic> data) {
    if (chatList != null) {
      var v = ChatUserData();
      v.userId = data["userId"];
      v.username = data["username"];
      v.message = data["message"];
      v.chatId = data["chatId"];
      v.type = data["type"];
      v.productId = data["productId"];
      v.receiverPic = data["receiverPic"];
      v.receivername = data["receivername"];
      v.receiverId = data["receiverId"];
      v.userPic = data["userPic"];

      chatList.insert(0, v);
    }
  }

  bool get haveSellingItems => chatList.isNotNullOrEmpty();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
