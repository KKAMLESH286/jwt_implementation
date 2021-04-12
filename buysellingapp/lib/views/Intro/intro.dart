import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/res/images.dart';
import 'package:untitled/views/Intro/pageView.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
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
                          PageOne(),
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
