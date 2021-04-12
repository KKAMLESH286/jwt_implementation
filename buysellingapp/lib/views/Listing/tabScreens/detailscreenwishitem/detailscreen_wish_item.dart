import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/WishItem/wish_item_data.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/res/images.dart';
import 'package:untitled/model/AddProduct/Data.dart' as ss;
import 'package:untitled/views/Order/order_controller.dart';
import 'package:untitled/Utils/my_extensions.dart';

class DetailScreenWishItem extends StatefulWidget {
  DetailScreenWishItem({@required this.data});

  final WishListData data;
  @override
  _DetailScreenWishItemState createState() => _DetailScreenWishItemState();
}

class _DetailScreenWishItemState extends State<DetailScreenWishItem> {
  final controller = PageController(initialPage: 0);
  OrderController _orderController = OrderController();

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      _orderController.getUserDetails(widget.data.userId);
    });

    super.initState();
  }

  void _sendMessageClick() {
    if (_orderController.canSendMessage.value) {
      _orderController.sendMessage(
          SharedPref.getInstance().getUserId(),
          SharedPref.getInstance().getUserName(),
          SharedPref.getInstance().getAvatar(),
          widget.data.userId,
          widget.data.id,
          _orderController.chatController.text.trim().toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _detailScreen),
            _sendMessageBox,
          ],
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
                                  Repository.imageUrl + image.toString(),
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
                                    Get.back();
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
                                // Image.asset(
                                //   AppImages.menu,
                                //   color: Colors.black,
                                // ),
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
                                (!widget.data.images.isNull)
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
                        )
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
                      Image.asset(AppImages.share),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "\$ ${widget.data?.price ?? ""}",
                    style: TextStyle(
                        color: Color(0XFFFB596D),
                        fontWeight: FontWeight.w900,
                        fontSize: 25),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Image.asset(AppImages.calendar),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        DateFormat('dd, MMM yyyy').format(
                            DateFormat('yyyy-MM-dd')
                                .parse(widget.data.createdAt)),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
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
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _orderController.receiverData?.value?.name ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Color(0XFFFFC107),
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0XFFFFC107),
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0XFFFFC107),
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0XFFFFC107),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0XFFFB596D),
                    ),
                    child: Center(
                      child: Text(
                        '4.5',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 20),
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
                decoration: InputDecoration(
                  hintText: "Chat with",
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
