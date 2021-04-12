import 'package:get/get.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/Utils/loader.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/Delete/DeleteCartData.dart';
import 'package:untitled/model/Home/AddToCart/AddToCart.dart';
import 'package:untitled/model/Home/Data.dart';
import 'package:untitled/model/Home/GetProduct/Data.dart' as ss;
import 'package:untitled/model/Home/GetProduct/GetProduct.dart';
import 'package:untitled/model/Home/HomeData.dart';
import 'package:untitled/model/filterData/filter_data.dart';
import 'package:untitled/views/First/first.dart';
import 'package:geolocator/geolocator.dart';
import 'package:untitled/Utils/my_extensions.dart';

class HomeController extends GetxController {
  final Repository _repository = Repository();
  FilterData requestFilter = FilterData();

  RxInt tapped = (-1).obs;
  RxInt selectedTab = 0.obs;
  RxList<ss.Data> recommendationsList = <ss.Data>[].obs;
  RxList<Data> categoryData = <Data>[].obs;
  RxList<ss.Data> searchList = <ss.Data>[].obs;
  RxInt selectedCategory = 0.obs;
  RxString selectedAddress = "".obs;

  Position selectedPosition;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  fetchProductsForLocation() {
    if (currentPosition == null) {
      geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        selectedPosition = position;

        getProduct();
      }).catchError((e) {
        print("loc err: " + e.toString());
        getProduct();
      });
    } else {
      getProduct();
    }
  }

  getCategories() async {
    HomeData response = await _repository.getHome();
    if (response.success) {
      if (categoryData.value != null && categoryData.value.isNotEmpty)
        categoryData.clear();
      categoryData.add(Data(categoryname: "All", imageType: "all"));
      categoryData.addAll(response.data);
    }
  }

  Future getProduct() async {
    Get.dialog(Loader(), barrierDismissible: false);
    Map<String, String> map = Map();
    map["userId"] = SharedPref.getInstance().getUserId();
    map["distance"] = (requestFilter?.distance ?? "").isNotEmpty
        ? requestFilter?.distance
        : "50";
    map["latitude"] = (currentPosition?.latitude ?? 0.0).toString();
    map["longitude"] = (currentPosition?.longitude ?? 0.0).toString();
    map["categoryId"] = requestFilter?.categoryId ?? "";
    map["minprice"] = (requestFilter?.minPrice ?? "").isNotEmpty
        ? requestFilter?.minPrice
        : "0";
    map["maxprice"] = (requestFilter?.maxPrice ?? "").isNotEmpty
        ? requestFilter.maxPrice
        : "500000";
    GetProduct response = await _repository.getProduct(map);
    Get.back();

    if (response.success) {
      recommendationsList.assignAll(response.data);
      searchList.assignAll(response.data);
    } else {
      if (response.message != "Record not found.") {
        FrequentUtils.getInstance().showMessage(response.message);
      } else {
        recommendationsList.clear();
      }
    }
  }

  Future addToWishList(int position, String userId, String productId) async {
    Get.dialog(Loader(), barrierDismissible: false);
    AddToCart response = await _repository.getAddCart(userId, productId);
    Get.back();
    if (response.success) {
      List<ss.Data> temp = [];
      temp.addAll(recommendationsList.value);
      temp[position].favorite = "1";
      recommendationsList.assignAll(temp);
    } else {
      FrequentUtils.getInstance().showMessage(response.message);
    }
  }

  Future deleteCartItem(int position, String favoriteId) async {
    print(favoriteId);
    Get.dialog(Loader(), barrierDismissible: false);

    DeleteCartData response = await _repository.deleteCartItemById(
        SharedPref.instancee.getUserId(), favoriteId);
    Get.back();
    if (response.success) {
      List<ss.Data> temp = [];
      temp.addAll(recommendationsList.value);
      temp[position].favorite = "0";
      recommendationsList.assignAll(temp);
    } else {
      FrequentUtils.getInstance().showMessage(response.message);
    }
  }

  bool isWishItem(int index) =>
      (recommendationsList[index].favorite.toString() == "1");

  setProducts(List<ss.Data> products) {
    print("serch ${products.length}");
    recommendationsList.assignAll(products);
  }

  showAllProducts() {
    recommendationsList.assignAll(searchList);
  }

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
