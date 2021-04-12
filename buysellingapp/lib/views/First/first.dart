import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:untitled/Utils/fcm_notification.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:untitled/navigation_routes.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/res/images.dart';
import 'package:untitled/Utils/my_extensions.dart';
import 'package:untitled/views/First/getXController/first_screen_controller.dart';

Position currentPosition;

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with AfterLayoutMixin<FirstScreen> {
  FcmNotification fcmNotification;
  FirstScreenController _controller = FirstScreenController();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  @override
  void initState() {
    super.initState();
    fcmNotification = FcmNotification();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    fcmNotification.init(context);

    _controller.requestLocationPermission().then((bool isGranted) async {
      if (isGranted) {
        print("granted: $isGranted");

        // AppSettings.openLocationSettings();
        await _controller.gpsService(context).then((bool isGps) {
          if (isGps == null) {
            //doing nothing
          } else if (isGps) {
            print("isGps : $isGps");
            fetchLocation();
          } else {
            print("isGps : $isGps");
            showExitDialog();
          }
        });
      } else {
        print("granted: $isGranted");
        showExitDialog();
      }
    });
  }

  showExitDialog() {
    bool canBack = false;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(canBack);
            },
            child: AlertDialog(
              title: Text("Exit from the app"),
              content: const Text(
                  'Sorry but we are taking you out of the app. This app needs to access your location and you can\'t proceed without it.'),
              actions: [
                TextButton(
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Text("Ok"),
                )
              ],
            ),
          );
        });
  }

  fetchLocation() {

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      print("got location");
      currentPosition = position;

      await Future.delayed(Duration(milliseconds: 1500));
      Get.offAndToNamed((SharedPref.getInstance().getUserId().isNullOrEmpty())
          ? NavigationRoutes.loginScreen
          : NavigationRoutes.homeScreen);
    }).catchError((e) {
      print("loc err: " + e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Container(
          width: Get.width,
          height: Get.height,
          child: Stack(
            children: [
              //topleft
              Positioned(
                left: -50,
                top: -50,
                child: circle(size: 150, color: Colors.white30),
              ),

              //topleft
              Positioned(
                left: 30,
                top: 50,
                child: circle(size: 100, color: Colors.white30),
              ),

              //topright
              Positioned(
                right: -50,
                top: -70,
                child: circle(size: 230, color: Colors.white30),
              ),

              //topright
              Positioned(
                right: 120,
                top: 150,
                child: circle(size: 25, color: Colors.white30),
              ),

              //bottomleft
              Positioned(
                left: -50,
                bottom: -50,
                child: circle(size: 200, color: Colors.white30),
              ),

              //bottomright
              Positioned(
                right: -20,
                bottom: 60,
                child: circle(size: 40, color: Colors.white30),
              ),

              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppImages.footbal,
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Mobile',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'App',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'BUY AND SELL',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              letterSpacing: 4),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Text(
                      'A wonderful serenity has taken possession\nof my entire soul',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget circle({double size, color}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
