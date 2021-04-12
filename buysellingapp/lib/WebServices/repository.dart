import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_with_interceptor.dart';
import 'package:untitled/Utils/constants.dart';
import 'package:untitled/Utils/interceptor.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:untitled/model/AddProduct/AddProductData.dart';
import 'package:untitled/model/Delete/DeleteCartData.dart';
import 'package:untitled/model/Filter/FilterResponse.dart';
import 'package:untitled/model/ForgotPassword/Forgot.dart';
import 'package:untitled/model/GetUserDetails/GetUserDetailsData.dart';
import 'package:untitled/model/Home/AddToCart/AddToCart.dart';
import 'package:untitled/model/Home/GetProduct/GetProduct.dart';
import 'package:untitled/model/Home/HomeData.dart';
import 'package:untitled/model/Listing/Expired/ExpiredProducts.dart';
import 'package:untitled/model/Listing/Selling/GetSellingListing.dart';
import 'package:untitled/model/Login/Login.dart';
import 'package:untitled/model/Logout/LogoutData.dart';
import 'package:untitled/model/Profile/ProfileData.dart';
import 'package:untitled/model/RequestAddProduct/RequestProductData.dart';
import 'package:untitled/model/ResetPassword/ChangePassword.dart';
import 'package:untitled/model/Setting/NotificationResponse.dart';
import 'package:untitled/model/SignUp/SignUp.dart';
import 'package:untitled/model/SoldOrder/MySoldProductsResponse.dart';
import 'package:untitled/model/chat/ChatUsersResponse.dart';
import 'package:untitled/model/conditions/ProductConditionsResponse.dart';
import 'package:untitled/model/deleteproduct/DeleteProduct.dart';
import 'package:untitled/model/notificationlisting/NotifitionResponse.dart';
import 'package:untitled/model/reportResponse/ReportResponse.dart';
import 'package:untitled/model/reportlisting/ReportListing.dart';
import 'package:untitled/model/selling/SellingResponse.dart';
import 'package:untitled/Utils/my_extensions.dart';
import 'package:untitled/model/sendMessageResponse/ChatMessageResponse.dart';
import 'ApiBaseHelper.dart';

const String SOCKET_EXCEPTION_MESSAGE =
    "Something went wrong. Please check your internet connection.";
const String SOMETHING_WRONG = "Something went wrong. Please try again later.";

class Repository {
  static final String profileImageUrl =
      "http://3.16.168.81:4000/uploads/profile/";
  // "http://18.191.217.189:4000/uploads/profile/";
  static final String imageUrl = "http://3.16.168.81:4000/uploads/product/";
  // static final String imageUrl = "http://18.191.217.189:4000/uploads/product/";
  static final String cat_imageUrl =
      "http://3.16.168.81:4000/uploads/category/";
  // "http://18.191.217.189:4000/uploads/category/";
  static final String condition_imageUrl =
      "http://3.16.168.81:4000/uploads/condition/";

  final String SIGN_UP = "signUp";
  final String Log_in = "signin";
  final String _Forgot = "forgotPassword";
  final String _Home = "getCategory";
  final String _Profile = "editProfile";
  final String GETCATEGORY = "getCategory";
  final String _GetProduct = "getProducts";
  final String _ChangePassword = "changePassword";
  final String _GetOrders = "getOrders";
  final String SUBCATEGORY = "getsubCategory";
  final String NOTIFICATION = "notification";
  final String ADDTOCART = "addtoCart";
  final String GetCartList = "getCartList";
  final String GetSellingList = "getMyProducts";
  final String GetExpiredList = "getMyExpProducts";
  final String DeleteCartItems = "deleteCartItems";
  final String DeleteCartItemsById = "DeleteCartItemsById";
  final String AddProducts = "addProducts";
  final String GetCondition = "getCondition";
  final String SendMessage = "addMessage";
  final String GetChatUsers = "getUsers";
  final String GetChats = "getChats";
  final String GetUserDetails = "getUserDetails";
  final String SOLDMYPRODUCTS = "soldMyProducts";
  final String REPORTLISTING = "getReportList";
  final String ADDREPORT = "addreport";
  final String DELETEPRODUCT = "deleteProducts";
  final String Logout = "logout";

