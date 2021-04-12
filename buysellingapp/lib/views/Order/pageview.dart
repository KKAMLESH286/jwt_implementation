import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/res/images.dart';

class PageTwo extends StatefulWidget {
  @override
  PageState createState() => PageState();
}

class PageState extends State<PageTwo> {
  final controller = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 220,
                  child: PageView(
                    controller: controller,
                    onPageChanged: (page) => {print(page.toString())},
                    pageSnapping: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: Image.asset(
                              AppImages.order,
                              height: 220,
                              width: double.maxFinite,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 195, left: 30),
                            child: SmoothPageIndicator(
                              controller: controller,
                              count: 3,
                              effect: ScrollingDotsEffect(
                                dotWidth: 10,
                                dotHeight: 10,
                                radius: 8,
                                spacing: 8,
                                activeDotColor: Colors.white,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 150, right: 110, bottom: 8),
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent,
                              ),
                              child: Icon(
                                Icons.remove_red_eye,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 150, right: 90, bottom: 10),
                                child: Text(
                                  '60',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 150, right: 62, bottom: 8),
                              height: 20,
                              child: VerticalDivider(
                                color: Colors.white,
                                width: 40,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 180, right: 50, bottom: 8),
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent,
                              ),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 185, right: 28, bottom: 10),
                                child: Text(
                                  '60',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: Image.asset(
                              AppImages.order,
                              height: 220,
                              width: double.maxFinite,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 195, left: 30),
                            child: SmoothPageIndicator(
                              controller: controller,
                              count: 3,
                              effect: ScrollingDotsEffect(
                                dotWidth: 10,
                                dotHeight: 10,
                                radius: 8,
                                spacing: 8,
                                activeDotColor: Colors.white,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 150, right: 110, bottom: 8),
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent,
                              ),
                              child: Icon(
                                Icons.remove_red_eye,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 150, right: 90, bottom: 10),
                                child: Text(
                                  '60',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 150, right: 62, bottom: 8),
                              height: 20,
                              child: VerticalDivider(
                                color: Colors.white,
                                width: 40,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 180, right: 50, bottom: 8),
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent,
                              ),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 185, right: 28, bottom: 10),
                                child: Text(
                                  '70',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: Image.asset(
                              AppImages.order,
                              height: 220,
                              width: double.maxFinite,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 195, left: 30),
                            child: SmoothPageIndicator(
                              controller: controller,
                              count: 3,
                              effect: ScrollingDotsEffect(
                                dotWidth: 10,
                                dotHeight: 10,
                                radius: 8,
                                spacing: 8,
                                activeDotColor: Colors.white,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 150, right: 110, bottom: 8),
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent,
                              ),
                              child: Icon(
                                Icons.remove_red_eye,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 150, right: 90, bottom: 10),
                                child: Text(
                                  '60',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 150, right: 62, bottom: 8),
                              height: 20,
                              child: VerticalDivider(
                                color: Colors.white,
                                width: 40,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 180, right: 50, bottom: 8),
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent,
                              ),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 185, right: 28, bottom: 10),
                                child: Text(
                                  '60',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
