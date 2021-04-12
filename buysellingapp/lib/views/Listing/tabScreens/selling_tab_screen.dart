import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/res/images.dart';
import 'package:untitled/views/Listing/getXController/my_listing_controller.dart';
import 'package:untitled/model/AddProduct/Data.dart' as ss;
import 'package:untitled/views/detailScreen/detail_screen.dart';
import 'package:untitled/views/editselling/edit_selling.dart';

class SellingTabScreen extends StatefulWidget {
  final GetMyListingController controller;

  const SellingTabScreen({Key key, @required this.controller})
      : super(key: key);

  @override
  _SellingTabScreenState createState() => _SellingTabScreenState();
}

class _SellingTabScreenState extends State<SellingTabScreen> {
  int index;
  int date;
  var _selection;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      widget.controller.getSellingListing();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.controller.haveSellingItems
          ? ListView.builder(
              shrinkWrap: true,
              cacheExtent: 99999,
              physics: BouncingScrollPhysics(),
              itemCount: widget.controller.sellingList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(DetailScreen(
                      wantChat: false,
                      data: ss.ProductData.fromJson(
                        widget.controller.sellingList[index].toJson(),
                      ),
                    ));
                  },
                  child: selling_item(index),
                );
              })
          : Center(child: Text("No Selling items found"));
    });
  }

  Widget selling_item(int index) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
        padding: EdgeInsets.all(5.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: primaryColor,
            child: Column(
              children: [
                !(index != 0 &&
                        widget.controller.matchDate(
                            widget.controller.sellingList[index - 1]?.createdAt,
                            widget.controller.sellingList[index]?.createdAt))
                    ? Row(
                        children: [
                          Container(
                              height: 25.0,
                              width: 25.0,
                              margin: EdgeInsets.all(10.0),
                              child: Center(
                                  child: SvgPicture.asset(
                                AppImages.calendars,
                                color: Colors.white,
                              ))),
                          Container(
                            child: Text(
                              DateFormat('yMMMMd').format(
                                      DateFormat('yyyy-MM-dd').parse(widget
                                          .controller
                                          .sellingList[index]
                                          ?.createdAt)) ??
                                  "",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),

                          // Padding(
                          //   padding: const EdgeInsets.only(right: 20.0),
                          //   child: Text(
                          //     'Sell Faster',
                          //     style: TextStyle(color: Colors.green),
                          //   ),
                          // ),
                        ],
                      )
                    : Container(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.16,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6, left: 10.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Image.network(
                                Repository.imageUrl +
                                    widget.controller.sellingList[index]
                                        .images[0].image,
                                height: 80.0,
                                width: 80.0,
                                fit: BoxFit.fill,
                              ),
                              clipBehavior: Clip.antiAlias,
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 20.0,
                                    child: Text(
                                      widget.controller.sellingList[index]
                                              ?.title ??
                                          "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black.withAlpha(480)),
                                    ),
                                  ),
                                  // SizedBox(width: 30.0,),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "\$ ${widget.controller.sellingList[index]?.price}" ??
                                        "",
                                    style: TextStyle(color: Colors.redAccent),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                PopupMenuButton<WhyFarther>(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  onSelected: (WhyFarther result) {
                                    setState(() {
                                      _selection = result;
                                    });
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry<WhyFarther>>[
                                    PopupMenuItem<WhyFarther>(
                                      value: WhyFarther.viewdetail,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.back();
                                          Get.to(DetailScreen(
                                            data: ss.ProductData.fromJson(widget
                                                .controller.sellingList[index]
                                                .toJson()),
                                          ));
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              ' View Detail',
                                              style: GoogleFonts.poppins(
                                                  color: labeltextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem<WhyFarther>(
                                      value: WhyFarther.viewdetail,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.back();
                                          FrequentUtils.getInstance()
                                              .showAlert(context, () {
                                            Get.back();
                                            widget.controller.sellProduct(
                                                index,
                                                widget.controller
                                                    .sellingList[index].id,
                                                true);
                                          }, "Are you sure you want to sold it?");
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              ' Mark As Sold',
                                              style: GoogleFonts.poppins(
                                                  color: labeltextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem<WhyFarther>(
                                      value: WhyFarther.viewdetail,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.back();
                                          FrequentUtils.getInstance()
                                              .showAlert(context, () {
                                            Get.back();
                                            widget.controller
                                                .deleteproductFromSelling(
                                                    index,
                                                    widget.controller
                                                        .sellingList[index].id);
                                          }, "Are you sure you want to delete it?");
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              ' Delete',
                                              style: GoogleFonts.poppins(
                                                  color: labeltextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem<WhyFarther>(
                                      value: WhyFarther.viewdetail,
                                      child: InkWell(
                                        onTap: () {
                                          Get.back();
                                          Get.to(EditSelling(widget
                                              .controller.sellingList[index]));
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              ' Edit',
                                              style: GoogleFonts.poppins(
                                                  color: labeltextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}

enum WhyFarther { viewdetail, markassold, delete }
