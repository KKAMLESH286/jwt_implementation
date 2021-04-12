//import 'package:get/get.dart';
//import 'package:untitled/Utils/frequent_utils.dart';
//import 'package:untitled/Utils/loader.dart';
//import 'package:untitled/WebServices/repository.dart';
//import 'package:untitled/model/Filter/MessageData.dart';
//import 'package:untitled/model/filterData/filter_data.dart';
//
//class FilterController extends GetxController {
//  final Repository _repository = Repository();
//  FilterData requestFilter = FilterData();
//  RxList<Data> data = <Data>[].obs;
//
//  // getsubCategoryApi() async {
//  //   Get.dialog(Loader(), barrierDismissible: false);
//  //   // AddFourResponse response = await _repository.getsubcategory();
//  //   Get.back();
//  //   if (response.success) {
//  //     data.assignAll(response.data);
//  //   } else {
//  //     FrequentUtils.getInstance().showMessage(response.message);
//  //   }
//  // }
//
//  bool get haveCategory => !data.isNullOrBlank;
//
//  @override
//  void onInit() {
//    print("on init");
//    super.onInit();
//  }
//
//  @override
//  void onReady() {
//    print("on ready");
//    super.onReady();
//  }
//
//  @override
//  void onClose() {
//    super.onClose();
//  }
//}
