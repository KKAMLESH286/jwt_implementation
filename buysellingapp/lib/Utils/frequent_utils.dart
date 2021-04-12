import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/res/colors.dart';
import 'loader.dart';

class FrequentUtils {
  static FrequentUtils _instance;

  static FrequentUtils getInstance() {
    if (_instance == null) {
      _instance = new FrequentUtils();
    }
    return _instance;
  }

  bool isValidEmail(String value) {
    RegExp regex = new RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regex.hasMatch(value);
  }

  bool isValidPassword(String password) {
    String pattern =
        r'^(?=.*?[a-zA-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~%():;<>?]).{8,}$';
    return RegExp(pattern).hasMatch(password);
  }

  bool isInvalidPassword(String password) => !isValidPassword(password);

  Future _dialog;

  checkAndShowDialog(BuildContext context) async {
    if (_dialog == null) {
      _dialog = showLoadingDialog(context);
      await _dialog;
      _dialog = null;
    }
  }

  showAlert(context, Function onTap, String text) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontFamily: 'selected',
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new FlatButton(
                  color: primaryColor,
                  child: new Text("Yes", style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    onTap();
                    // Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  width: 16,
                ),
                FlatButton(
                  color: primaryColor,
                  child: new Text("No", style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    // onTap();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            // usually buttons at the bottom of the dialog
          );
          //   AlertDialog(
          //   shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.0)),
          //   content: Container(
          //     height: 100.0,
          //     child: Column(children: <Widget>[
          //       Padding(
          //           padding: EdgeInsets.only(
          //         top: 5.0,
          //       )),
          //       Text(
          //         text,
          //         style: TextStyle(
          //           color: Colors.black,
          //           fontSize: 16.0,
          //           fontFamily: 'selected',
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //       Padding(
          //           padding: EdgeInsets.only(
          //         top: 25.0,
          //       )),
          //       Row(children: <Widget>[
          //         Padding(
          //             padding: EdgeInsets.only(
          //           right: 5.0,
          //         )),
          //         RaisedButton(
          //           child: Text(
          //             "Yes",
          //             style: TextStyle(color: Colors.white),
          //           ),
          //           onPressed: () {
          //             onTap();
          //             // Navigator.pop(context);
          //             // widget.controller.sellProduct(
          //             //   index,
          //             //   widget.controller.sellingList[index].id,
          //             //   true,
          //             // );
          //           },
          //           splashColor: Colors.white,
          //           color: primaryColor,
          //         ),
          //         Padding(
          //             padding: EdgeInsets.only(
          //           left: 30.0,
          //         )),
          //         RaisedButton(
          //           child: Text("No"),
          //           onPressed: () {
          //             Navigator.pop(context);
          //           },
          //           color: primaryColor,
          //           textColor: Colors.white,
          //           padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          //           splashColor: Colors.grey,
          //         )
          //       ]),
          //     ]),
          //   ),
          // );
        });
  }

  showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(child: Loader());
        });
  }

  showMessage(String message) {
    Get.snackbar(null, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
        margin: EdgeInsets.all(8),
        borderRadius: 6,
        animationDuration: Duration(milliseconds: 500));
  }

  Future<PickedFile> getImage(ImageSource source) async {
    final picker = ImagePicker();
    PickedFile pickedFile =
        await picker.getImage(source: source, imageQuality: 50);
    return pickedFile;
  }

  Future<File> compressImage(File file) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: file.path,
        aspectRatioPresets: [
          // CropAspectRatioPreset.square,
          // CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          // CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.ratio4x3,
          lockAspectRatio: true,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
          title: "Cropper",
          aspectRatioLockEnabled: false,
        ));
    if (croppedFile == null) {
      return null;
    }
    File compressedFile;
    try {
      compressedFile = await FlutterNativeImage.compressImage(croppedFile.path,
          quality: 25, percentage: 25);
      print("catch image done");
    } catch (e) {
      print("catch image");
      return compressedFile;
    }

    return compressedFile;
  }

  showTimerSheet(BuildContext context, Function onTap) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 250,
          color: Colors.transparent,
          child: Stack(
            fit: StackFit.expand,
            children: [
              GestureDetector(
                onTap: () {
                  onTap();
                },
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(26),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "23:59",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w700),
                      ),
                      // 16.toVerticalSpace(),
                      Text(
                        "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book.",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin: EdgeInsets.only(right: 24),
                  child: Center(
                    child: Icon(
                      Icons.access_time,
                      color: primaryColor,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Future<File> compressImagee(File file) async {


    // File croppedFile = await ImageCropper.cropImage(
    //     sourcePath: file.path,
    //
    //
    //     aspectRatioPresets: [
    //       CropAspectRatioPreset.ratio4x3
    //     ],
    //     androidUiSettings: AndroidUiSettings(
    //       toolbarTitle: 'Cropper',
    //       toolbarColor: primaryColor,
    //       toolbarWidgetColor: Colors.white,
    //       initAspectRatio: CropAspectRatioPreset.ratio4x3,
    //       lockAspectRatio: true,),
    //     iosUiSettings: IOSUiSettings(
    //       title: "Cropper",
    //     )
    // );
    // if(croppedFile == null){
    //   return null;
    // }
    try {
      file = await FlutterNativeImage.compressImage(file.path,
          quality: 70, percentage: 70);
      print("catch image done");

    } catch (e) {
      print("catch image: ${e.toString()}");
    }

    return file;

  }
}
