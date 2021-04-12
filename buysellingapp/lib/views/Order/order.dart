import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/res/images.dart';
import 'package:untitled/views/Home/home.dart';
import 'package:untitled/views/Order/order_controller.dart';
import 'package:untitled/views/Order/pageview.dart';
import 'package:untitled/model/AddProduct/Data.dart' as ss;

class OrderScreen extends StatefulWidget {
  OrderScreen({@required this.data});

  final ss.ProductData data;

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var ordercontroller = OrderController();
  var chatController = TextEditingController();
  String chatid, message;

  @override
  void initState() {
    super.initState();

    chatController;
  }

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  bool typing = false;

//
//  final LatLng _center = const LatLng(45.521563, -122.677433);
//
//  void _onMapCreated(GoogleMapController controller) {
//    myController = controller;
//  }
  final controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            Get.to(BottomScreen());
            return Future.value(false);
          },
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(BottomScreen());
                          },
                          child: Image.asset(
                            AppImages.shape,
                            color: Colors.black,
                          ),
                        ),
                        Image.asset(
                          AppImages.menu,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 220,
                    child: PageView(
                      controller: controller,
                      onPageChanged: (page) => {print(page.toString())},
                      pageSnapping: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        PageTwo(),
                      ],
                    ),
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
                              style: TextStyle(fontSize: 20),
                            ),
                            Image.asset(AppImages.share),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "\$ ${widget.data?.price ?? "0.00"}",
                          style: TextStyle(
                              color: Color(0XFFFB596D),
                              fontWeight: FontWeight.bold,
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
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.data?.description ?? "",
                          style: TextStyle(
                              color: Color(0XFF656565),
                              fontSize: 15,
                              height: 2),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 200,
                    width: double.maxFinite,
                    color: Color(0XFFF8F8F8),
                    margin: EdgeInsets.only(left: 20, top: 5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                AppImages.chats_a,
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Mr. John",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
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
                              margin: EdgeInsets.only(right: 20),
                              height: 40,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0XFFFB596D),
                              ),
                              child: Center(
                                child: Text(
                                  '4.5',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                        _sendMessageBox
//            Expanded(
//              child: GoogleMap(
//                onMapCreated: _onMapCreated,
//                initialCameraPosition: CameraPosition(
//                  target: _center,
//                  zoom: 10.0,
//                ),
//              ),
//            ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _sendMessageBox {
    return Container(
        height: Get.height * 0.07,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(width: 2, color: Colors.grey[400])),
        child: Row(
          children: [
            Container(
              width: Get.width * 0.6,
              child: TextField(
                autocorrect: false,
                onChanged: (value) {
                  if (value.length > 0) {
                    setState(() {
                      typing = true;
                    });
                  } else {
                    setState(() {
                      typing = false;
                    });
                  }
                },
                controller: chatController,
                decoration: InputDecoration(
                  hintText: "Chat with",
                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ),
            typing
                ? Container(
                    width: 120,
                    height: 45,
                    child: RaisedButton(
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        // side: BorderSide(color: Colors.red)
                      ),
                      onPressed: () {
                        // ordercontroller.sendMessage(
                        //     SharedPref.getInstance().getUserId(),
                        //     widget.data.userId,
                        //     widget.data.id,
                        //     chatController.text.toString());
                      },
                      child: Text(
                        "SEND",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : Container(
                    width: 120,
                    height: 45,
                    child: RaisedButton(
                      color: Colors.red[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        // side: BorderSide(color: Colors.red)
                      ),
                      onPressed: () {},
                      child: Text(
                        "SEND",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
          ],
        )).paddingOnly(top: 15, right: 10);
  }
}
