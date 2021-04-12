import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/res/images.dart';
import 'package:untitled/views/First/first.dart';
import 'package:untitled/views/Profile/profile.dart';
import 'package:untitled/views/setting/setting_controller.dart';
import 'package:untitled/Utils/my_extensions.dart';

class SettingScreen extends StatefulWidget {
  final bool isNoti;

  const SettingScreen({Key key, this.isNoti}) : super(key: key);

  // const SettingScreen({Key key, @required this.isNoti}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SettingController settingController = SettingController();

  @override
  void initState() {
    settingController.isSwitched.value = widget.isNoti ?? false;
    super.initState();
  }

  _onBackPress() {
    if(settingController.isSuccess == "success") {
      Get.back(result: "success");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _onBackPress();
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          leadingWidth: 52,
          backgroundColor: primaryColor,
          automaticallyImplyLeading: false,
          leading: Container(
            padding: EdgeInsets.only(left: 20),
            child: SvgPicture.asset(AppImages.arrow).addInkwell(onClick: () {
              if (settingController.isSuccess == "success") {
                Get.back(result: "success");
              } else {
                Get.back();
              }
            }),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: Get.height * 0.86,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                settingText(
                  'Notification',
                ).paddingOnly(left: 20, top: 15),
                Row(
                  children: [
                    SvgPicture.asset(AppImages.notification),
                    Expanded(
                      child: Text(
                        'Push Notification',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                            color: textColor,
                          ),
                        ),
                      ).addLeftPadding(10),
                    ),
                    Obx(
                      () => FlutterSwitch(
                        height: 22.0,
                        width: 42.0,
                        padding: 3.0,
                        toggleSize: 18.0,
                        borderRadius: 13.0,
                        activeColor: primaryColor,
                        value: settingController.isSwitched.value,
                        onToggle: (b) {
                          settingController.isSwitched.value = b;
                          settingController.postNotification();
                        },
                      ),
                    )
                  ],
                ).addOnlyPadding(left: 19, right: 15, top: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20, top: 5),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                settingText(
                  'Support',
                ).paddingOnly(
                  left: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      'How to use?',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: textColor,
                        ),
                      ),
                    )),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: borderColor,
                      size: 20,
                    ).addInkwell(onClick: () {}),
                  ],
                ).addOnlyPadding(right: 15, left: 19),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20, top: 5),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                settingText(
                  'Contact us',
                ).paddingOnly(left: 20, top: 5),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Contact us',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: textColor,
                        ),
                      ),
                    )),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: borderColor,
                      size: 20,
                    ).addInkwell(onClick: () {}),
                  ],
                ).addOnlyPadding(right: 15, left: 19),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20, top: 5),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                settingText(
                  'Privacy Policy',
                ).paddingOnly(left: 20, top: 5),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Privacy Policy',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: textColor,
                        ),
                      ),
                    )),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: borderColor,
                      size: 20,
                    ).addInkwell(onClick: () {})
                  ],
                ).addOnlyPadding(right: 15, left: 19),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20, top: 5),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                settingText(
                  'Terms of Services',
                ).paddingOnly(left: 20, top: 5),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Terms of Services',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: textColor,
                        ),
                      ),
                    )),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: borderColor,
                      size: 20,
                    ).addInkwell(onClick: () {}),
                  ],
                ).addOnlyPadding(right: 15, left: 19),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20, top: 5),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                Spacer(),
                Container(
                  width: double.maxFinite,
                  height: 60,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(),
                    onPressed: () {
                      settingController
                          .getLogoutData(SharedPref.getInstance().getUserId());
//                    SharedPref.getInstance().clear();
//                    Get.offAll(FirstScreen());
                    },
                    color: primaryColor,
                    child: Center(
                      child: Text(
                        'Logout',
                        style: GoogleFonts.sourceSansPro(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
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
          ),
        ),
      ),
    );
  }

  Text notfication(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 17,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget textField(TextEditingController controller, String text,
      SvgPicture image, TextInputType keyboardtype) {
    return Container(
      padding: EdgeInsets.only(left: 0, right: 0),
      width: Get.width,
      child: new TextFormField(
        keyboardType: keyboardtype,
        autofocus: false,
        controller: controller,
        style: TextStyle(
          fontSize: 15.0,
        ),
        obscureText: false,
        autocorrect: false,
        decoration: new InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14.0),
            child: image,
          ),
          border: UnderlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.all(12),
          labelText: text,
          labelStyle:
              GoogleFonts.poppins(color: labeltextColor, fontSize: 14.0),
        ),
      ),
    ).addOnlyPadding(left: 10, right: 10);
  }

  Text settingText(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 17,
          color: Colors.black,
        ),
      ),
    );
  }

//  Container buildFlexibledonor(text) {
//    return Container(
//      child: GestureDetector(
//        onTap: () {
//          if (_userType == UserType.recipient) {
//            setState(() {
//              _userType = UserType.donor;
//              // selectedWidget = "donor";
//            });
//          }
//        },
//        child: Container(
//            width: Get.width * 0.5,
//            height: Get.height * 0.07,
//            decoration: BoxDecoration(
//              color: (_userType == UserType.donor) ? primaryColor : buttonColor,
//              borderRadius: BorderRadius.circular(30.0),
//            ),
//            child: Center(
//              child: Text(
//                text,
//                textAlign: TextAlign.center,
//                style: GoogleFonts.sourceSansPro(
//                  color: (_userType == UserType.donor)
//                      ? Colors.white
//                      : labeltextColor,
//                  fontSize: 15.0,
//                  fontWeight: FontWeight.w600,
//                ),
//              ),
//            )),
//      ),
//    );
//  }

//  Container buildFlexibleRecipint(text) {
//    return Container(
//      child: GestureDetector(
//        onTap: () {
//          if (_userType == UserType.donor) {
//            setState(() {
//              _userType = UserType.recipient;
//              // selectedWidget = "recipient";
//            });
//          } else {
//            return;
//          }
//        },
//        child: Padding(
//          padding: const EdgeInsets.only(left: 160, right: 0.0),
//          child: Container(
//              width: Get.width * 0.5,
//              height: Get.height * 0.07,
//              decoration: BoxDecoration(
//                color: (_userType == UserType.recipient)
//                    ? primaryColor
//                    : buttonColor,
//                borderRadius: BorderRadius.circular(30.0),
//              ),
//              child: Center(
//                child: Text(
//                  text,
//                  textAlign: TextAlign.center,
//                  style: GoogleFonts.poppins(
//                    color: (_userType == UserType.recipient)
//                        ? Colors.white
//                        : labeltextColor,
//                    fontSize: 14.0,
//                  ),
//                ),
//              )),
//        ),
//      ),
//    );
//  }

//  void _onDropDownItemSelected(String newValueSelected) {
//    setState(() {
//      this._currentItemSelected = newValueSelected;
//    });
//  }
}

//enum UserType { donor, recipient }
