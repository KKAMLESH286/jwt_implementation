import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:untitled/model/AddProduct/Data.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/res/images.dart';
import 'package:untitled/views/reportlisting/reporting_controller.dart';

class ReportListing extends StatefulWidget {
  ReportListing(this.data, this.id);

  final ProductData data;
  final String id;

  @override
  _ReportListingState createState() => _ReportListingState();
}

class _ReportListingState extends State<ReportListing> {
  int tappedIndex = -1;
  String userId;
  String reportId;
  var reportController = ReportingController();
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      reportController.getReportingListing();
    });
  }

  _onReportButtonClick() {
    reportController.reportProduct(
        reportController.reportData[tappedIndex].id,
        widget.data.id,
        widget.data.userId,
        widget.data.title,
        reportController.reportData[tappedIndex].reportname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text('Report Listing'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: Get.height * 0.7,
              child: Obx(
                () => ListView.builder(
                    itemCount: reportController?.reportData?.length ?? 0,
                    itemBuilder: (context, index) {
                      return listview(index);
                    }),
              ),
            ).paddingSymmetric(horizontal: 20, vertical: 20),
          ),
          tappedIndex == -1
              ? Container(
                  width: double.maxFinite,
                  height: 48,
                  child: RaisedButton(
                    color: Colors.red[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    onPressed: () {
                      // Get.to(ReportListing());
                    },
                    child: Text(
                      "Report",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ).paddingSymmetric(horizontal: 20, vertical: 20)
              : Container(
                  width: double.maxFinite,
                  height: 48,
                  child: RaisedButton(
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    onPressed: _onReportButtonClick,
                    child: Text(
                      "Report",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ).paddingSymmetric(horizontal: 20, vertical: 20)
        ],
      ),
    );
  }

  Column listview(int index) {
    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    tappedIndex = index;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(17),
                  child: Text(
                    reportController?.reportData[index]?.reportname ?? "",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            tappedIndex == index
                ? Container(
                    width: 24,
                    height: 24,
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: primaryColor, width: 2)),
                    child: Center(
                      child: SvgPicture.asset(
                        AppImages.uncheck,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ],
    );
  }
}

class Profile {
  Profile(
    this.text,
  );

  String text;
}
