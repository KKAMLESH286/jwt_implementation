import 'dart:io';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/Utils/my_extensions.dart';
import 'package:untitled/views/Selling/selling_controller.dart';
import 'package:untitled/model/selling/Data.dart';

class Add_ImgStep1 extends StatefulWidget {
  Add_ImgStep1(
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
  _Add_ImgStep1State createState() => _Add_ImgStep1State();
}

class _Add_ImgStep1State extends State<Add_ImgStep1> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // File file;
  var picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    print("data-->${widget.sellingController.data.value}");
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 30.0, top: 30),
            child: Text(
              'Add Images',
              style: TextStyle(fontSize: 22.0, color: labeltextColor),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            child: Center(
              child: FDottedLine(
                height: 250.0,
                width: 350.0,
                corner: FDottedLineCorner.all(8.0),
                color: Colors.black26,
                child: Center(
                  child: Container(
                    height: 250.0,
                    width: 350.0,
                    child: camera(context),
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          
          Container(
            height: 70.0,
            width: MediaQuery.of(context).size.width,
            color: Colors.black26,
            child: Center(
                child: Text(
              'Next',
              style: TextStyle(color: Colors.white, fontSize: 22.0),
            )),
          ).addInkwell(onClick: () {
            if (widget.sellingController.imagedata.isNullOrEmpty()) {
              showInSnackBar("Please add image");
            } else {
              widget.sellingController.step.value = 2;
              widget.tapped = widget.index;
            }
          })

        ],
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  camera(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 2,
      child: Container(
        // margin: EdgeInsets.only( right: 20, top: 10),
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          // color: Colors.grey[300],
        ),
        child: Obx(() => InkWell(
              onTap: () {
                _showSelectionDialog(context);
              },
              child: widget.sellingController.imagedata.isNotNullOrEmpty()
                  ? ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.file(
                        widget.sellingController.imagedata[0],
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(
                      Icons.camera_alt,
                      size: 85.0,
                      color: Colors.black12,
                    ),
            )),
      ),
    );
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              title: Center(
                child: Text("Select",
                    style: TextStyle(fontSize: 22.0, color: labeltextColor)),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 135,
                          height: 35,
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: borderColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(
                            child: Text(
                              "Gallery",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: borderColor),
                            ),
                          ),
                        ).addInkwell(onClick: () {
                          _openGallery(context);
                        }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 135,
                          height: 35,
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: borderColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(
                            child: Text(
                              "Camera",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: borderColor),
                            ),
                          ),
                        ).addInkwell(onClick: () {
                          _openCamera(context);
                        }),
                      ],
                    ).addPadding(20.0)
                  ],
                ),
              ));
        });
  }

  Widget dotline() {
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

  void _openGallery(BuildContext context) async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxWidth: 800, maxHeight: 800);
    Navigator.of(context).pop();

    if (pickedFile != null) {
      if (widget.sellingController.imagedata.isNotNullOrEmpty())
        widget.sellingController.imagedata.removeAt(0);
      // widget.sellingController.imagedata.insert(0, File(pickedFile.path));
      // print('FileLength1: ${File(pickedFile.path).length()}');

      //  var r = await compressImage(File(pickedFile.path));
      var r = await FrequentUtils.getInstance()
          .compressImagee(File(pickedFile.path));
      widget.sellingController.imagedata.insert(0, r);

      // print('FileLength2: ${r.length()}');

    } else {
      print('No image selected.');
    }
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, maxWidth: 800, maxHeight: 800);
    Navigator.of(context).pop();

    if (pickedFile != null) {
      if (widget.sellingController.imagedata.isNotNullOrEmpty())
        widget.sellingController.imagedata.removeAt(0);
      // widget.sellingController.imagedata.insert(0, File(pickedFile.path));
      // print('FileLength1: ${File(pickedFile.path).length()}');

      var r = await FrequentUtils.getInstance()
          .compressImagee(File(pickedFile.path));
      widget.sellingController.imagedata.insert(0, r);

      // print('FileLength2: ${r.length()}');
      // widget.sellingController.imagedata.insert(0, File(pickedFile.path));
    } else {
      print('No image selected.');
    }
  }
}
