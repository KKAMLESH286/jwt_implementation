import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:untitled/res/images.dart';
import 'package:untitled/views/ForgotPassword/forgot_password_screen.dart';
import 'package:untitled/views/SignUp/signup_screen.dart';
import 'package:untitled/views/login/login_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool valuefirst=false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Add your details to login!',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        autocorrect: false,
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Container(
                            margin: EdgeInsets.only(left: 20, right: 15),
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(0XFF898989),
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.email_outlined,
                              size: 15,
                              color: Color(0XFF898989),
                            ),
                          ),
                          hintText: 'Your Email',
                          fillColor: Color(0XFFF2F2F2),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: TextField(
                        obscureText: true,
                        autocorrect: false,
                        controller: passwordController,
                        decoration: InputDecoration(
                          prefixIcon: Container(
                            margin: EdgeInsets.only(left: 20, right: 15),
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(0XFF898989),
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.lock_outline,
                              size: 15,
                              color: Color(0XFF898989),
                            ),
                          ),
                          hintText: 'Your Password',
                          fillColor: Color(0XFFF2F2F2),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Get.to(ForgotScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 150),
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(color: Color(0XFF7C7D7E)),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: MaterialButton(
                      height: 50,
                      minWidth: double.maxFinite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        controller.getLogin(
                          emailController.text.toString(),
                          passwordController.text.toString(),
                        );
                      },
                      color: Color(0XFFFB596D),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: Divider(
                      color: Color(0XFFCBCBCB),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'or Login with',
                    style: TextStyle(color: Color(0XFF7C7D7E)),
                  ),
                  SizedBox(height: 30),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: MaterialButton(
                      height: 50,
                      minWidth: double.maxFinite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {},
                      color: Color(0XFF367FC0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Image.asset(
                              AppImages.facebook,
                              height: 20,
                              width: 20,
                            ),
                          ),
                          // SvgPicture.asset('asset/Facebook.svg'),
                          Text(
                            'Login with Facebook',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: MaterialButton(
                      height: 50,
                      minWidth: double.maxFinite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {},
                      color: Color(0XFFDD4B39),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.google,
                            height: 20,
                            width: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Image.asset(AppImages.plus),
                          ),
                          Text(
                            'Login with Google',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an Account? ",
                          style: TextStyle(color: Color(0XFF7C7D7E)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(SignUpScreen());
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0XFFFB596D)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
