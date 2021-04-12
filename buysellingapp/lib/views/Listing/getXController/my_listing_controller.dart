import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/Utils/loader.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/Delete/DeleteCartData.dart';
import 'package:untitled/model/Listing/Expired/ExpiredProducts.dart';
import 'package:untitled/model/Listing/Selling/GetSellingListing.dart';
import 'package:untitled/Utils/my_extensions.dart';
import 'package:untitled/model/SoldOrder/MySoldProductsResponse.dart';
import 'package:untitled/model/Listing/Selling/Data.dart' as sellingData;
import 'package:untitled/model/Listing/Expired/Data.dart' as expiredData;
import 'package:untitled/model/SoldOrder/MySoldProductData.dart' as soldData;
import 'package:untitled/model/SoldResponse/Data.dart' as soldProductList;
import 'package:untitled/model/SoldResponse/Data.dart';
import 'package:untitled/model/Home/GetProduct/Image.dart' as getProImg;
import 'package:untitled/model/deleteproduct/DeleteProduct.dart';

class GetMyListingController extends GetxController {
  final Repository _repository = Repository();

  RxList<sellingData.Data> sellingList = <sellingData.Data>[].obs;
  RxList<expiredData.Data> expiredList = <expiredData.Data>[].obs;
  RxList<soldData.MySoldProductData> soldList =
      <soldData.MySoldProductData>[].obs;
  RxList<sellingData.Data> wishList = <sellingData.Data>[].obs;
  RxList<SoldProductData> soldProductList = <SoldProductData>[].obs;
  bool matchDate(String previousDate, String currentDate) {
    var date = DateTime.parse(currentDate);
    var prev = DateTime.parse(previousDate);
    return (date.day == prev.day &&
        date.month == prev.month &&
        date.year == prev.year);
  }

  Future getSellingListing() async {
    if (haveSellingItems.not()) {
      Get.dialog(Loader(), barrierDismissible: false);
      GetSellingListing response = await _repository
          .getMySellingList({"userId": SharedPref.getInstance().getUserId()});
      Get.back();
      if (response.success) {
        sellingList.assignAll(response.data);
      } else {
        if (response.message != "Record not found.") {
          FrequentUtils.getInstance().showMessage(response.message);
        }
      }
    }
  }

  Future sellProduct(
    int position,
    String id,
    bool status,
  ) async {
    Get.dialog(Loader(), barrierDismissible: false);
    Map<String, dynamic> response = await _repository
        .soldproduct({"productId": id, "sold": status.toString()});
    Get.back();
    if (response["success"]) {
      sellingList.removeAt(position);
      Future.delayed(Duration(milliseconds: 100)).then((value) {
        soldList.clear();
        getSoldListing();
      });

      // FrequentUtils.getInstance().showMessage(response["message"]);
    } else {
      FrequentUtils.getInstance().showMessage(response["message"]);
    }
  }

  deleteItem(int position) {
    sellingList.removeAt(position);
  }

  Future getExpiredListing() async {
    if (haveExpiredItems.not()) {
      Get.dialog(Loader(), barrierDismissible: false);
      ExpiredProducts response = await _repository
          .getExpiredListing({"userId": SharedPref.getInstance().getUserId()});
      Get.back();
      if (response.success) {
        expiredList.assignAll(response.data);
      } else {
        if (response.message != "Record not found.") {
          FrequentUtils.getInstance().showMessage(response.message);
        }
      }
    }
  }

  Future getSoldListing() async {
    if (haveSoldItems.not()) {
      Get.dialog(Loader(), barrierDismissible: false);
      MySoldProductsResponse response = await _repository.getSoldOrder();
      Get.back();
      if (response.success) {
        soldList.assignAll(response.data);
      } else {
        if (response.message != "Record not found.") {
          FrequentUtils.getInstance().showMessage(response.message);
        }
      }
    }
  }

  Future getWishItem() async {
    if (haveWishListItems.not()) {
      Get.dialog(Loader(), barrierDismissible: false);
      GetSellingListing response = await _repository
          .getWishItem({"userId": SharedPref.getInstance().getUserId()});
      Get.back();
      if (response.success) {
        wishList.assignAll(response.data);
      } else {
        if (response.message != "Record not found.") {
          FrequentUtils.getInstance().showMessage(response.message);
        }
      }
    }
  }

  Future deleteCartItemFromWishList(int position, String favoriteId) async {
    print(favoriteId);
    Get.dialog(Loader(), barrierDismissible: false);

    DeleteCartData response = await _repository.deleteCartItemById(
        SharedPref.instancee.getUserId(), favoriteId);
    Get.back();
    if (response.success) {
      List<sellingData.Data> temp = [];
      temp.addAll(wishList);
      temp.removeAt(position);
      wishList.assignAll(temp);
    } else {
      FrequentUtils.getInstance().showMessage(response.message);
    }
  }

  Future deleteproductFromSold(int position, String productId) async {
    print(productId);
    Get.dialog(Loader(), barrierDismissible: false);
    DeleteProduct response = await _repository.deleteproduct(productId);
    Get.back();
    if (response.success) {
      List<soldData.MySoldProductData> temp = [];
      temp.addAll(soldList);
      temp.removeAt(position);
      soldList.assignAll(temp);
      // FrequentUtils.getInstance().showMessage(response.m);
    } else {
      // FrequentUtils.getInstance().showMessage(response.s);
    }
  }

  Future deleteproductFromSelling(int position, String productId) async {
    print(productId);
    Get.dialog(Loader(), barrierDismissible: false);

    DeleteProduct response = await _repository.deleteproduct(productId);
    Get.back();
    if (response.success) {
      List<sellingData.Data> temp = [];
      temp.addAll(sellingList);
      temp.removeAt(position);
      sellingList.assignAll(temp);
      // FrequentUtils.getInstance().showMessage(response.);
    } else {
      FrequentUtils.getInstance().showMessage(response.message);
    }
  }
  Future restoreProduct(
    int position,
    String id,
    bool status,
  ) async {
    Get.dialog(Loader(), barrierDismissible: false);
    Map<String, dynamic> response = await _repository
        .soldproduct({"productId": id, "sold": status.toString()});
    Get.back();
    if (response["success"]) {
      soldList.removeAt(position);
      Future.delayed(Duration(milliseconds: 100)).then((value) {
        sellingList.clear();
        getSellingListing();
      });

      // FrequentUtils.getInstance().showMessage(response["message"]);
    } else {
      FrequentUtils.getInstance().showMessage(response["message"]);
    }
  }
 
  //-----------

  bool get haveSellingItems => sellingList.isNotNullOrEmpty();

  bool get haveSoldProducts => soldProductList.isNotNullOrEmpty();

  bool get haveExpiredItems => expiredList.isNotNullOrEmpty();

  bool get haveSoldItems => soldList.isNotNullOrEmpty();

  bool get haveWishListItems => wishList.isNotNullOrEmpty();

  bool haveProductImages(int index) =>
      haveSoldItems &&
      soldList[index] != null &&
      soldList[index].images.isNotNullOrEmpty();

  List<getProImg.Image> productImages(int index) => soldList[index].images;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
