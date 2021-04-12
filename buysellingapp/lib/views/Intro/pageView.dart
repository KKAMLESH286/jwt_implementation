import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/res/images.dart';

class PageOne extends StatefulWidget {
  @override
  PageState createState() => PageState();
}

class PageState extends State<PageOne> {
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
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 70),
                      child: Column(
                        children: [
                          Center(child: Image.asset(AppImages.layerIntro)),
                        ],
                      ),
                    ),
                    Container(
                      height: 750,
                      child: PageView(
                        controller: controller,
                        onPageChanged: (page) => {print(page.toString())},
                        pageSnapping: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 370),
                            height: 350,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                              color: Color(0XFFFB596D),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 20),
                                      Text(
                                        'A wonderful serenity',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        'A wonderful serenity has taken possession of my entire soul,'
                                            'like these sweet mornings of spring '
                                            'which i enjoy with my whole heart. '
                                            'I am alone, '
                                            'and feel the charm of existence in this spot,'
                                            'which was created for the bliss of souls like mine.',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15,height: 2),
                                      ),
                                      SizedBox(height: 20),
                                      Container(
                                        child: SmoothPageIndicator(
                                          controller: controller,
                                          count: 3,
                                          effect: ScrollingDotsEffect(
                                            dotWidth: 14,
                                            dotHeight: 14,
                                            radius: 8,
                                            spacing: 8,
                                            activeDotColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 40),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: MaterialButton(
                                          height: 50,
                                          minWidth: 100,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              bottomRight: Radius.circular(30),
                                            ),
                                          ),
                                          onPressed: () {},
                                          color: Color(0XFFF2F2F2),
                                          child: Center(
                                            child: Text(
                                              'SKIP',
                                              style:
                                              TextStyle(color: Color(0XFF7C7D7E)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: MaterialButton(
                                          height: 50,
                                          minWidth: 100,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              bottomLeft: Radius.circular(30),
                                            ),
                                          ),
                                          onPressed: () {},
                                          color: Colors.white,
                                          child: Center(
                                            child: Text(
                                              'NEXT',
                                              style: TextStyle(
                                                color: Color(0XFFFB596D),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 370),
                            height: 350,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                              color: Color(0XFFFB596D),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 20),
                                      Text(
                                        'A wonderful serenity',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        'A wonderful serenity has taken possession of my entire soul,'
                                            'like these sweet mornings of spring '
                                            'which i enjoy with my whole heart. '
                                            'I am alone, '
                                            'and feel the charm of existence in this spot,'
                                            'which was created for the bliss of souls like mine.',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15,height: 2),
                                      ),
                                      SizedBox(height: 20),
                                      Container(
                                        child: SmoothPageIndicator(
                                          controller: controller,
                                          count: 3,
                                          effect: ScrollingDotsEffect(
                                            dotWidth: 14,
                                            dotHeight: 14,
                                            radius: 8,
                                            spacing: 8,
                                            activeDotColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 40),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: MaterialButton(
                                          height: 50,
                                          minWidth: 100,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              bottomRight: Radius.circular(30),
                                            ),
                                          ),
                                          onPressed: () {},
                                          color: Color(0XFFF2F2F2),
                                          child: Center(
                                            child: Text(
                                              'SKIP',
                                              style:
                                              TextStyle(color: Color(0XFF7C7D7E)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: MaterialButton(
                                          height: 50,
                                          minWidth: 100,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              bottomLeft: Radius.circular(30),
                                            ),
                                          ),
                                          onPressed: () {},
                                          color: Colors.white,
                                          child: Center(
                                            child: Text(
                                              'NEXT',
                                              style: TextStyle(
                                                color: Color(0XFFFB596D),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 370),
                            height: 350,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                              color: Color(0XFFFB596D),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 20),
                                      Text(
                                        'A wonderful serenity',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        'A wonderful serenity has taken possession of my entire soul,'
                                            'like these sweet mornings of spring '
                                            'which i enjoy with my whole heart. '
                                            'I am alone, '
                                            'and feel the charm of existence in this spot,'
                                            'which was created for the bliss of souls like mine.',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15,height: 2),
                                      ),
                                      SizedBox(height: 20),
                                      Container(
                                        child: SmoothPageIndicator(
                                          controller: controller,
                                          count: 3,
                                          effect: ScrollingDotsEffect(
                                            dotWidth: 14,
                                            dotHeight: 14,
                                            radius: 8,
                                            spacing: 8,
                                            activeDotColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 40),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: MaterialButton(
                                          height: 50,
                                          minWidth: 100,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              bottomRight: Radius.circular(30),
                                            ),
                                          ),
                                          onPressed: () {},
                                          color: Color(0XFFF2F2F2),
                                          child: Center(
                                            child: Text(
                                              'SKIP',
                                              style:
                                              TextStyle(color: Color(0XFF7C7D7E)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: MaterialButton(
                                          height: 50,
                                          minWidth: 100,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              bottomLeft: Radius.circular(30),
                                            ),
                                          ),
                                          onPressed: () {},
                                          color: Colors.white,
                                          child: Center(
                                            child: Text(
                                              'NEXT',
                                              style: TextStyle(
                                                color: Color(0XFFFB596D),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}