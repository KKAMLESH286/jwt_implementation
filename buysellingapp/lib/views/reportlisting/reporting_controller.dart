import 'package:get/get.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/Utils/loader.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/Home/GetProduct/Data.dart' as ss;
import 'package:untitled/model/Home/HomeData.dart';
import 'package:untitled/model/ResetPassword/ChangePassword.dart';
import 'package:untitled/model/reportResponse/Data.dart';
import 'package:untitled/model/reportResponse/ReportResponse.dart';
import 'package:untitled/model/reportlisting/Data.dart';
import 'package:untitled/model/reportlisting/ReportListing.dart';
import 'package:untitled/views/detailScreen/detail_screen.dart';

class ReportingController extends GetxController {
  final Repository _repository = Repository();
  RxList<ReportData> reportData = <ReportData>[].obs;

  var data = ReportResponseData().obs;

  getReportingListing() async {
    Get.dialog(Loader(), barrierDismissible: false);
    print("api run");
    ReportListing response = await _repository.getReportingapi();
    Get.back();
    if (response.success) {
      reportData.assignAll(response.data);
    }
  }

  reportProduct(
    String reportId,
    String productId,
    String productUserId,
    String productName,
    String reportMessage,
  ) async {
    Get.dialog(Loader(), barrierDismissible: false);
    print("api run");
    ReportResponse response = await _repository.reportProductApi(
        reportId, productId, productUserId, SharedPref.instancee.getUserName(), productName, reportMessage);

    Get.back();
    if (response.success) {
      data.value = response.data;
      Get.back(result: "report_success");
    }
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
