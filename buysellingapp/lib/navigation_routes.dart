import 'package:flutter/material.dart';
import 'package:untitled/views/Chat/chat_screen.dart';
import 'package:untitled/views/First/first.dart';
import 'package:untitled/views/ForgotPassword/forgot_password_screen.dart';
import 'package:untitled/views/Home/home.dart';
import 'package:untitled/views/Listing/my_listing_screen.dart';
import 'package:untitled/views/Notification/notification.dart';
import 'package:untitled/views/Profile/profile.dart';
import 'package:untitled/views/ResetPassword/reset_pswd.dart';
import 'package:untitled/views/Selling/addPostScreen.dart';
import 'package:untitled/views/Selling/addpost.dart';
import 'package:untitled/views/SignUp/signup_screen.dart';
import 'package:untitled/views/addthree/addthree.dart';
import 'package:untitled/views/filter/filter_screen.dart';
import 'package:untitled/views/login/login_screen.dart';
import 'package:untitled/views/setting/setting_screen.dart';

import 'views/Listing/tabScreens/wishlist_tab_screen.dart';

class NavigationRoutes {
  static const String splash = "/Splash";
  static const String firstScreen = "/FirstScreen";
  static const String loginScreen = "/LoginScreen";
  static const String signUpScreen = "/SignUpScreen";
  static const String homeScreen = "/HomeScreen";
  static const String forgotScreen = "/ForgotScreen";
  static const String profileScreen = "/Profile";
  static const String notificationScreen = "/NotificationScreen";
  static const String changePasswordScreen = "/ResetPasswordScreen";
  static const String listingSellingScreen = "/ListingSelling";
  static const String filterScreen = "/FilterScreen";
  static const String settingScreen = "/SettingScreen";
  static const String sellingScreen = "/SellingScreen";
  static const String addPost = "/AddPost";
  static const String wishItemScreen = "/WishItemScreen";
  static const String addPostScreen = "/AddPostScreen";
  static const String chatScreen = "/ChatScreen";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case firstScreen:
        return MaterialPageRoute(builder: (context) => FirstScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case signUpScreen:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (context) => BottomScreen());
      case forgotScreen:
        return MaterialPageRoute(builder: (context) => ForgotScreen());
      case profileScreen:
        return MaterialPageRoute(builder: (context) => ProfileScreen());
      case notificationScreen:
        return MaterialPageRoute(builder: (context) => NotificationScreen());
      case changePasswordScreen:
        return MaterialPageRoute(builder: (context) => ResetPasswordScreen());
      case listingSellingScreen:
        return MaterialPageRoute(builder: (context) => MyListingScreen());
//      case filterScreen:
//        return MaterialPageRoute(builder: (context) => FilterScreen());

      // case sellingScreen:
      //   return MaterialPageRoute(builder: (context) => SellingScreen());
      case addPost:
        return MaterialPageRoute(builder: (context) => AddPost());
      // case chatScreen:
      //   return MaterialPageRoute(builder: (context) => ChatScreen());
      // case sellingScreen:
      //   return MaterialPageRoute(builder: (context) => AddThree());
      // case wishItemScreen:
      //   return MaterialPageRoute(builder: (context) => WishListTabScreen());
    }
  }
}