  final ApiBaseHelper _baseHelper = ApiBaseHelper();
  final String Getorders = "getOrders";
  final String GetMySoldProducts = "getMySoldProducts";
  final String GETNOTIFICATION = "getNotifications";

  Future<SignUp> getSignUp(String name, String email, String password,
      String phone, String address, String gender, String token) async {
    SignUp responseJson;
    try {
      final response = await _baseHelper.post(SIGN_UP, <String, dynamic>{
        "usertype": "",
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "address": address,
        "gender": gender,
        "deviceId": token,
      });
      responseJson = SignUp.fromJson(response);
      print('response $responseJson');
    } catch (e) {
      responseJson = SignUp.fromJson(_exceptionHandler(e));
    }
    return responseJson;
  }

  Future<Login> getLogin(String email, String password, String token) async {
    Login responseJson;
    try {
      final response = await HttpWithInterceptor.build(
        interceptors: [LoggingInterceptor()],
        requestTimeout: Duration(minutes: 1),
      ).post(BASE_URL + Log_in, body: <String, dynamic>{
        "email": email,
        "password": password,
        "deviceId": token,
      });
      responseJson = Login.fromJson(jsonDecode(response.body));
      print(' response $responseJson');
    } catch (e) {
      responseJson = Login(success: false, message: e.toString());
    }
    return responseJson;
  }

  Future<Forgot> getForgot(
    String email,
  ) async {
    Forgot responseJson;
    try {
      final response = await HttpWithInterceptor.build(
        interceptors: [LoggingInterceptor()],
        requestTimeout: Duration(minutes: 1),
      ).post(BASE_URL + _Forgot, body: <String, dynamic>{
        "email": email,
      });
      responseJson = Forgot.fromJson(jsonDecode(response.body));
      print(' response $responseJson');
    } catch (e) {
      responseJson = Forgot(success: false, message: e.toString());
    }
    return responseJson;
  }

  Future<HomeData> getHome() async {
    HomeData responseJson;
    try {
      final response = await HttpWithInterceptor.build(
        interceptors: [LoggingInterceptor()],
        requestTimeout: Duration(minutes: 1),
      ).get(
        BASE_URL + _Home,
      );
      responseJson = HomeData.fromJson(jsonDecode(response.body));
      print(response.body);
    } catch (e) {
      responseJson = HomeData(success: false, message: e.toString());
    }
    return responseJson;
  }

  Future<ReportListing> getReportingapi() async {
    ReportListing responseJson;
    try {
      final response = await HttpWithInterceptor.build(
        interceptors: [LoggingInterceptor()],
        requestTimeout: Duration(minutes: 1),
      ).post(
        BASE_URL + REPORTLISTING,
      );
      responseJson = ReportListing.fromJson(jsonDecode(response.body));
      print(response.body);
    } catch (e) {
      responseJson = ReportListing(success: false, message: e.toString());
    }
    return responseJson;
  }

  Future<ReportResponse> reportProductApi(
    String reportId,
    String productId,
    String productUserId,
    String myName,
    String productName,
    String reportMessage,
  ) async {
    ReportResponse responseJson;
    try {
      final response = await HttpWithInterceptor.build(
        interceptors: [LoggingInterceptor()],
        requestTimeout: Duration(minutes: 1),
      ).post(BASE_URL + ADDREPORT, body: <String, dynamic>{
        "userId": SharedPref.getInstance().getUserId(),
        "reportId": reportId,
        "productId": productId,
        "receiverId": productUserId,
        "name": myName,
        "productName": productName,
        "reportMessage": reportMessage,
      });
      responseJson = ReportResponse.fromJson(jsonDecode(response.body));
      print(' response $responseJson');
    } catch (e) {
      responseJson = ReportResponse(success: false, message: e.toString());
    }
    return responseJson;
  }

