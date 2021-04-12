import 'package:get/get.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/Utils/loader.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/chat/ChatUserData.dart';
import 'package:untitled/model/chat/ChatUsersResponse.dart';

class ChatUsersController extends GetxController {
  final Repository _repository = Repository();
  RxList<ChatUserData> allChats = <ChatUserData>[].obs;
  RxList<ChatUserData> buyingChats = <ChatUserData>[].obs;
  RxList<ChatUserData> sellingChats = <ChatUserData>[].obs;

  getChatUsers() async {
    Get.dialog(Loader(), barrierDismissible: false);
    ChatUsersResponse response = await _repository.getChatUsers(SharedPref.instancee.getUserId());
    Get.back();
    if (response.success) {
      allChats.assignAll(response.data);
      buyingChats.assignAll(response.data.where((d) => d.productId.userId != SharedPref.instancee.getUserId()));
      sellingChats.assignAll(response.data.where((d) => d.productId.userId == SharedPref.instancee.getUserId()));
    } else {
      if(response.message != "Record not found.") {
        FrequentUtils.getInstance().showMessage(response.message);
      }
    }
  }

  bool get haveUsers => !allChats.isNullOrBlank;
  bool get haveBuyingUsers => !buyingChats.isNullOrBlank;
  bool get haveSellingUsers => !sellingChats.isNullOrBlank;

  @override
  void onInit() {
    print("on init");
    super.onInit();
  }

  @override
  void onReady() {
    print("on ready");
    super.onReady();
  }

  @override
  void onClose() {
    print("on ready");
    super.onClose();
  }
}
