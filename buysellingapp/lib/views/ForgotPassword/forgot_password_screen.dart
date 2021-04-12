import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/res/images.dart';
import 'package:untitled/views/ForgotPassword/forgot_controller.dart';


class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {

  var emailController = TextEditingController();
   var controller = Get.put(ForgotController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: GestureDetector(
                              onTap: (){
                                Get.back();
                                },
                                child: Icon(Icons.arrow_back_ios),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:60),
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Enter your email address below to \nreset your password',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:20),
                      child: Icon(Icons.email_outlined,color:Color(0XFFADADAD)),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        width: double.maxFinite,
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          autocorrect: false,
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: ('Email'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Image.asset(AppImages.circle),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
                  child: MaterialButton(
                    height:50,
                    minWidth: double.maxFinite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onPressed: (){
                      controller.getForgot(emailController.text.toString());
                    },
                    color: Color(0XFFFB596D),
                    child: Text('SEND',style: TextStyle(color: Colors.white,fontSize: 18),),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
