import 'package:flutter/material.dart';
import 'package:untitled/views/Chat/chat_all.dart';
import 'package:untitled/views/Home/home_screen.dart';
import 'package:untitled/views/Listing/my_listing_screen.dart';
import 'package:untitled/views/Profile/profile.dart';
import 'package:untitled/views/Selling/addpost.dart';
import 'home_contoller.dart';

class BottomScreen extends StatefulWidget {
  @override
  _BottomScreenState createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  TabController controller;

  HomeController homeController = HomeController();

  final List<Widget> screens = [];

  @override
  void initState() {
    homeController = HomeController();
    screens.add(HomeScreen(homeController: homeController));
    screens.add(ChatAllScreen());
    screens.add(AddPost());
    screens.add(MyListingScreen());
    screens.add(ProfileScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0XFFFD5A60).withOpacity(1.0),
                offset: Offset(5.0, 5.0),
                spreadRadius: 7.0,
              ),
            ],
          ),
          child: ClipRRect(
            child: BottomNavigationBar(
              showSelectedLabels: true,
              // showUnselectedLabels: false,
              selectedFontSize: 14,
              // selectedIconTheme:
              unselectedFontSize: 14,
              selectedItemColor: Color(0XFFFD5A60),
              backgroundColor: Colors.white,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,

              // selectedItemColor: primaryColor,
              // iconSize: 40,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text(
                    'Home',
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_outline),
                  title: Text(
                    'Chat',
                  ),
                ),
                BottomNavigationBarItem(
                  icon: CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0XFFFD5A60),
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0XFFFD5A60),
                      ),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Icon(
                                Icons.camera_alt,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Post',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    '',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.art_track_sharp),
                  title: Text(
                    'My Listing',
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_box),
                  title: Text(
                    'Account',
                  ),
                ),
              ],
            ),
          ),
        ),
        body: screens[_currentIndex],
      ),
    );
  }
}

class Categories {
  Categories(this.image, this.text);

  String image;
  String text;
}

class Clothes {
  Clothes(this.image, this.texts, this.value);
  String image;
  String texts;
  String value;
}
