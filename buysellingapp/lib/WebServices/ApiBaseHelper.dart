import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:untitled/Utils/constants.dart';
import 'package:untitled/Utils/interceptor.dart';
import 'package:untitled/Utils/my_extensions.dart';
import 'package:untitled/common_response.dart';
import 'AppException.dart';
class ApiBaseHelper {

  final String SOCKET_EXCEPTION_MESSAGE =
      "Something went wrong. Please check your internet connection.";
  final String SOMETHING_WRONG =
      "Something went wrong. Please try again later.";

  Future<dynamic> get(String endPoint, String token) async {
    dynamic responseJson;
    try {
      final response = await HttpWithInterceptor.build(
        interceptors: [LoggingInterceptor()],
        requestTimeout: Duration(minutes: 1),
      ).get(BASE_URL + endPoint, headers: token.isNotNullOrEmpty() ? {
        HttpHeaders.authorizationHeader: token,
        HttpHeaders.acceptHeader: "application/json",
      } : null);
      responseJson = _returnResponse(response);
    } on SocketException {
      responseJson =
          CommonResponse(success: false, message: SOCKET_EXCEPTION_MESSAGE)
              .toJson();
    } on TimeoutException {
      responseJson =
          CommonResponse(success: false, message: SOMETHING_WRONG).toJson();
    } catch (e) {
      responseJson =
          CommonResponse(success: false, message: e.toString()).toJson();
    }
    return responseJson;
  }

  Future<dynamic> post(String endPoint, dynamic bodyReq) async {
    var responseJson;
    try {
      final response = await HttpWithInterceptor.build(
        interceptors: [LoggingInterceptor()],
        requestTimeout: Duration(minutes: 1),
      ).post(BASE_URL + endPoint, body: bodyReq);
      responseJson = _returnResponse(response);
    } on SocketException {
      responseJson =
          CommonResponse(success: false, message: SOCKET_EXCEPTION_MESSAGE)
              .toJson();
    } catch (e) {
      responseJson =
          CommonResponse(success: false, message: e.toString()).toJson();
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        // return CommonResponse(
        //   status: false, message: "BadRequest Exception"
        // ).toJson();
        throw BadRequestException(response.body.toString());
      case 401:
        return CommonResponse(success: false, message: "error 401").toJson();
      case 403:
        // return CommonResponse(
        //     status: false, message: "Unauthorised Exception"
        // ).toJson();
        throw UnauthorisedException(response.body.toString());
      case 500:
        return CommonResponse(success: false, message: "error 500").toJson();
      default:
        // return CommonResponse(
        //   status: false, message: 'Error occured while Communication with Server with StatusCode : ${response.statusCode}'
        // ).toJson();
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
