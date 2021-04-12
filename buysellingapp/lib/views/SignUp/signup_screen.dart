import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/views/SignUp/signup_controller.dart';
import 'package:untitled/views/login/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool valuefirst = false;

  UserType _userType = UserType.buyer;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var genderController = TextEditingController();

  var controller = Get.put(SignupController());

  final List<DropdownMenuItem> genderItems = [
    DropdownMenuItem(
        value: "Male",
        child: Text(
          "Male",
          style: GoogleFonts.sourceSansPro(fontSize: 16.0, color: Colors.black),
        )),
    DropdownMenuItem(
        value: "Female",
        child: Text(
          "Female",
          style: GoogleFonts.sourceSansPro(fontSize: 16.0, color: Colors.black),
        )),
  ];

  var genderSelected = null;

  void _onSignUpClick() {
    controller.getSignUp(
        nameController.text.toString(),
        emailController.text.toString(),
        passwordController.text.toString(),
        phoneController.text.toString(),
        addressController.text.toString(),
        valuefirst,
        genderSelected);
  }

  @override
  Widget build(BuildContext context) {
    print(_userType);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Text(
                          'Signup',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Create your account!',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  // Container(
                  //   padding: EdgeInsets.only(left: 10),
                  //   child: Stack(
                  //     children: [
                  //       buildFlexibleSeller('Seller'),
                  //       buildFlexiblebuyer('Buyer'),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            //Image.asset(AppImages.user,color:Color(0XFFADADAD)),
                            Icon(Icons.account_circle_outlined,
                                color: Color(0XFFADADAD)),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 20),
                                width: double.maxFinite,
                                child: TextField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    labelText: ('Full Name'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.email_outlined,
                                color: Color(0XFFADADAD)),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 20),
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
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.lock_outline, color: Color(0XFFADADAD)),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 20),
                                width: double.maxFinite,
                                child: TextField(
                                  obscureText: true,
                                  autocorrect: false,
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    labelText: ('Password'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.phone_android, color: Color(0XFFADADAD)),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 20),
                                width: double.maxFinite,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: phoneController,
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    labelText: ('Phone'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.home, color: Color(0XFFADADAD)),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 20),
                                width: double.maxFinite,
                                child: TextField(
                                  controller: addressController,
                                  decoration: InputDecoration(
                                    labelText: ('Address'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.accessibility, color: Color(0XFFADADAD)),
                            Expanded(
                              child: genderDropDown,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
//                          margin: EdgeInsets.only(left: 20,),
                          child: Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.black,
                                activeColor: Color(0XFF7C7D7E),
                                value: valuefirst,
                                onChanged: (value) {
                                  setState(() {
                                    valuefirst = value;
                                  });
                                },
                              ),
//                        Padding(
//                          padding: const EdgeInsets.only(right: 10),
//                          child: Image.asset(AppImages.checkkbox),
//                        ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text.rich(
                                  TextSpan(
                                    text: 'I agree to the ',
                                    style: TextStyle(color: Color(0XFF7C7D7E)),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Terms of Services ',
                                          style: TextStyle(
                                            color: Color(0XFFFB596D),
                                            decoration:
                                                TextDecoration.underline,
                                          )),
                                      TextSpan(
                                        text: 'and',
                                        style: TextStyle(
                                          color: Color(0XFF7C7D7E),
                                        ),
                                      ),
                                      TextSpan(
                                        text: '\n Privacy Policy.',
                                        style: TextStyle(
                                          color: Color(0XFFFB596D),
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: MaterialButton(
                      height: 50,
                      minWidth: double.maxFinite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Color(0XFFFB596D),
                      onPressed: _onSignUpClick,
                      child: Text(
                        'Signup',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an Account? ",
                          style: TextStyle(color: Color(0XFF7C7D7E)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(LoginScreen());
                          },
                          child: Text(
                            'Login',
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

  Widget get genderDropDown {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 20),
      child: DropdownButtonFormField(
        isDense: true,
        hint: Text(
          "Select gender",
          style: TextStyle(color: Colors.black54, fontSize: 16),
        ),
        value: genderSelected,
        items: genderItems,
        onChanged: (data) {
          setState(() {
            genderSelected = data;
          });
        },
      ),
    );
  }

  Container buildFlexibleBuyer(text) {
    return Container(
      child: GestureDetector(
        onTap: () {
          // selectedWidget = "1";
          if (_userType == UserType.seller) {
            setState(() {
              _userType = UserType.buyer;
              // selectedWidget = "buyer";
            });
          }
        },
        child: Container(
            width: Get.width * 0.5,
            height: Get.height * 0.07,
            decoration: BoxDecoration(
              color: (_userType == UserType.buyer) ? primaryColor : buttonColor,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: GoogleFonts.sourceSansPro(
                  color: (_userType == UserType.buyer)
                      ? Colors.white
                      : labeltextColor,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )),
      ),
    );
  }

  Container buildFlexibleSeller(text) {
    return Container(
      child: GestureDetector(
        onTap: () {
          if (_userType == UserType.buyer) {
            setState(() {
              _userType = UserType.seller;
              // selectedWidget = "seller";
            });
          } else {
            return;
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 150, right: 0.0),
          child: Container(
              width: Get.width * 0.5,
              height: Get.height * 0.07,
              decoration: BoxDecoration(
                color:
                    (_userType == UserType.seller) ? primaryColor : buttonColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: (_userType == UserType.seller)
                        ? Colors.white
                        : labeltextColor,
                    fontSize: 14.0,
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

enum UserType { buyer, seller }
