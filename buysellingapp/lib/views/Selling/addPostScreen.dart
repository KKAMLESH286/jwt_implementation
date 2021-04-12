import 'dart:io';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/model/selling/Data.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/res/images.dart';
import 'package:untitled/views/Selling/selling_controller.dart';
import 'package:untitled/Utils/my_extensions.dart';
import 'package:untitled/views/addfour/add_four.dart';
import 'package:untitled/views/addone/add_one.dart';
import 'package:untitled/views/addthree/addthree.dart';

class AddPostScreen extends StatefulWidget {
  AddPostScreen(
    this.sellingController,
    this.id,
    this.data,
    this.tapped,
    this.index,
  );

  final List<Data> data;
  final String id;
  int tapped;
  int index;
  final SellingController sellingController;

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  File file;
  var picker = ImagePicker();

  @override
  void initState() {
  
  
    super.initState();
  }

  @override
  void dispose() {
    widget.sellingController.step.value = 1;
    print("finish");
    widget.sellingController.imagedata.assignAll([]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("data-->${widget.sellingController.data.value}");
    return WillPopScope(
      onWillPop: () {
        if (widget.sellingController.step.value == 1) {
          return Future.value(true);
        } else {
          widget.sellingController.step.value -= 1;
          return Future.value(false);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Container(
                    height: 148.0,
                    width: MediaQuery.of(context).size.width,
                    color: primaryColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 24.0, left: 20.0),
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 10.0, right: 4.0, bottom: 10),
                            child: SvgPicture.asset(AppImages.arrow),
                          ).addInkwell(
                              onClick: () {
                                if (widget.sellingController.step.value == 1) {
                                  Get.back();
                                } else {
                                  widget.sellingController.step.value -= 1;
                                }
                              }),
                        ),
                        8.toVerticalSpace(),
                        Container(
                          margin: EdgeInsets.only(right: 20.0, left: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Opacity(
                                opacity: (widget.sellingController.step.value >= 1)
                                    ? 1
                                    : 0.6,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 25.0,
                                      backgroundColor: Colors.black12,
                                      child: SvgPicture.asset(
                                        AppImages.check,
                                        height: 50.0,
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      'Step 1',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              // dotline(),
                              Expanded(child: dashedLine()),
                              Opacity(
                                opacity: (widget.sellingController.step.value >= 2)
                                    ? 1
                                    : 0.6,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 25.0,
                                      backgroundColor: Colors.black12,
                                      child: SvgPicture.asset(
                                        AppImages.check,
                                        height: 50.0,
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      'Step 2',
                                      style: TextStyle(color: Colors.white70),
                                    )
                                  ],
                                ),
                              ),
                              // dotline(),
                              Expanded(child: dashedLine()),
                              Opacity(
                                opacity: (widget.sellingController.step.value >= 3)
                                    ? 1
                                    : 0.6,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 25.0,
                                      backgroundColor: Colors.black12,
                                      child: SvgPicture.asset(
                                        AppImages.check,
                                        height: 50.0,
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text('Step 3',
                                        style: TextStyle(color: Colors.white70))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => IndexedStack(
                      index: widget.sellingController.step.value - 1,
                      children: [
                        Positioned.fill(
                          child: Add_ImgStep1(
                            widget.sellingController,
                            widget.id,
                            widget.data,
                            widget.tapped,
                            widget.index,
                          ),
                        ),
                        Positioned.fill(
                          child: AddThree(
                            sellingController: widget.sellingController,
                            data: widget.data,
                            categoryId: widget.id,
                            index: widget.index,
                            tapped: widget.tapped,
                          ),
                        ),
                        Positioned.fill(
                          child: AddFourOne(
                            id: widget.id,
                            sellingController: widget.sellingController,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashedLine() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
      child: FDottedLine(
        width: 85.0,
        space: 2.0,
        color: Colors.white,
        strokeWidth: 2.0,
      ),
    );
  }
}
