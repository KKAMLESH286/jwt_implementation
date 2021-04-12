import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/res/images.dart';
import 'package:untitled/views/Profile/profile_controller.dart';
import 'package:untitled/views/Profile/reviews_data.dart';
import 'package:untitled/views/setting/setting_screen.dart';
import 'package:untitled/Utils/my_extensions.dart';

enum WhyFarther {
  harder,
  smarter,
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  var controller = ProfileController();
  var imageFile;
  File avatar;
  String text = 'https://medium.com/@suryadevsingh';

  List<ReviewsData> reviews = [];
  TabController controllers;
  TextEditingController avatarController =
      TextEditingController(text: SharedPref.getInstance().getAvatar());
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController =
      TextEditingController(text: SharedPref.getInstance().getEmailId());
  TextEditingController phoneController =
      TextEditingController(text: SharedPref.getInstance().getPhone());
  TextEditingController addressController =
      TextEditingController(text: SharedPref.getInstance().getAddress());

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      controller.getUserDetailsData(" ");
      controllers = new TabController(initialIndex: 0, length: 2, vsync: this);
    });
  }

  @override
  void dispose() {
    avatarController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leadingWidth: MediaQuery.of(context).size.width * 0.2,
        backgroundColor: primaryColor,
        leading: SizedBox(width: 5),
        actions: [
          PopupMenuButton<WhyFarther>(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            onSelected: (WhyFarther result) {},
            itemBuilder: (BuildContext context) => <PopupMenuEntry<WhyFarther>>[
              PopupMenuItem<WhyFarther>(
                value: WhyFarther.harder,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Get.to(SettingScreen(
                      isNoti: controller.getUserDetails.value.data.notification,
                    )).then((result) {
                      if (result != null && result == "success") {
                        controller.getUserDetailsData(SharedPref.instancee.getUserId());
                      }
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.settings,
                        color: labeltextColor,
                      ),
                      Text(
                        '  Settings',
                        style: GoogleFonts.poppins(color: labeltextColor),
                      ),
                    ],
                  ),
                ),
              ),
              PopupMenuItem<WhyFarther>(
                value: WhyFarther.harder,
                child: InkWell(
                  onTap: () {
                    controller
                        .getLogoutData(SharedPref.getInstance().getUserId());
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.logout,
                        color: labeltextColor,
                      ),
                      Text(
                        '  Logout',
                        style: GoogleFonts.poppins(color: labeltextColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: Get.height * 0.7,
          padding: EdgeInsets.only(top: 15),
          child: Column(
            children: [
              8.toVerticalSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    child: Card(
                      margin: EdgeInsets.only(top: 10, right: 10),
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: camera(context),
                    ),
                  ),
                  8.toHorizontalSpace(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            controller.getUserDetails?.value?.data?.name ?? "",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: SvgPicture.asset(AppImages.locations),
                            ),
                            Obx(
                              () => Text(
                                controller
                                        .getUserDetails?.value?.data?.address ??
                                    "",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
//                        Row(
//                          // mainAxisAlignment: MainAxisAlignment.start,
//                          children: [
//                            Padding(
//                              padding: const EdgeInsets.only(right: 5),
//                              child: SvgPicture.asset(AppImages.fb),
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.only(right: 5),
//                              child: SvgPicture.asset(AppImages.instagram),
//                            ),
//                            SvgPicture.asset(AppImages.twitter),
//                          ],
//                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.share_outlined,
                  ).addInkwell(onClick: () {
                    final RenderBox box = context.findRenderObject();
                    Share.share(text,
                        sharePositionOrigin:
                            box.localToGlobal(Offset.zero) & box.size);
                  })
                ],
              ).paddingSymmetric(horizontal: 20),
              SizedBox(height: 10),
              textField(
                emailController,
                "Email",
                SvgPicture.asset(AppImages.mail),
                true,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              textField(phoneController, "Phone",
                  SvgPicture.asset(AppImages.iphone), false),
              Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              textField(addressController, "Address",
                  SvgPicture.asset(AppImages.homes), false),
              Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: MaterialButton(
                  height: 50,
                  minWidth: double.maxFinite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  onPressed: () {
                    controller.saveProfile(
                        avatar,
                        emailController.text.trim().toString(),
                        phoneController.text.trim().toString(),
                        addressController.text.trim().toString());
                  },
                  color: Color(0XFFFB596D),
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 25),
//              Container(
//                margin: EdgeInsets.only(left: 20),
//                child: Row(
//                  children: [
//                    Text(
//                      'Reviews',
//                      style: TextStyle(
//                          color: Color(0XFFFB596D),
//                          fontWeight: FontWeight.bold,
//                          fontSize: 16),
//                    ),
//                  ],
//                ),
//              ),
//              Container(
//                child: Divider(
//                  height: 25,
//                  thickness: 2,
//                  color: Color(0XFFFB596D),
//                ),
//              ),
//                Container(
//                  padding: EdgeInsets.only(left: 20, right: 20),
//                  height: 50,
//                  width: double.maxFinite,
//                  color: Color(0XFFF2F2F2),
//                  child: Row(children: [
//                    Expanded(
//                      child: Text('How to use?'),
//                    ),
//                    Icon(Icons.chevron_right, color: Color(0XFF919191)),
//                  ]),
//                ),
//                SizedBox(height: 20),
//                Container(
//                  padding: EdgeInsets.only(left: 20, right: 20),
//                  height: 50,
//                  width: double.maxFinite,
//                  color: Color(0XFFF2F2F2),
//                  child: Row(children: [
//                    Expanded(
//                      child: Text('Contact us'),
//                    ),
//                    Icon(
//                      Icons.chevron_right,
//                      color: Color(0XFF919191),
//                    ),
//                  ]),
//                ),
//                SizedBox(
//                  height: 60,
//                  child: AppBar(
//                    backgroundColor: Colors.transparent,
//                    elevation: 0,
//                    bottom: TabBar(
//                      unselectedLabelColor: tabbartextColor,
//                      labelColor: primaryColor,
//                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                      indicatorColor: primaryColor,
//                      indicatorWeight: 3.0,
//                      tabs: [
//                        Tab(
//                          text: 'Reviews',
//                        ),
////                        Tab(
////                          text: 'Expired',
////                        ),
////                        Tab(
////                          text: 'Sold',
////                        ),
//                      ],
//                    ),
//                  ),
//                ),
              // ListView.builder(
              //     itemCount: reviewsdata.length, itemBuilder: (BuildContext context,int index){
              //       return
              // }),
//                Expanded(
//                  child: TabBarView(
//                    children: [
//                      Container(),
              // first tab bar view widget
              // ListView.builder(
              //     physics: BouncingScrollPhysics(),
              //     itemCount: reviews.length,
              //     itemBuilder: (context, index) {
              //       return ReviewTab(
              //         data: reviews.reactive,
              //       );
              //     }),
//                      ListTile(
//                        isThreeLine: true,
//                        leading: CircleAvatar(
//                          backgroundImage: NetworkImage(""),
//                        ),
//                        title: Text(
//                          'fuyggg',
//                          style: GoogleFonts.poppins(
//                            fontWeight: FontWeight.w500,
//                            fontSize: 16,
//                            color: Colors.black,
//                          ),
//                        ),
//                        subtitle: Column(
//                          children: [
//                            Row(
//                              children: [
//                                Icon(
//                                  Icons.star,
//                                  color: Colors.amber,
//                                ),
//                                Icon(
//                                  Icons.star,
//                                  color: Colors.amber,
//                                ),
//                                Icon(
//                                  Icons.star,
//                                  color: Colors.amber,
//                                ),
//                                Icon(
//                                  Icons.star,
//                                  color: Colors.amber,
//                                ),
//                              ],
//                            ),
//                            Text(
//                              'A wonderful serenit has taken possession of my entire soul.',
//                              style: GoogleFonts.poppins(
//                                textStyle: TextStyle(
//                                  fontWeight: FontWeight.w400,
//                                  fontSize: 12,
//                                  color: textColor,
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),

              // second tab bar viiew widget
//                      Container(
//                          color: Colors.pink,
//                          child: Center(
//                            child: Text(
//                              'Car',
//                            ),
//                          )),
//                      Container(
//                        color: Colors.pink,
//                        child: Center(
//                          child: Text(
//                            'Car',
//                          ),
//                        ),
//                      ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(
    TextEditingController controller,
    String text,
    SvgPicture image,
    bool readOnly,
  ) {
    return Container(
      padding: EdgeInsets.only(left: 0, right: 0),
      width: Get.width,
      child: new TextFormField(
        readOnly: readOnly,
        autofocus: false,
        controller: controller,
        // focusNode: emailFocusNode,
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
    );
    // .addOnlyPadding(left: 10, right: 10);
  }

  Future<bool> showReview(context, review) {
    showReview() {
      return showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                content: Container(
                    height: 400.0,
                    child: SingleChildScrollView(
                        child: Column(children: <Widget>[
                      Row(children: <Widget>[
                        Icon(Icons.settings),
                        Text(
                          'Settings',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Colors.black54,
                          ),
                        ),
                      ]),
                      Row(children: <Widget>[
                        Icon(Icons.logout),
                        Text(
                          'Logout',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Colors.black54,
                          ),
                        ),
                      ]),
                    ]))));
          });
    }
  }

  camera(BuildContext context) {
    return InkWell(
      onTap: () {
        _showSelectionDialog(context);
      },
      child: Obx(
        () => ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: avatar != null
              ? Image.file(
                  avatar,
                  width: double.maxFinite,
                  height: double.maxFinite,
                  fit: BoxFit.cover,
                )
              : (controller.avatarUrl.value.isNotNullOrEmpty())
                  ? Image.network(
                      Repository.profileImageUrl + controller.avatarUrl.value,
                      width: double.maxFinite,
                      height: double.maxFinite,
                      fit: BoxFit.cover,
                    )
                  : Center(child: Icon(Icons.camera_alt, size: 50)),
        ),
      ),
    );
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("From where do you want to take the photo?"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    this.setState(() {
      avatar = picture;
    });
    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    this.setState(() {
      avatar = picture;
    });
    Navigator.of(context).pop();
  }
}
