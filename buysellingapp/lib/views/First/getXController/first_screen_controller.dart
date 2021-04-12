import 'dart:async';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class FirstScreenController {
  Timer timer;
  RxBool canBack = true.obs;
/*Checking if your App has been Given Permission*/
  Future<bool> requestLocationPermission() async {
    var granted = await _requestPermission(PermissionGroup.location);
    // if (granted!=true) {
    //   onPermissionDenied();
    // }
    // debugPrint('requestContactsPermission $granted');
    return granted;
  }

  Future<bool> _requestPermission(PermissionGroup permission) async {
    final PermissionHandler _permissionHandler = PermissionHandler();
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

/*Show dialog if GPS not enabled and open settings location*/
  Future<bool> _checkGps(context) async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return WillPopScope(
                onWillPop: () => Future.value(false),
                child: AlertDialog(
                  title: Text("Can't get current location"),
                  content: const Text(
                      'Please make sure you enable GPS and try again'),
                  actions: <Widget>[
                    FlatButton(child: Text('Later'),
                        onPressed: () async {
                          Get.back();
                        }),

                    FlatButton(
                        child: Text('Ok'),
                        onPressed: () async {
                          final AndroidIntent intent = AndroidIntent(
                              action:
                                  'android.settings.LOCATION_SOURCE_SETTINGS');
                          intent.launch();
                          checkGpsEnableInBg();
                          // Navigator.of(context, rootNavigator: true).pop();
                          // return await gpsService(context);
                        }),
                  ],
                ),
              );
            });

        if(timer!=null && timer.isActive) timer.cancel();
        return await Geolocator().isLocationServiceEnabled();
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  checkGpsEnableInBg() {
    timer = Timer.periodic(Duration(milliseconds: 300), (timer) async {
      if ((await Geolocator().isLocationServiceEnabled())) {
        timer.cancel();
        Get.back();
      }
    });
  }

/*Check if gps service is enabled or not*/
  Future<bool> gpsService(context) async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      return await _checkGps(context);
    } else
      return true;
  }
}
