import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/res/images.dart';
import 'package:untitled/views/detailScreen/detail_screen.dart';
import '../getXController/my_listing_controller.dart';
import 'package:untitled/model/AddProduct/Data.dart';

class ExpiredTabScreen extends StatefulWidget {
  final GetMyListingController controller;

  const ExpiredTabScreen({Key key, @required this.controller})
      : super(key: key);

  @override
  _ExpiredTabScreenState createState() => _ExpiredTabScreenState();
}

class _ExpiredTabScreenState extends State<ExpiredTabScreen> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(milliseconds: 100)).then((value) {
    //   widget.controller.getExpiredListing();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => widget.controller.haveExpiredItems
        ? ListView.builder(
            shrinkWrap: true,
            cacheExtent: 99999,
            physics: BouncingScrollPhysics(),
            itemCount: widget.controller.expiredList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(DetailScreen(
                    wantChat: false,
                    data: ProductData.fromJson(
                        widget.controller.expiredList[index].toJson()),
                  ));
                },
                child: selling_item(index),
              );
            })
        : Center(
            child: Text("No Expired items found"),
          ));
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
            color: Color(0XFFFA6779),
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
                            DateFormat('yMMMMd').format(DateFormat('yyyy-MM-dd')
                                    .parse(widget.controller.expiredList[index]
                                        ?.createdAt)) ??
                                "",
                            style: TextStyle(color: Colors.white),
                          )),
                          Spacer(),
                          // Container(
                          //     margin: EdgeInsets.only(right: 10.0),
                          //     child: Icon(
                          //       Icons.access_time,
                          //       color: Colors.grey,
                          //     )),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text(
                              'Expired',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    : Container(),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.128,
                    width: MediaQuery.of(context).size.width,
                    // margin: EdgeInsets.only(top: 10.0),
                    // color: Colors.white,
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
                                    Image.network(
                                      Repository.imageUrl +
                                          widget.controller.expiredList[index]
                                              .images[0].image,
                                      height: 80.0,
                                      width: 80.0,
                                      fit: BoxFit.fill,
                                    ),
                                    Container(
                                      height: 75.0,
                                      width: 70.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          color: Colors.black.withOpacity(0.3)),
                                      child: Center(
                                          child: Icon(
                                        Icons.access_time,
                                        color: Colors.white,
                                        size: 35.0,
                                      )),
                                    ),
                                  ],
                                ),
                                clipBehavior: Clip.antiAlias,
                                color: Colors.black12,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 20.0,
                                    child: Text(
                                      widget.controller.expiredList[index]
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
                                    "\$ " +
                                            widget.controller.expiredList[index]
                                                ?.price ??
                                        "",
                                    style: TextStyle(color: Colors.redAccent),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              // Row(
                              //   children: [
                              //     SvgPicture.asset(
                              //       AppImages.eye,
                              //       height: 20.0,
                              //       width: 20.0,
                              //       color: Colors.grey,
                              //     ),
                              //     Container(
                              //         margin: EdgeInsets.only(left: 10.0),
                              //         child: Text(
                              //           'Views 1',
                              //           style: TextStyle(color: Colors.grey),
                              //         )),
                              //
                              //     // VerticalDivider(color: Colors.black,
                              //     // thickness: 5, width: 10,
                              //     // indent: 10,
                              //     // endIndent:20,
                              //     // ),
                              //     Container(
                              //       margin: EdgeInsets.only(
                              //           left: 20.0, right: 20.0),
                              //       height: 15.0,
                              //       width: 2.0,
                              //       color: Colors.black12,
                              //     ),
                              //     SvgPicture.asset(
                              //       AppImages.heart,
                              //       color: Colors.grey,
                              //       height: 15.0,
                              //       width: 15.0,
                              //     ),
                              //     Container(
                              //       margin: EdgeInsets.only(left: 10.0),
                              //       child: Text(
                              //         'Likes 2',
                              //         style: TextStyle(color: Colors.grey),
                              //       ),
                              //     )
                              //     //Container(child: Text(''),)
                              //   ],
                              // )
                            ],
                          ),
                        ),
                        // Expanded(
                        //     child: Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Column(
                        //     children: [
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.end,
                        //         children: [
                        //           Icon(
                        //             Icons.more_vert,
                        //             color: Colors.grey,
                        //           )
                        //         ],
                        //       )
                        //     ],
                        //   ),
                        // ))
                      ],
                    ),
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

class Expireditems {
  String img_url;
  String prodc_name;
  String price;

  Expireditems(this.img_url, this.prodc_name, this.price);
}