  Future<ProfileData> getProfile(
    File avatar,
    String email,
    String phone,
    String address,
  ) async {
    ProfileData commonResponse;
    Map<String, String> req = Map();
    req["userId"] = SharedPref.getInstance().getUserId();
// req["avatar"] = SharedPref.getInstance().getAvatar();
    req["email"] = email;
    req["phone"] = phone;
    req["address"] = address;

    try {
      var url = Uri.parse(BASE_URL + _Profile);
      http.MultipartRequest request = new http.MultipartRequest('POST', url);
      http.MultipartFile multipartFile;
      if (avatar != null) {
        multipartFile =
            await http.MultipartFile.fromPath("avatar", avatar.path);
        request.files.add(multipartFile);
        req["file"] = multipartFile.filename;
      } else {
        print("file is null");
      }
      request.fields.addAll(req);
      var response = await request.send();
      var g =
          await response.stream.transform(utf8.decoder).listen((String res) {
        commonResponse = ProfileData.fromJson(jsonDecode(res));
// print("response ${response.reasonPhrase}");
        print("response-->${commonResponse.toJson()}");
      });
    } catch (e) {
      commonResponse =
          ProfileData.fromJson({"success": false, "message": e.toString()});
// commonResponse.success = false;
// commonResponse.success = false;
// commonResponse.message = e.toString();
    }
    return commonResponse;
  }

  Future<SellingResponse> getcategory() async {
    Map<String, String> map = Map();

    SellingResponse responseJson;
    try {
      final response = await HttpWithInterceptor.build(
        interceptors: [LoggingInterceptor()],
        requestTimeout: Duration(minutes: 1),
      ).get(BASE_URL + GETCATEGORY,
          // body: <String, dynamic>{},
          params: map);
      responseJson = SellingResponse.fromJson(jsonDecode(response.body));
      print(response.body);
    } catch (e) {
      responseJson = SellingResponse(success: false, message: e.toString());
    }
    return responseJson;
  }

  Future<GetProduct> getProduct(Map<String, dynamic> request) async {
    print(jsonEncode(request));
    GetProduct response;
    try {
      var responseBody = await _baseHelper.post(_GetProduct, request);
      print("before");
      response = GetProduct.fromJson(responseBody);
      print("after");
    } catch (e) {
      print("after catch ${e.toString()}");
      response = GetProduct.fromJson(_exceptionHandler(e));
    }
    return response;
  }

  Future<ChangePassword> getPassword(
      String userId, String password, String newPassword) async {
    ChangePassword responseJson;
    try {
      final response = await HttpWithInterceptor.build(
        interceptors: [LoggingInterceptor()],
        requestTimeout: Duration(minutes: 1),
      ).post(BASE_URL + _ChangePassword, body: <String, dynamic>{
        "userId": userId,
        "password": password,
        "newPassword": newPassword
      });
      responseJson = ChangePassword.fromJson(jsonDecode(response.body));
      print(' response $responseJson');
    } catch (e) {
      responseJson = ChangePassword(success: false, message: e.toString());
    }
    return responseJson;
  }

  Future<GetSellingListing> getMySellingList(
      Map<String, dynamic> request) async {
    print(jsonEncode(request));
    GetSellingListing response;
    try {
      var responseBody = await _baseHelper.post(GetSellingList, request);
      print("before");
      response = GetSellingListing.fromJson(responseBody);
      print('after');
    } catch (e) {
      response = GetSellingListing.fromJson(_exceptionHandler(e));
    }
    return response;
  }

  Future<Map<String, dynamic>> soldproduct(Map<String, dynamic> request) async {
    print(jsonEncode(request));
    Map<String, dynamic> response;
    try {
      var responseBody = await _baseHelper.post(SOLDMYPRODUCTS, request);
      print("before");
      response = responseBody;
      print('after');
    } catch (e) {
      response = _exceptionHandler(e);
    }
    return response;
  }

  Future<ExpiredProducts> getExpiredListing(
      Map<String, dynamic> request) async {
    print(jsonEncode(request));
    ExpiredProducts response;
    try {
      var responseBody = await _baseHelper.post(GetExpiredList, request);
      print("before");
      response = ExpiredProducts.fromJson(responseBody);
      print("after");
    } catch (e) {
      print("after catch ${e.toString()}");
      response = ExpiredProducts.fromJson(_exceptionHandler(e));
    }
    return response;
  }

  Future<AddToCart> getAddCart(String userId, String productId) async {
    AddToCart responseJson;
    try {
      final response = await HttpWithInterceptor.build(
        interceptors: [LoggingInterceptor()],
        requestTimeout: Duration(minutes: 1),
      ).post(BASE_URL + ADDTOCART,
          body: <String, dynamic>{"userId": userId, "productId": productId});
      responseJson = AddToCart.fromJson(jsonDecode(response.body));
      print(' response $responseJson');
    } catch (e) {
      responseJson = AddToCart(success: false, message: e.toString());
    }
    return responseJson;
  }

