import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/AddProduct/Data.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/res/images.dart';
import 'package:untitled/views/Order/order_controller.dart';
import 'package:untitled/Utils/my_extensions.dart';
import 'package:untitled/views/reportlisting/report_listing.dart';

class DetailScreen extends StatefulWidget {
  final ProductData data;
  final bool wantChat;

  DetailScreen({@required this.data, this.wantChat = false});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final controller = PageController(initialPage: 0);
  final OrderController _orderController = OrderController();
  String text = 'https://medium.com/@suryadevsingh';
  String isSuccess = 'no';

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      _orderController.getUserDetails(widget.data.userId);

      print("before reports-->${widget.data.reports}");
      _orderController.isreported.value = widget.data.reports;
      print("reports-->${_orderController.isreported.value}");
    });
    super.initState();
  }

  void _sendMessageClick() {
    if (_orderController.canSendMessage.value) {
      _orderController.chatControllerFN.unfocus();
      _orderController.sendMessage(
        SharedPref.getInstance().getUserId(),
        SharedPref.getInstance().getUserName(),
        SharedPref.getInstance().getAvatar(),
        widget.data.userId,
        widget.data.id,
        _orderController.chatController.text.trim().toString(),
      );
    }
  }

  _onBackPress() {
    if (isSuccess == "report_success") {
      Get.back(result: "report_success");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _onBackPress();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: _detailScreen),
              Visibility(
                visible: widget.wantChat,
                child: _sendMessageBox,
              ),
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView get _detailScreen {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Get.height * 0.56,
              child: (!widget.data.images.isNull)
                  ? Stack(
                      children: [
                        Positioned.fill(
                          child: PageView(
                            controller: controller,
                            pageSnapping: true,
                            scrollDirection: Axis.horizontal,
                            children: widget.data.images.map((image) {
                              return Container(
                                child: Image.network(
                                  Repository.imageUrl + image.image,
                                  height: double.maxFinite,
                                  width: double.maxFinite,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (isSuccess == "report_success") {
                                      Get.back(result: "report_success");
                                    } else {
                                      Get.back();
                                    }
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black.withOpacity(0.4)),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        AppImages.ic_back,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            height: 32,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                (!(widget.data.images == null))
                                    ? SmoothPageIndicator(
                                        controller: controller,
                                        count: (widget.data.images.length > 5)
                                            ? 5
                                            : widget.data.images.length,
                                        effect: ScrollingDotsEffect(
                                          dotWidth: 10,
                                          dotHeight: 10,
                                          radius: 8,
                                          spacing: 8,
                                          activeDotColor: primaryColor,
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.data?.title ?? "",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      Icon(Icons.share_outlined).addPadding(4).addInkwell(
                          onClick: () {
                        final RenderBox box = context.findRenderObject();
                        Share.share(text,
                            sharePositionOrigin:
                                box.localToGlobal(Offset.zero) & box.size);
                      })
                    ],
                  ),
                  Text(
                    "\$${widget.data?.price ?? ""}",
                    style: TextStyle(
                        color: Color(0XFFFB596D),
                        fontWeight: FontWeight.w900,
                        fontSize: 25),
                  ).paddingOnly(top: 10),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 32,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.location_on_outlined,
                          color: primaryColor,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.data?.location ?? "",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      )
                    ],
                  ).paddingOnly(top: 10),
                  Row(
                    children: [
                      Container(
                          width: 32,
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.event_rounded,
                            color: Colors.grey,
                          )),
                      Text(
                        DateFormat('dd, MMM yyyy').format(
                            DateFormat('yyyy-MM-dd')
                                .parse(widget.data.createdAt)),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            24.toVerticalSpace(),
            Container(
              child: Divider(
                color: Colors.grey,
              ),
            ),
            8.toVerticalSpace(),
            Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ).paddingOnly(left: 20, right: 20),
            SizedBox(
              height: 12,
            ),
            Text(
              // "This statement removes all the routes in the stack and makes the pushed one the root.",
              widget.data?.description ?? "",
              style: TextStyle(
                  color: Color(0XFF656565), fontSize: 15, height: 1.5),
            ).paddingOnly(left: 20, right: 20),
            SizedBox(height: 32),
            Obx(
              () => Row(
                children: [
                  ClipOval(
                    child: (_orderController.haveReceiverImage)
                        ? Image.network(
                            Repository.profileImageUrl +
                                _orderController.receiverImage,
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: Colors.black26,
                            width: 40,
                            height: 40,
                          ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _orderController.receiverData?.value?.name ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 20),
            ),
            Obx(
              () => Visibility(
                visible: (_orderController.isreported.value) == "0",
                // visible: false,
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: MaterialButton(
                    height: 48,
                    minWidth: double.maxFinite,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0XFFFB596D),
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () {
                      Get.to(ReportListing(widget.data, widget.data.id))
                          .then((result) {
                        if (result != null && result == "report_success") {
                          _orderController.isreported.value = "1";
                          isSuccess = "report_success";
                          // _orderController.getUserDetails(widget.data.userId);
                          FrequentUtils.getInstance()
                              .showMessage("Product reported successfully.");
                        }
                      });
                    },
                    color: primaryColor,
                    child: Text(
                      "Report Listing",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ).paddingSymmetric(vertical: 20),
              ),
            ),
            24.toVerticalSpace(),
          ],
        ),
      ),
    );
  }

  Widget get _sendMessageBox {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(-1, -1))
      ]),
      child: Container(
        width: double.maxFinite,
        height: 48,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(width: 1, color: Colors.grey[300])),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                autocorrect: false,
                onChanged: (value) {
                  _orderController.canSendMessage.value =
                      (!value.isNull && value.isNotEmpty);
                },
                controller: _orderController.chatController,
                focusNode: _orderController.chatControllerFN,
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ),
            Container(
              width: 80,
              height: 45,
              child: Obx(
                () => RaisedButton(
                  color: _orderController.canSendMessage.value
                      ? primaryColor
                      : Colors.red.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  onPressed: _sendMessageClick,
                  child: Text(
                    "SEND",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
