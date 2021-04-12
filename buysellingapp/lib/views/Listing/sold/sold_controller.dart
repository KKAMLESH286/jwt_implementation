import 'package:get/get.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/SoldOrder/MySoldProductData.dart';
import 'package:untitled/model/Home/GetProduct/Data.dart' as ss;

class SoldController extends GetxController {
  final Repository _repository = Repository();

  RxList<MySoldProductData> data = <MySoldProductData>[].obs;

  // Future getSoldOrders() async {
  //   Get.dialog(Loader(), barrierDismissible: false);
  //   MySoldProductsResponse response = await _repository.getSoldOrder();
  //   Get.back();
  //   if (response.success) {
  //     data.assignAll(response.data);
  //   }
  // }

  bool get haveSoldItems => !data.isNullOrBlank;

  @override
  void onInit() {
    print("on init");
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