  Future<AddFourResponse> getsubcategory(id) async {
    Map<String, String> req = Map();
    // req["userId"] = SharedPref.getInstance().getUserId();
    AddFourResponse responseJson;
    try {
      final response = await HttpWithInterceptor.build(
        interceptors: [LoggingInterceptor()],
        requestTimeout: Duration(minutes: 1),
      ).post(
        BASE_URL + SUBCATEGORY,
        body: <String, dynamic>{
          "categoryId": id,
        },
      );

      responseJson = AddFourResponse.fromJson(jsonDecode(response.body));
      print(response.body);
    } catch (e) {
      responseJson = AddFourResponse(success: false, message: e.toString());
    }
    return responseJson;
  }

  Future<NotificationResponse> notification(bool notificationStatus) async {
    NotificationResponse responseJson;
    try {
      final response = await _baseHelper.post(NOTIFICATION, {
        "userId": SharedPref.getInstance().getUserId(),
        "notification": notificationStatus.toString(),
      });
      responseJson = NotificationResponse.fromJson(response);
      print(' response----->$responseJson');
    } catch (e) {
      responseJson = NotificationResponse.fromJson(_exceptionHandler(e));
    }
    return responseJson;
  }

  Future<GetSellingListing> getWishItem(Map<String, dynamic> request) async {
    print(jsonEncode(request));
    GetSellingListing response;
    try {
      var responseBody = await _baseHelper.post(GetCartList, request);
      print("before");
      response = GetSellingListing.fromJson(responseBody);
      print("after");
    } catch (e) {
      print("after catch ${e.toString()}");
      response = GetSellingListing.fromJson(_exceptionHandler(e));
    }
    return response;
  }

  // Future<CommonResponse> getcheckfollow(String status, String id) async {
  //   CommonResponse responseJson;
  //   try {
  //     final response = await HttpWithInterceptor.build(
  //       interceptors: [LoggingInterceptor()],
  //       requestTimeout: Duration(minutes: 1),
  //     ).post(BASE_URL + FOLLOW, body: <String, dynamic>{
  //       "follow_id": id,
  //       "status": status, //follow/unfollow
  //     }, headers: <String, String>{
  //       "Accept": "application/json",
  //       "Authorization": SharedPref.getInstance().getToken(), //"Bearer $token"
  //     });
  //     responseJson = CommonResponse.fromJson(jsonDecode(response.body));
  //     // print(response.body);
  //   } catch (e) {
  //     responseJson = CommonResponse(success: false, message: e.toString());
  //   }
  //   return responseJson;
  // }

  Future<DeleteCartData> deleteCartItems(favoriteid) async {
    // print(jsonEncode(request));
    DeleteCartData response;
    try {
      var url = Uri.parse(BASE_URL + DeleteCartItems);
      var responseBody = await HttpWithInterceptor.build(
        interceptors: [LoggingInterceptor()],
      ).post(
        url,
        body: <String, dynamic>{
          "favoriteId": favoriteid, //follow/unfollow
        },
      );
      print("before");
      response = DeleteCartData.fromJson(json.decode(responseBody.body));
      print("after");
    } catch (e) {
      print("after catch ${e.toString()}");
      response = DeleteCartData(success: false, message: e.toString());
    }
    return response;
  }

  Future<DeleteCartData> deleteCartItemById(
      String userId, String productId) async {
    DeleteCartData response;
    try {
      var responseBody = await _baseHelper.post(
        DeleteCartItemsById,
        <String, dynamic>{
          "userId": userId, //follow/unfollow
          "productId": productId, //follow/unfollow
        },
      );
      print("before");
      response = DeleteCartData.fromJson(responseBody);
      print("after");
    } catch (e) {
      print("after catch ${e.toString()}");
      response = DeleteCartData.fromJson(_exceptionHandler(e));
    }
    return response;
  }

