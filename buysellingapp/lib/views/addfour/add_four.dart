import 'dart:io';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/res/images.dart';
import 'package:untitled/Utils/my_extensions.dart';
import 'package:untitled/silverstaggeredgridviewandfixedheight.dart';
import 'package:untitled/views/Selling/selling_controller.dart';
import 'package:untitled/views/addfour/addfour_controller.dart';
import 'package:untitled/views/First/first.dart';

class AddFourOne extends StatefulWidget {
  AddFourOne({
    @required this.sellingController,
    @required this.id,
  });

  final String id;
  final SellingController sellingController;

  @override
  _AddFourOneState createState() => _AddFourOneState();
}

class _AddFourOneState extends State<AddFourOne> {
  File images;
  bool isLoading = false;
  var addProductController = AddFourController();

  @override
  void initState() {
    // Future.delayed(Duration(milliseconds: 100)).then((value) {
    //   isLoading = true;
    //   addProductController.getsubCategoryApi(widget.id);
    //   print(widget.id);
    // });

    // widget.dataone;
    // print("data--->${widget.dataone}");
    super.initState();
  }

  void _onPostButtonClick() {
    if (GetUtils.isNullOrBlank(addProductController.priceTEC.text)) {
      widget.sellingController.showMessage("Please enter the price");
      return;
    }
    if (GetUtils.isNullOrBlank(addProductController.descriptionTEC.text)) {
      widget.sellingController.showMessage("Please enter the description");
      return;
    }
    if (widget.sellingController.subCategories.isNotNullOrEmpty() &&
        addProductController.tappedSubCat.value == -1) {
      widget.sellingController
          .showMessage("Please select the kind of item you are selling");
      return;
    }

    addProductController.priceFN.unfocus();
    addProductController.descriptionFN.unfocus();

    //saving data
    widget.sellingController.requestData.userId =
        SharedPref.instancee.getUserId();
    widget.sellingController.requestData.price =
        addProductController.priceTEC.text.trim();
    widget.sellingController.requestData.description =
        addProductController.descriptionTEC.text.trim();

    if (widget.sellingController.haveSubCategories) {
      widget.sellingController.requestData.items = widget.sellingController
          .subCategories[addProductController.tappedSubCat.value].id;
    }

    widget.sellingController.requestData.latitude =
        currentPosition?.latitude ?? 0.0;
    widget.sellingController.requestData.longitude =
        currentPosition?.longitude ?? 0.0;

    addProductController.addProduct(widget.sellingController.requestData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Color(0xffF2F2F2),
                        width: Get.width,
                        child: new TextFormField(
                          autofocus: false,
                          controller: addProductController.priceTEC,
                          focusNode: addProductController.priceFN,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                          obscureText: false,
                          autocorrect: false,
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            hintText: 'Price',
                            border: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.all(12),
                          ),
                        ),
                      ).addOnlyPadding(
                          left: 10, right: 10, bottom: 10, top: 10),
                      Text(
                        'Set a competitive price',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: textColor,
                          ),
                        ),
                      ).addOnlyPadding(left: 15, bottom: 30),
                      Container(
                        color: Color(0xffF2F2F2),
                        padding: EdgeInsets.only(left: 0, right: 0),
                        width: Get.width,
                        child: new TextFormField(
                          maxLines: 2,
                          autofocus: false,
                          controller: addProductController.descriptionTEC,
                          focusNode: addProductController.descriptionFN,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                          obscureText: false,
                          autocorrect: false,
                          decoration: new InputDecoration(
                            hintText: 'Description',
                            border: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.all(12),
                          ),
                        ),
                      ).addOnlyPadding(left: 10, right: 10),
                      Text(
                        'Describe',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: textColor,
                          ),
                        ),
                      ).addOnlyPadding(left: 15, bottom: 30),
                      Visibility(
                        visible: widget.sellingController.haveSubCategories,
                        child: Text(
                          'What Kind of items are you selling?',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              color: textColor,
                            ),
                          ),
                        ).addOnlyPadding(left: 15, bottom: 10),
                      ),
                      Obx(
                        () => Container(
                          height: 130,
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(
                              top: 10,
                            ),
                            shrinkWrap: true,
                            itemCount: widget
                                    .sellingController?.subCategories?.length ??
                                0,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 14,
                              height: 48.0, //48 dp of height
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  addProductController.tappedSubCat.value =
                                      index;
                                },
                                child: Obx(
                                  () => Container(
                                      width: Get.width * 0.3,
                                      height: Get.height * 0.06,
                                      decoration: BoxDecoration(
                                        color: addProductController
                                                    .tappedSubCat.value ==
                                                index
                                            ? primaryColor
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        border: Border.all(color: borderColor),
                                      ),
                                      child: Center(
                                        child: Text(
                                          widget
                                                  .sellingController
                                                  ?.subCategories[index]
                                                  .subcategoryname ??
                                              "",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: addProductController
                                                        .tappedSubCat.value ==
                                                    index
                                                ? Colors.white
                                                : Colors.grey,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      )),
                                ),
                              );
                            },
                          ),
                        ).addOnlyPadding(left: 13, right: 15),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            // margin: EdgeInsets.only(left: 50, right: 50, top: 5),
            width: double.maxFinite,
            height: 60,
            child: MaterialButton(
              shape: RoundedRectangleBorder(),
              onPressed: _onPostButtonClick,
              color: primaryColor,
              child: Center(
                child: Text(
                  'Post'.toUpperCase(),
                  style: GoogleFonts.sourceSansPro(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dotline() {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
        child: FDottedLine(
          width: 85.0,
          space: 2.0,
          color: Colors.white,
          strokeWidth: 2.0,
        ));
  }

  PreferredSizeWidget bar_content() {
    return PreferredSize(
      preferredSize: Size(15.0, 150.0),
      child: Container(
        height: 150.0,
        width: MediaQuery.of(context).size.width,
        color: primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(top: 40.0, left: 20.0),
                child:
                    SvgPicture.asset(AppImages.arrow).addInkwell(onClick: () {
                  Get.back();
                })),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      maxRadius: 27.0,
                      backgroundColor: Colors.black12,
                      child: SvgPicture.asset(
                        AppImages.check,
                        height: 60.0,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text('Step 1', style: TextStyle(color: Colors.white70))
                  ],
                ),
                dotline(),
                Column(
                  children: [
                    CircleAvatar(
                      maxRadius: 27.0,
                      backgroundColor: Colors.black12,
                      child: SvgPicture.asset(
                        AppImages.check,
                        height: 60.0,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Step 2',
                      style: TextStyle(color: Colors.white70),
                    )
                  ],
                ),
                dotline(),
                Column(
                  children: [
                    CircleAvatar(
                      maxRadius: 27.0,
                      backgroundColor: Colors.black12,
                      child: SvgPicture.asset(
                        AppImages.check,
                        height: 62.0,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text('Step 3', style: TextStyle(color: Colors.white70))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
