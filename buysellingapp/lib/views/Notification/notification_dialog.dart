import 'package:flutter/material.dart';
import 'package:untitled/res/images.dart';

class NotificationDialog extends StatefulWidget {
  @override
  _NotificationDialogState createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: SafeArea(
  child: SingleChildScrollView(
    child: Container(
      margin: EdgeInsets.only(top: 200,left: 20,right: 20),
      padding: EdgeInsets.only(left: 20,top: 10),
      height: 210,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  AppImages.profile,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jasmine has sent yoy the jacket offer!',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0XFFFB596D),),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(children: [
                    Expanded(
                      child: Text('Meet Up',style: TextStyle(color: Color(0XFFFB596D),),),
                    ),
                    Icon(Icons.chevron_right, color: Color(0XFFFB596D),),
                  ]),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(  color: Color(0XFFFB596D),),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(children: [
                    Expanded(
                      child: Text('Ship Item',style: TextStyle(color: Color(0XFFFB596D)),),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Color(0XFFFB596D),
                    ),
                  ]),
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

