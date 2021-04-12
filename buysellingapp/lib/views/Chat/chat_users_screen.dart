import 'package:flutter/material.dart';
import 'package:untitled/res/images.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 30, left: 10, right: 5),
                  height: 100,
                  width: double.maxFinite,
                  color: Color(0XFFFB596D),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          ClipOval(
                            child: Image.asset(
                              AppImages.profile,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Jasmine Shen',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Last online today at 2:00pm',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            'asset/Path 24.png',
                            height: 20,
                            width: 20,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: double.maxFinite,
                  color: Color(0XFFFFFFFF),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Green Top'),
                      ),
                      Text("\$1234"),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text('Today'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 5, right: 12),
                            child: Text('3 hr ago',
                              style: TextStyle(color: Color(0XFF717171)),),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 0.2,
                                ),
                              ],
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: ClipOval(
                                child: Image.asset(AppImages.profile,
                                    width: 45, height: 45, fit: BoxFit.cover)),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.only(
                                  left: 20, top: 15, bottom: 16),
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: Text(
                                'Reference site about Lorem Ipsum,giving information.',
                                style: TextStyle(color: Color(0XFF717171)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 10, left: 10),
                              padding: EdgeInsets.only(
                                  left: 20, top: 15, bottom: 16),
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: Text(
                                'Reference site about Lorem Ipsum,giving information.',
                                style: TextStyle(color: Color(0XFF717171)),
                              ),
                            ),
                          ),
                          ClipOval(
                              child: Image.asset(AppImages.chats_a,
                                  width: 45, height: 45, fit: BoxFit.cover)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 5, left: 12),
                            child: Text('3 hr ago',
                              style: TextStyle(color: Color(0XFF717171)),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 250,),
                Container(
                  padding: EdgeInsets.only(left:15,right: 15),
                  height: 60,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Image.asset(AppImages.pin,height: 20,width: 20,color: Color(0XFF848484),),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top:5,left: 20),
                          height: 60,
                          width: double.maxFinite,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Type here...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Image.asset(AppImages.mic,height: 20,width: 20,color: Color(0XFF848484),),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent,
                        ),
                        child: Image.asset(AppImages.send,color: Colors.white,),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
