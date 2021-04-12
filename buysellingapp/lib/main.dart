import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:untitled/res/string.dart';
import 'package:untitled/views/test/grid.dart';
import 'navigation_routes.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPref.getInstance();
  await SharedPref.setPref();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        accentColor: Colors.blue,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
      ),
      title: APP_NAME,
      debugShowCheckedModeBanner: false,
      // home: GirdScreen(),
      initialRoute: NavigationRoutes.firstScreen,
//      initialRoute: NavigationRoutes.firstScreen,
      onGenerateRoute: NavigationRoutes.onGenerateRoute,
    );
  }
}
