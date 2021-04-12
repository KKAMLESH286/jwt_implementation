import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/AddProduct/Data.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/res/images.dart';
import 'package:untitled/views/Listing/getXController/my_listing_controller.dart';
import 'package:untitled/views/detailScreen/detail_screen.dart';

class WishListTabScreen extends StatefulWidget {
  final GetMyListingController controller;

  const WishListTabScreen({Key key, @required this.controller})
      : super(key: key);

  @override
  _WishListTabScreenState createState() => _WishListTabScreenState();
}

class _WishListTabScreenState extends State<WishListTabScreen> {
  var _selection;

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(milliseconds: 100)).then((value) {
    //   widget.controller.getWishItem();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Obx(() => widget.controller.haveWishListItems
              ? ListView.separated(
                  separatorBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    );
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.controller.wishList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(
                          DetailScreen(
                            wantChat: true,
                            data: ProductData.fromJson(
                                widget.controller.wishList[index].toJson()),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image.asset(AppImages.wish),
                            Container(
                              padding: EdgeInsets.only(top: 15),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  Repository.imageUrl +
                                          widget.controller.wishList[index]
                                              ?.images[0]?.image ??
                                      "",
                                  height: 90,
                                  width: 90.0,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 20, top: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "\$ " +
                                              widget.controller.wishList[index]
                                                  ?.price ??
                                          "",
                                      style: TextStyle(
                                          color: Color(0XFFFB596D),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      widget.controller.wishList[index]
                                              ?.title ??
                                          "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: SvgPicture.asset(
                                              AppImages.locations),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    PopupMenuButton<WhyFarther>(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      onSelected: (WhyFarther result) {
                                        setState(() {
                                          _selection = result;
                                        });
                                      },
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry<WhyFarther>>[
                                        PopupMenuItem<WhyFarther>(
                                          value: WhyFarther.harder,
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.back();
                                              final RenderBox box = context.findRenderObject();
                                              Share.share('https://medium.com/@suryadevsingh',
                                                  sharePositionOrigin:box.localToGlobal(Offset.zero) & box.size);
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  'Share',
                                                  style: GoogleFonts.poppins(
                                                      color: labeltextColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        PopupMenuItem<WhyFarther>(
                                          value: WhyFarther.harder,
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.back();
                                              FrequentUtils.getInstance()
                                                  .showAlert(context, () {
                                                Get.back();
                                                widget.controller
                                                    .deleteCartItemFromWishList(
                                                        index,
                                                        widget
                                                            .controller
                                                            .wishList[index]
                                                            .id);
                                              }, "Are you sure you want to delete?");
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  'Delete',
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
                    );
                  })
              : Center(child: Text("No items in list"))),
        ),
      ),
    );
  }
}

enum WhyFarther {
  harder,
  smarter,
}