  Future<DeleteProduct> deleteproduct(String productId) async {
    DeleteProduct response;
    try {
      var responseBody = await _baseHelper.post(
        DELETEPRODUCT,
        <String, dynamic>{
          "productId": productId, //follow/unfollow
        },
      );
      print("before");
      response = DeleteProduct.fromJson(responseBody);
      print("after");
    } catch (e) {
      print("after catch ${e.toString()}");
      response = DeleteProduct.fromJson(_exceptionHandler(e));
    }
    return response;
  }

  // Future<DeleteCartData> deleteCartItems(favoriteId) async {
  //   DeleteCartData response;
  //   try {
  //     final url = Uri.parse(BASE_URL + DeleteCartItems);
  //     final request = http.Request(
  //       "DELETE",
  //       url,
  //     );
  //     request.headers.addAll(<String, String>{
  //       "Accept": "application/json",
  //     });
  //     request.body = jsonEncode({"favoriteId": favoriteId});
  //     final resp = await request.send();
  //     // response = DeleteCartData.fromJson(json.decode(
  //     //   request.body,
  //     // ));
  //     await resp.stream.transform(utf8.decoder).listen((String res) {
  //       response = DeleteCartData.fromJson(jsonDecode(res));
  //       // print("response ${response.reasonPhrase}");
  //       print("response-->${response.toJson()}");
  //     });
  //     // return Future.error("error: status code ${response.message}");
  //
  //   } catch (e) {
  //     print("after catch ${e.toString()}");
  //     response = DeleteCartData(success: false, message: e.toString());
  //   }
  //   return response;
  // }

  Future<MySoldProductsResponse> getSoldOrder() async {
    MySoldProductsResponse responseJson;
    try {
      final response =
          await _baseHelper.post(GetMySoldProducts, <String, dynamic>{
        "userId": SharedPref.getInstance().getUserId(),
      });
      responseJson = MySoldProductsResponse.fromJson(response);
      print(' response $responseJson');
    } catch (e) {
      responseJson = MySoldProductsResponse.fromJson(_exceptionHandler(e));
    }
    return responseJson;
  }

  Future<AddProductData> addProducts(RequestProductData productData) async {
    AddProductData commonResponse;

    if (productData.images.isNullOrEmpty()) {
      return commonResponse = AddProductData.fromJson({
        "status": 400,
        'success': false,
        "message": "Please add at least one product image"
      });
    }

    try {
      final FormData formData = FormData.fromMap({
        "userId": productData.userId,
        "title": productData.title,
        "categoryId": productData.categoryId,
        "subcategoryId": productData.subcategoryId,
        "conditionId": productData.conditionId,
        "location": productData.location,
        "latitude": productData.latitude.toString(),
        "longitude": productData.longitude.toString(),
        "price": productData.price,
        "description": productData.description,
        "items": productData.items,
      });

      formData.files.addAll(productData.images
          .map((e) => MapEntry(
                "images",
                MultipartFile.fromFileSync(e.path,
                    filename: e.path.split('/').last),
              ))
          .toList());

      Dio dio = Dio();
      dio.options.connectTimeout = 60000;
      dio.options.sendTimeout = 60000;
      dio.options.receiveTimeout = 60000;

      var response = await dio
          .post(BASE_URL + AddProducts,
              data: formData,
              options: Options(
                contentType: Headers.jsonContentType,
              ))
          .catchError((e) {
        print("Exception Message$e");
        commonResponse = AddProductData.fromJson({
          "status": 400,
          'success': false,
          "message": e?.toString() ?? SOMETHING_WRONG
        });
      });
      print("response : $response");
      commonResponse = AddProductData.fromJson(response.data);
    } catch (e) {
      commonResponse = AddProductData.fromJson(_exceptionHandler(e));
    }

    return commonResponse;
  }

  Future<ProductConditionsResponse> getCondition() async {
    ProductConditionsResponse response;
    try {
      var resp = await _baseHelper.get(GetCondition, "");
      print("before: ${response.toString()}");
      response = ProductConditionsResponse.fromJson(resp);
      print("after");
    } catch (e) {
      print("in catch ${e.toString()}");
      response =
          ProductConditionsResponse(success: false, message: e.toString());
    }
    print("after2");
    return response;
  }

