import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/res/images.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:untitled/Utils/my_extensions.dart';
import 'package:untitled/views/Notification/notification_controller.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController notificationController =
      NotificationController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      notificationController.getNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: Container(
          padding: EdgeInsets.only(left: 20),
          child: SvgPicture.asset(AppImages.arrow).addInkwell(onClick: () {
            Get.back();
          }),
        ),
      ),
      body: SafeArea(
        child: buildListview(),
      ),
    );
  }

  buildListview() {
    return Obx(
      () => notificationController.haveNotificationListing
          ? Container(
              height: Get.height,
              child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 55, right: 20),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    );
                  },
                  itemCount:
                      notificationController?.notificationList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return _notificationItem(index);
                  }),
            )
          : Container(
              child: Center(child: Text("No notifications yet")),
            ),
    );
  }

  Container _notificationItem(int index) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 25,
            height: 25,
            padding: EdgeInsets.only(right: 5),
            child: SvgPicture.asset(AppImages.ic_notification_bell,
                color: Colors.grey),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notificationController.notificationList[index].title,
                    style: TextStyle(
                        color: Color(0XFF7C7D7E),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Visibility(
                    visible:
                        notificationController.notificationList[index].type ==
                            "reports",
                    child: Text(
                      notificationController.notificationList[index].body,
                      style: TextStyle(
                        color: Color(
                          0XFF7C7D7E,
                        ),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 24,
          ),
          Text(
            timeago.format(DateTime.parse(
                notificationController.notificationList[index].createAt)),
            style: TextStyle(color: Color(0XFF7C7D7E)),
          ),
        ],
      ),
    );
  }
}

class Profile {
  Profile(this.image, this.text, this.value, this.icon);

  String image;
  String text;
  String value;
  String icon;
}
