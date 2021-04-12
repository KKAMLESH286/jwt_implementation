import 'dart:convert';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:untitled/navigation_routes.dart';

class FcmNotification {
  FirebaseMessaging firebaseMessaging;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  BuildContext context;

  init(mContext) {
    this.context = mContext;
    firebaseMessaging = FirebaseMessaging();

    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _handleNotificationClick);

    getMessage();
  }

  Future _handleNotificationClick(String payload) async {
    //we will receive data here
    print("gate 1: $payload");
    if (payload != null) {
      print("gate 1.1: $payload");
      print("gate 2.0: ${json.decode(payload).toString()}");
      Map response = json.decode(payload);
      // final screen = response["screen"];
      // final addId = response["addId"];
      print("gate 2");
      // if (screen != null &&
      //     screen.toString().isNotEmpty &&
      //     (screen.toString() == "new_offer" ||
      //         screen.toString() == "new_comment")) {
      //   print("gate 3");
      //   try {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(builder: (context) => HomeItem(adId: addId)),
      //     );
      //   } catch (e) {
      //     print("gate 4: ${e}");
      //   }
      // }
    }
  }

  void getMessage() {
    firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('on message $message');
          Map data = message["data"];
          print("currentRoute: ${Get.currentRoute}");
          if(data != null && Get.currentRoute != NavigationRoutes.chatScreen && data["type"] != "chats") {
            _showNotificationWithDefaultSound(message);
          }
        },
        onBackgroundMessage: myBackgroundMessageHandler,
        onResume: (Map<String, dynamic> message) async {
          print('on resume $message');
        },
        onLaunch: (Map<String, dynamic> message) async {
          print('on launch $message');
        });
    if (Platform.isIOS) iosSettings();
  }

  Future _showNotificationWithDefaultSound(Map message) async {
    print(message);
    Map notification = message["notification"];
    var title = notification["title"];
    var body = notification["body"];

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'BuyingSellingChannel',
        'Notification Channel',
        'This is simple notification.',
        //        sound: 'default',
        importance: Importance.max,
        priority: Priority.high);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    Map data = message["data"];
    print("checkingdataconversion: ${json.encode(data)}");
    await flutterLocalNotificationsPlugin.show(
      54,
      title,
      body,
      platformChannelSpecifics,
      payload: json.encode(data),
    );
  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  void iosSettings() {
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}