  Future<GetUserDetailsData> getUserDetailsData(
      Map<String, dynamic> request) async {
    print(jsonEncode(request));
    GetUserDetailsData response;
    try {
      var responseBody = await _baseHelper.post(GetUserDetails, request);
      print("before");
      response = GetUserDetailsData.fromJson(responseBody);
      print('after');
    } catch (e) {
      response = GetUserDetailsData.fromJson(_exceptionHandler(e));
    }
    return response;
  }

  Future<ChatMessageResponse> sendMessage(
    String userId,
    String username,
    String userPic,
    String receiverid,
    String receivername,
    String receiverPic,
    productId,
    chatid,
    String userType,
    message,
  ) async {
    ChatMessageResponse responseJson;
    try {
      final response = await _baseHelper.post(SendMessage, <String, dynamic>{
        "userId": userId,
        "username": username,
        "userPic": userPic,
        "receiverId": receiverid,
        "receivername": receivername,
        "receiverPic": receiverPic,
        "productId": productId,
        "chatId": chatid,
        "message": message,
        "type": userType,
      });
      responseJson = ChatMessageResponse.fromJson(response);
      print(' response $responseJson');
    } catch (e) {
      responseJson = ChatMessageResponse.fromJson(_exceptionHandler(e));
    }
    return responseJson;
  }

  Future<ChatUsersResponse> getChatUsers(String userId) async {
    ChatUsersResponse responseJson;
    try {
      final response = await _baseHelper
          .post(GetChatUsers, <String, dynamic>{"userId": userId});
      responseJson = ChatUsersResponse.fromJson(response);
      print(' response $responseJson');
    } catch (e) {
      responseJson = ChatUsersResponse.fromJson(_exceptionHandler(e));
    }
    return responseJson;
  }

  Future<ChatUsersResponse> getChats(
      String userId, String receiverId, String productId) async {
    ChatUsersResponse responseJson;
    try {
      final response = await _baseHelper.post(GetChats, <String, dynamic>{
        "userId": userId,
        "receiverId": receiverId,
        "productId": productId,
      });
      responseJson = ChatUsersResponse.fromJson(response);
      print(' response $responseJson');
    } catch (e) {
      responseJson = ChatUsersResponse.fromJson(_exceptionHandler(e));
    }
    return responseJson;
  }

  Future<Login> getUserDetails(String userId) async {
    Login responseJson;
    try {
      final response = await _baseHelper
          .post(GetUserDetails, <String, dynamic>{"userId": userId});
      responseJson = Login.fromJson(response);
      print(' response $responseJson');
    } catch (e) {
      responseJson = Login.fromJson(_exceptionHandler(e));
    }
    ;
    return responseJson;
  }

  Future<LogoutData> getLogoutData(String userId) async {
    LogoutData responseJson;
    try {
      final response = await HttpWithInterceptor.build(
        interceptors: [LoggingInterceptor()],
        requestTimeout: Duration(minutes: 1),
      ).post(BASE_URL + Logout, body: <String, dynamic>{"userId": userId});
      responseJson = LogoutData.fromJson(jsonDecode(response.body));
      print(' response $responseJson');
    } catch (e) {
      responseJson = LogoutData(success: false, message: e.toString());
    }
    return responseJson;
  }

  Future<NotificationListingResponse> getnotificationListing() async {
    NotificationListingResponse responseJson;
    try {
      final response =
          await _baseHelper.post(GETNOTIFICATION, <String, dynamic>{
        "userId": SharedPref.getInstance().getUserId(),
      });
      responseJson = NotificationListingResponse.fromJson(response);
      print(' response $responseJson');
    } catch (e) {
      responseJson = NotificationListingResponse.fromJson(_exceptionHandler(e));
    }
    return responseJson;
  }
}

Map<String, dynamic> _exceptionHandler(e) {
  if (e is SocketException) {
    return {
      "status": 400,
      'success': false,
      "message": e?.toString() ?? SOCKET_EXCEPTION_MESSAGE
    };
  } else if (e is TimeoutException) {
    return {
      "status": 400,
      'success': false,
      "message": e?.toString() ?? SOMETHING_WRONG
    };
  } else {
    print("Exception occured: ${e.toString()}");
    return {
      "status": 400,
      'success': false,
      "message": e?.toString() ?? SOMETHING_WRONG
    };
  }
}
