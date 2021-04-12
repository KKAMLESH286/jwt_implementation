import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/AddProduct/Data.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/res/images.dart';
import 'package:untitled/views/Listing/getXController/my_listing_controller.dart';
import 'package:untitled/views/detailScreen/detail_screen.dart';

class SoldTabScreen extends StatefulWidget {
  final GetMyListingController controller;

  const SoldTabScreen({Key key, @required this.controller}) : super(key: key);

  @override
  _SoldTabScreenState createState() => _SoldTabScreenState();
}

class _SoldTabScreenState extends State<SoldTabScreen> {
  var _selection;

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(milliseconds: 100)).then((value) {
    //   widget.controller.getSoldOrders();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => widget.controller.haveSoldItems
        ? ListView.builder(
            shrinkWrap: true,
            cacheExtent: 99999,
            physics: BouncingScrollPhysics(),
            itemCount: widget.controller?.soldList?.length ?? 0,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(DetailScreen(
                    wantChat: false,
                    data: ProductData.fromJson(
                        widget.controller.soldList[index].toJson()),
                  ));
                },
                child: selling_item(index),
              );
            })
        : Center(child: Text("No Sold item found")));
  }

  Widget selling_item(int index) {
    return Column(children: [
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
              mainAxisSize: MainAxisSize.min,
              children: [
                !(index != 0 &&
                        widget.controller.matchDate(
                            widget.controller.soldList[index - 1]?.createdAt,
                            widget.controller.soldList[index]?.createdAt))
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
                            DateFormat('yMMMMd').format(DateFormat('yyyy-MM-dd')
                                    .parse(widget.controller.soldList[index]
                                        ?.createdAt)) ??
                                "",
                            style: TextStyle(color: Colors.white),
                          )),
                          Spacer(),
//Container(margin:EdgeInsets.only(right: 10.0),child: Icon(Icons.access_time,color: Colors.grey,)),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text(
                              'Sold',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
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
                            padding:
                                const EdgeInsets.only(top: 6.0, left: 10.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Stack(
                                children: [
                                  widget.controller.haveProductImages(index)
                                      ? Image.network(
                                          Repository.imageUrl +
                                                  widget.controller
                                                      .productImages(index)[0]
                                                      ?.image ??
                                              "",
                                          height: 80.0,
                                          width: 80.0,
                                          fit: BoxFit.fill,
                                        )
                                      : Container(width: 70.0, height: 75.0),
                                ],
                              ),
                              clipBehavior: Clip.antiAlias,
                              color: Colors.black,
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
                              Container(
                                child: Text(
                                  widget.controller?.soldList[index]?.title ??
                                      "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withAlpha(480)),
                                ),
                              ),
                              Text(
                                "\$ " +
                                        widget.controller?.soldList[index]
                                            ?.price ??
                                    "",
                                style: TextStyle(color: Colors.redAccent),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PopupMenuButton<PopupMenuClass>(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                onSelected: (PopupMenuClass result) {
                                  setState(() {
                                    _selection = result;
                                  });
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<PopupMenuClass>>[
                                  PopupMenuItem<PopupMenuClass>(
                                    value: PopupMenuClass.harder,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        widget.controller.restoreProduct(
                                          index,
                                          widget.controller.soldList[index].id,
                                          false,
                                        );
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            ' List it again',
                                            style: GoogleFonts.poppins(
                                                color: labeltextColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem<PopupMenuClass>(
                                    value: PopupMenuClass.harder,
                                    child: InkWell(
                                      onTap: () {
                                        Get.back();
                                        FrequentUtils.getInstance()
                                            .showAlert(context, () {
                                          Get.back();
                                          widget.controller
                                              .deleteproductFromSold(
                                                  index,



                                                  
                                                  widget.controller
                                                      .soldList[index].id);
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
                                ],
                              ),
                            ],
                          )
                        ],
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

enum PopupMenuClass {
  harder,
  smarter,
}
