import 'package:get/get.dart';

class AddThreeController extends GetxController {
  RxString selectedConditionId = "".obs;
  RxString conditionDesc = 'Select the condition that fits best'.obs;
  RxString selectedAddress = "Set address here".obs;

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
    // firstFile.close();
    super.onClose();
  }
}