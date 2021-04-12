import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/Utils/loader.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/Filter/FilterResponse.dart';
import 'package:untitled/model/RequestAddProduct/RequestProductData.dart';
import 'package:untitled/model/conditions/ConditionData.dart';
import 'package:untitled/model/conditions/ProductConditionsResponse.dart';
import 'package:untitled/model/selling/Data.dart';
import 'package:untitled/model/selling/SellingResponse.dart';
import 'package:untitled/model/Filter/Data.dart' as subCatData;
import 'package:untitled/views/First/first.dart';

class SellingController extends GetxController {
  final Repository _repository = Repository();
  RxList<Data> data = <Data>[].obs;
  RxList<subCatData.Data> subCategories = <subCatData.Data>[].obs;
  RxList<ConditionData> conditions = <ConditionData>[].obs;
  RxList<File> imagedata = <File>[].obs;
  RequestProductData requestData = RequestProductData();
  RxInt tapped = (-1).obs;
  RxInt step = 1.obs;

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  getCurrentLocation() {
    if(currentPosition == null) {
      geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        currentPosition = position;

      }).catchError((e) {
        print("loc err: "+e.toString());
      });
    } else {
    }
  }

  getCategoryApi() async {
    Get.dialog(Loader(), barrierDismissible: false);
    SellingResponse response = await _repository.getcategory();
    Get.back();
    if (response.success) {
      data.assignAll(response.data);
    }
  }

  fetchConditionsAndSubCategories(String categoryId) async {
    Get.dialog(Loader(), barrierDismissible: false);

    AddFourResponse response1 = await _repository.getsubcategory(categoryId);
    ProductConditionsResponse response2 = await _repository.getCondition();

    Get.back();

    if (response1.success) {
      subCategories.assignAll(response1.data);
    }

    if (response2.success) {
      conditions.assignAll(response2.data);
    }
  }

  getSubCategoriesOnly(String categoryId) async {
    Get.dialog(Loader(), barrierDismissible: false);
    AddFourResponse response1 = await _repository.getsubcategory(categoryId);
    Get.back();

    if (subCategories.value.isNotEmpty) {
      subCategories.clear();
    }

    if (response1.success) {
      subCategories.assignAll(response1.data);
    }
  }

  getCondition() async {
    Get.dialog(Loader(), barrierDismissible: false);
    ProductConditionsResponse response = await _repository.getCondition();
    Get.back();
    print("object: ${response}");
    if (response.success) {
      conditions.assignAll(response.data);
    }
  }

  bool get haveCategories => !data.isNullOrBlank;
  bool get haveSubCategories => !subCategories.isNullOrBlank;

  showMessage(String message) => FrequentUtils.getInstance().showMessage(message);

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
