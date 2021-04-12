import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/Utils/loader.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/AddProduct/AddProductData.dart';
import 'package:untitled/model/Filter/Data.dart';
import 'package:untitled/model/Filter/FilterResponse.dart';
import 'package:untitled/model/RequestAddProduct/RequestProductData.dart';
import 'package:untitled/views/Home/home.dart';
import 'package:untitled/model/AddProduct/Data.dart' as ss;

class AddFourController extends GetxController {
  final Repository _repository = Repository();
  RxList<Data> data = <Data>[].obs;
  RxList<ss.ProductData> addProductData = <ss.ProductData>[].obs;
  RxInt tappedSubCat = (-1).obs;

  final TextEditingController priceTEC = TextEditingController();
  final TextEditingController descriptionTEC = TextEditingController();

  final FocusNode priceFN = FocusNode();
  final FocusNode descriptionFN = FocusNode();

  //var Data = AddProductData().obs;

  getsubCategoryApi(id) async {
    Get.dialog(Loader(), barrierDismissible: false);
    AddFourResponse response = await _repository.getsubcategory(id);
    Get.back();
    if (response.success) {
      data.assignAll(response.data);
    } else {
      // FrequentUtils.getInstance().showMessage(response.message);
    }
  }

  Future addProduct(RequestProductData productData) async {
    Get.dialog(Loader(), barrierDismissible: false);
    AddProductData response = await _repository.addProducts(productData);
    Get.back();
    if (response.success) {
      Get.offAll(BottomScreen());
    } else {
      FrequentUtils.getInstance().showMessage(response.message);
    }
  }

  bool get haveCategory => !data.isBlank;

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
    priceTEC.dispose();
    descriptionTEC.dispose();
    super.onClose();
  }
}
